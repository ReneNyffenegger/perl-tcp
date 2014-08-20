#
#   Firefox:
#     about:config
#     -> network.http.max-persistent-connections-per-server
#
use warnings; use strict;

use lib '../../..';
use tq84::HTTP::Server;

use File::Slurp;

tq84::HTTP::Server::start('localhost', 2100, \&request, log_file => 'test-concurrency.log');

my $nl = "\x0d\x0a";

sub request { # {{{

    my $request  = shift;

    if ($request->{path} eq '/') {
       $request -> answer('200 OK', 'text/html', scalar read_file('test-concurrency.html'));
       return;
    }

    my ($seconds_to_sleep) = $request->{path} =~ m|/sleep_(\d+)$|;

    tq84::HTTP::Server::log_("Going to sleep for $seconds_to_sleep second(s)");
    sleep $seconds_to_sleep;
    tq84::HTTP::Server::log_("Woke up from $seconds_to_sleep sleep");

    my $answer = "{\"seconds_slept\": $seconds_to_sleep}";

    $request -> answer('200 OK', 'application/json', $answer);


} # }}}
