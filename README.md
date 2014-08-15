# Utilities for Perl handling TCP

## tq84::TCP::Server

## tq84::TCP::Proxy

A perl package implementing a proxy that relays tcp traffic. Uses `tq84::TCP::Server`.

### Tests

[print_rawdata_to_stdout.pl](https://github.com/ReneNyffenegger/perl-tcp/blob/master/print_rawdata_to_stdout.pl) is a most simple test
that intercepts connections on `localhost:8888` and fowards them to `localhost:80`. The traffic-data is printed to STDOUT.

### Links

[Jonas Wagner's HTTP ripper](https://github.com/jwagner/httpripper): a generic ripper for the web written in python.
