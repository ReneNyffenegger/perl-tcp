# Utilities for Perl handling TCP

## tq84::TCP::Server

## tq84::TCP::Proxy

A perl package implementing a proxy that relays tcp traffic. Uses `tq84::TCP::Server`.

### Tests

[print_rawdata_to_stdout.pl](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/TCP/Proxy/print_rawdata_to_stdout.pl) is a most simple test for
the [tq84::TCP::Proxy](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tq84/TCP/Proxy.pm) module that intercepts connections on `localhost:8888` and fowards them to `localhost:80`. The traffic-data is printed to STDOUT.

[serve_files.pl](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/serve_files.pl) tests
[tq84::HTTP::Server.pm](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tq84/HTTP/Server.pm). When started, a browser can connect to [localhost:1234]. The script
then sends [index.html](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/index.html) which has two links to
[foo.html](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/foo.html) and [bar.html](https://github.com/ReneNyffenegger/perl-tcp/blob/master/tests/HTTP/Server/bar.html).
The third link (`baz.html`) does not exist, hence the server answers with a `404 Not Found` status.

### Links

[Jonas Wagner's HTTP ripper](https://github.com/jwagner/httpripper): a generic ripper for the web written in python.

### Misc

[FIONBIO-FIONREAD-SIOCATMARK.c](https://github.com/ReneNyffenegger/perl-tcp/blob/master/misc/FIONBIO-FIONREAD-SIOCATMARK.c) is a simple
c program to determine the values of the constants `FIONBIO`, `FIONREAD` and `SIOCATMARK` that are used in the `ioctl` function. I wrote
this little program because I found it especially hard to get their respective values for a Windows System.
