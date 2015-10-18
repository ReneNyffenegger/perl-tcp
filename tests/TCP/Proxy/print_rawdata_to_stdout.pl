use warnings;
use strict;

use lib '../../..';
use tq84::TCP::Proxy;

tq84::TCP::Proxy::start( 'localhost', 8888, 'localhost', 80, \&callback);


sub callback {

    my $action             = shift;
    my $connection_counter = shift;

    if    ($action eq 'new connection') {

       my $client_socket = shift;
       my $server_socket = shift;

       print "New connection $connection_counter\n";
       
       my $client_address = $client_socket->peerhost;
       my $client_port    = $client_socket->peerport;
       my $server_address = $server_socket->peerhost;
       my $server_port    = $server_socket->peerport;

       print "  client: $client_address:$client_port\n";
       print "  server: $server_address:$server_port\n";

    }
    elsif ($action eq 'server closed') {
       print "server closed: $connection_counter\n";
    }
    elsif ($action eq 'client closed') {
       print "server closed: $connection_counter\n";
    }
    else {

       my $buf_ref = shift;
       my $data    = $$buf_ref;

       $data =~ s/[^[:print:]]/./g;

       print "$action [$connection_counter]: $data\n";
    }
}

