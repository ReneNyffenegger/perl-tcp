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


   ($self -> {path},
    $self -> {query_string}) = split '\?', $self->{uri}, 2;

    $self -> determine_params;


    return $self;
    
} # }}}

sub determine_params { # {{{
    my $self = shift;

    if (defined $self -> {query_string}) {
      $self->determine_params_from_string($query_string);
    }

    if ($self->{method} eq 'POST') {
      $self -> determine_params_from_string($self->{body});
    }
    
} # }}}

sub determine_params_from_string { # {{{
    my $self   = shift;
    my $string = shift;

    my @name_values = split '&', $string;

    for my $name_value (@name_values) {
      my ($name, $value) = split '=', $name_value;

      $name  = decode_($name );
      $value = decode_($value);

      $self -> {params} -> {$name} = $value;
    }
    
} # }}}

sub decode_ { # {{{

    $t  = shift;
    $t  =~ s/\+/ /g;
    $t  =~ s/%(..)/chr(hex($1))/eg;

    return $t;

} # }}}

sub param { # {{{

    my $self = shift;
    my $name = shift;

    return $self->{params}->{$name};
    
} # }}}

sub path { # {{{
    my $self = shift;
    $self->{path};
} # }}}

sub answer { # {{{

    my $self         = shift;
    my $status       = shift;
    my $content_type = shift;
    my $answer       = shift;

    $self->{socket_}->send( "HTTP/1.1 $status$nl");
    $self->{socket_}->send( "Content-Type: $content_type; charset=utf-8$nl");
    $self->{socket_}->send( "Content-Length: " . length($answer) . "$nl$nl");

    $self->{socket_}->send( $answer);
    
} # }}}

1;
