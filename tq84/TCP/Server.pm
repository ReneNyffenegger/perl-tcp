package tq84::TCP::Server;

use IO::Socket;
use IO::Select;
use IO::Socket::INET;
use threads;
use threads::shared;

sub start { # {{{

    my $host     = shift;
    my $port     = shift;
    my $callback = shift;

    my $socket_ = new IO::Socket::INET (
        LocalHost   =>  $host,   #  or  '0.0.0.0'  ?
        LocalPort   =>  $port,
        Proto       => 'tcp',
        Listen      =>  1,
        Reuse       =>  1
    ) or die "Cannot create socket";


    while (1) {
      my $client_socket = $socket_->accept();
      threads->create($callback, $client_socket);
    }

    $socket_ -> close;
    
} # }}}

1;
