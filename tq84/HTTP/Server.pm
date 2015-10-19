package tq84::HTTP::Server;

use tq84::TCP::Server;
use tq84::HTTP::Request;
use IO::Select;
use Time::localtime;
use threads;
use threads::shared;

my $next_connection_id;
my $callback;
share($next_connection_id);
$next_connection_id = 1;

my $own_connection_id;

my %options;

my $FIONREAD = 1074030207; # --> https://github.com/ReneNyffenegger/perl-tcp/blob/master/misc/FIONBIO-FIONREAD-SIOCATMARK.c

my $sem :shared;

sub start { # {{{
    
    my $host     = shift;
    my $port     = shift;
       $callback = shift;

       %options  = @_;

    if ($options{log_file}) {
      open ($options{log_file_handle}, '>', $options{log_file});
      my $ofh = select $options{log_file_handle}; $|=1; select $ofh;
    }

    tq84::TCP::Server::start($host, $port, \&new_connection);

} # }}}

sub new_connection { # {{{

  $own_connection_id = $next_connection_id;
  $next_connection_id++;

  log_("New connection");

  my $socket = shift;
  binmode $socket;

  my $select = IO::Select->new();

  $select -> add ($socket);

  while (1) {

    if ($select->can_read) {
      my $raw_request_data = read_pending($socket);

      last unless defined $raw_request_data;

      my $request = new tq84::HTTP::Request($socket, $raw_request_data);

      log_("New request " . $request->{path});

      &$callback($request);
    }
    else {
      print "  can't read\n";
    }

  }
 
  log_("going to close connection");

  $socket->close;

} # }}}

sub log_ { # {{{

    return unless $options{log_file_handle};

    my $text = shift;

    lock $sem;
    printf { $options{log_file_handle} }
    "%02d:%02d:%02d %02d.%02d.%d [%6d] %s\n",
        localtime -> hour,
        localtime -> min,
        localtime -> sec,
        localtime -> mday,
        localtime -> mon   +    1,
        localtime -> year  + 1900,
        $own_connection_id,
        $text
    or die;
    
} # }}}

sub read_pending { # {{{

    my $socket = shift;

    my $buf;

    while (1) {

      my $size = pack("L", 0);

    # TODO: Use http://stackoverflow.com/a/33206116/180275 instead?
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
