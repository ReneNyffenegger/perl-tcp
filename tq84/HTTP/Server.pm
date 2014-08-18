package tq84::HTTP::Server;

use tq84::TCP::Server;
use tq84::HTTP::Request;
use IO::Select;
use threads::shared;

my $connection_counter;
my $callback;
share($connection_counter);
$connection_counter = 0;

my $FIONREAD = 1074030207; # --> https://github.com/ReneNyffenegger/perl-tcp/blob/master/misc/FIONBIO-FIONREAD-SIOCATMARK.c

sub start { # {{{
    
    my $host     = shift;
    my $port     = shift;
       $callback = shift;

    tq84::TCP::Server::start($host, $port, \&new_connection);

} # }}}

sub new_connection { # {{{

  $connection_counter++;
  print "\nnew connection $connection_counter\n";

  my $socket = shift;
  binmode $socket;

  my $select = IO::Select->new();

  $select -> add ($socket);

   while (1) {

    if ($select->can_read) {
      my $raw_request_data = read_pending($socket);

      last unless defined $raw_request_data;

      my $request = new tq84::HTTP::Request($socket, $raw_request_data);

      &$callback($request);
    }
    else {
      print "  can't read\n";
    }

  }

 
  print "\ngoing to close connection $connection_counter\n";

  $socket->close;

} # }}}

sub read_pending { # {{{

    my $socket = shift;

    my $buf;

    while (1) {

      my $size = pack("L", 0);
      ioctl($socket, $FIONREAD, $size) or die "Couldn't call ioctl: $!\n";
      $size = unpack("L", $size);

      last unless $size;

      my $buf_;

      $socket -> recv($buf_, $size);
      $buf .= $buf_;
   }

   return $buf;

} # }}}

1;
