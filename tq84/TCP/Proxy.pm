package tq84::TCP::Proxy;

use warnings;
use strict;

use tq84::TCP::Server;

my $connection_counter = 0;
my $local_host;
my $local_port;
my $remote_host;
my $remote_port;
my $callback;

sub start { # {{{

    $local_host  = shift;
    $local_port  = shift;
    $remote_host = shift;
    $remote_port = shift;
    $callback    = shift;

    my $connection_counter = 0;

    tq84::TCP::Server::start($local_host, $local_port, \&connection);
    
} # }}}


sub connection {

# The socket that talks to the client (from TCP_Server!)
  my $client_socket      = shift;  
  $connection_counter ++;


# The socket that talks to the server:
  my $server_socket = new IO::Socket::INET (
                 PeerAddr    => $remote_host,
                 PeerPort    => $remote_port,
                 Proto       => 'tcp',
                 Timeout     =>  1
             ) 
             or die "Could not connect";

  binmode $client_socket;
  binmode $server_socket;

  &$callback('new connection', $connection_counter, $client_socket, $server_socket);

  my $select = IO::Select->new();

  $select -> add ($client_socket);
  $select -> add ($server_socket);

  while (1) {

    while (my @ready = $select -> can_read) {

      for my $s (@ready) {

        if ($s == $client_socket) {

          my $buf;
          $client_socket->recv($buf, 1024) ;
          unless ($buf) {
            $server_socket->close();
            &$callback('client closed', $connection_counter);
            return;
          }
          &$callback('client says', $connection_counter, \$buf);

          $server_socket->send( $buf);
        }
        else {
          my $buf;
          $server_socket->recv($buf, 1024); 
          unless ($buf) {
            &$callback('server closed', $connection_counter);
            $client_socket->close();
            return;
          }

          &$callback('server says', $connection_counter, \$buf);

          $client_socket -> send($buf);
        }
      }
    }
  }
}

1;
