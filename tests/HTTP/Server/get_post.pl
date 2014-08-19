use warnings;
use strict;

use lib '../../..';
use tq84::HTTP::Server;

tq84::HTTP::Server::start('localhost', 2000, \&request);

sub request { # {{{

    my $request = shift;

    my $answer ='';
    $answer .= "<!doctype HTML>\n<html><head><title>GET and POST test</title></head><body>";

    $answer .= "<table><tr><td>";

    my $post_test_1_value = $request->param('post_test_1') // '<? + = ?>';
    my $post_test_2_value = $request->param('post_test_2') // '<? = & ?>';
    my $get_test_1_value  = $request->param('get_test_1' ) // '<? + = ?>';
    my $get_test_2_value  = $request->param('get_test_2' ) // '<? = & ?>';

    $answer .= "Post request:</br>";
    $answer .= '<form method="POST">';
    $answer .= '<input type="text" name="post_test_1" value="' . $post_test_1_value . '"><br>';
    $answer .= '<input type="text" name="post_test_2" value="' . $post_test_2_value . '"><br>';
    $answer .= '<input type="submit" name="post_submit" value="go">';
    $answer .= "</form>";

    $answer .= "</td><td>";

    $answer .= "Get request:</br>";
    $answer .= '<form method="GET">';
    $answer .= '<input type="text" name="get_test_1" value="' . $get_test_1_value . '"><br>';
    $answer .= '<input type="text" name="get_test_2" value="' . $get_test_2_value . '"><br>';
    $answer .= '<input type="submit" name="get_submit" value="go">';
    $answer .= "</form>";

    $answer .= "</td></tr></table>";

    $answer .= "<h1>Raw request data</h1>";
    $answer .= "<pre>" . $request -> {raw_request_data} . "</pre>";

    $answer .= "</body></html>";

    $request -> answer('200 OK', 'text/html', $answer);
    
} # }}}
