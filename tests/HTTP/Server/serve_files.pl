use warnings;
use strict;

use File::Slurp;

use lib '../../..';
use tq84::HTTP::Server;

tq84::HTTP::Server::start('localhost', 1234, \&request);

sub request { # {{{

    my $request = shift;

    my $path = $request->{path};

    $path = 'index.html' if $path eq '/';

    $path = "./$path";
    print "  path=$path\n";

    if (-e $path) { $request -> answer('200 OK'       , 'text/html' ,  scalar read_file($path)   ); }
    else          { $request -> answer('404 Not Found', 'text/plain', 'Path $path does not exist'); }
    
} # }}}
