package tq84::HTTP::Request;

my $nl = "\x0d\x0a";

sub new { # {{{

    my $self = {};

    bless $self, shift;

    $self -> {socket_         } = shift;
    $self -> {raw_request_data} = shift;

   ($self -> {header},
    $self -> {body})    = split "\r\n\r\n", $self->{raw_request_data};

  @{$self -> {headers}} = split "\r\n"    , $self->{header};

    my $method_uri_version = shift @{$self->{headers}};


   ($self -> {method},
    $self -> {uri},
    $self -> {http_verrsion}) = split ' ', $method_uri_version;


    my $fields_;
   ($self -> {path},
    $fields_)        = split '\?', $self->{uri}, 2;

    return $self;
    
} # }}}

sub answer { # {{{

    my $self         = shift;
    my $status       = shift;
    my $content_type = shift;
    my $answer       = shift;

    print $answer;

    $self->{socket_}->send( "HTTP/1.1 $status$nl");
    $self->{socket_}->send( "Content-Type: $content_type; charset=utf-8$nl");
    $self->{socket_}->send( "Content-Length: " . length($answer) . "$nl$nl");

    $self->{socket_}->send( $answer);
    
} # }}}

1;
