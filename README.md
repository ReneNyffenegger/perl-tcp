# Utilities handling TCP for Perl

## tq84::TCP::Server

## tq84::TCP::Proxy

A Perl package implementing a proxy that relays tcp traffic. Uses [`tq84::TCP::Server`](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tq84/TCP/Server.pm).

## tq84::HTTP::Server

A Perl package that can be used for small Web Server Applications. It doesn't aim to be standard compliant.

### Tests

[print_rawdata_to_stdout.pl](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/TCP/Proxy/print_rawdata_to_stdout.pl) is a most simple test for
the [tq84::TCP::Proxy](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tq84/TCP/Proxy.pm) module that intercepts connections on `localhost:8888` and fowards them to `localhost:80`. The traffic-data is printed to STDOUT.

[serve_files.pl](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/serve_files.pl) tests
[tq84::HTTP::Server.pm](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tq84/HTTP/Server.pm). When started, a browser can connect to [localhost:1234]. The script
then sends [index.html](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/index.html) which has two links to
[foo.html](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/foo.html) and [bar.html](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/bar.html).
The third link (`baz.html`) does not exist, hence the server answers with a `404 Not Found` status.

[get_post.pl](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/get_post.pl) tests the  `param()` function of `tq84::HTTP::Request` for GET and POST requests.

[test-concurrency.pl](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/test-concurrency.pl) (along with
[test-concurrency.html](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/test-concurrency.html)) tests if `tq84::HTTP::Server.pm` is able
to handle requests in parallel. Compare with [the same test for HTTP::Server::Simple::CGI](https://github.com/ReneNyffenegger/PerlModules/blob/master/HTTP/Server/Simple/CGI/test-concurrency.pl).

### Links

[`tq84::HTTP::Server`](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tq84/HTTP/Server.pm) is used in [about-jqGrid](https://github.com/ReneNyffenegger/about-jqGrid) to generate data to be fed to a jqGrid.

[The Python module SimpleHTTPServer](https://github.com/ReneNyffenegger/about-python/tree/master/standard-library/SimpleHTTPServer).

[Jonas Wagner's HTTP ripper](https://github.com/jwagner/httpripper): a generic ripper for the web written in python.

### Misc

[FIONBIO-FIONREAD-SIOCATMARK.c](https://github.com/ReneNyffenegger/perl-tcp/blob/master/misc/FIONBIO-FIONREAD-SIOCATMARK.c) is a simple
c program to determine the values of the constants `FIONBIO`, `FIONREAD` and `SIOCATMARK` that are used in the `ioctl` function. I wrote
this little program because I found it especially hard to get their respective values for a Windows System.
