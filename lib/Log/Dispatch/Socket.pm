#######
##
##----- LOSYME
##----- Log::Dispatch::Socket
##----- Log messages to a socket 
##----- Socket.pm
##
########################################################################################################################

package Log::Dispatch::Socket;

use strict;
use warnings;

our $VERSION   =   '0.01';
our $AUTHORITY = 'LOSYME';

use IO::Socket::INET;
use Params::Validate qw(validate SCALAR);
use parent qw(Log::Dispatch::Output);

Params::Validate::validation_options( allow_extra => 1 );

##--------------------------------------------------------------------------------------------------------------------##
sub new
{
    my $proto = shift;
    my $class = ref $proto || $proto;
    
    my $self = validate
    (
        @_
    ,   {
            PeerHost   => { type => SCALAR, default => 'localhost' }
        ,   PeerPort   => { type => SCALAR                         }
        ,   Proto      => { type => SCALAR, default =>       'tcp' }
        }
    );

    bless $self, $class;
    
    $self->_basic_init(%$self);
    
    $self->{Attempt} = 0;
    $self->{Socket} = undef;

    die "Connect to '$self->{PeerHost}:$self->{PeerPort}' failed: $!" ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        unless $self->_connect(%$self);

    return $self;
}

##--------------------------------------------------------------------------------------------------------------------##
sub _connect
{
    my $self = shift;
    return $self->{Socket} = IO::Socket::INET->new(@_);
}

##--------------------------------------------------------------------------------------------------------------------##
sub _disconnect
{
    my $self = shift;
    
    if (defined $self->{Socket})
    {
        eval { close $self->{Socket}; };
        undef $self->{Socket};
    }
}

##--------------------------------------------------------------------------------------------------------------------##
sub log_message
{
    my ($self, %params) = @_;

    RETRY:
    {
        unless (defined $self->{Socket})
        {
            return if $self->{Attempt};
            $self->{Attempt} += 1;
            unless ($self->_connect(%$self))
            {
                die "Disconnect from '$self->{PeerHost}:$self->{PeerPort}'"; ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                return;
            }
            $self->{Attempt} = 0;
        }
        
        eval { $self->{Socket}->send($params{message}); }; ##$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        
        if ($@)
        {
            $self->_disconnect;
            redo RETRY;
        }
    }    
}

##--------------------------------------------------------------------------------------------------------------------##
sub DESTROY
{
    $_[0]->_disconnect;
}

1;

__END__

=pod

=head1 NAME

Log::Dispatch::Socket - Log messages to a socket.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use Log::Dispatch;

    my $log = Log::Dispatch->new(
        outputs => [
            [
                'Socket'
            ,   PeerHost  => 'server.foo.com"
            ,   PeerPort  => '9876'
            ,   Proto     => 'tcp'
            ,   min_level => 'info'          
            ]
        ]
    );

    $log->info("Sorry for my (poor/beginner's/basic) English.");

=head1 DESCRIPTION

This module provides, under the L<Log::Dispatch>::* system, a simple object to write messages to a socket listening on
some remote host.

It relies on L<IO::Socket::INET> and offers all parameters this module offers.

If this module cannot contact the server during the initialization phase (while running the constructor new),
it will die().

If this module fails to log a message because the socket's send() method fails , it will try to reconnect once.
If it succeeds, the message will be sent. If the reconnect fails, this module will die().

=head1 METHODS

=head2 new

=head2 log_message

=head1 SEE ALSO

L<Log::Dispatch>

L<Log::Dispatch::UDP>

L<Log::Log4perl::Appender::Socket>

=head1 TODO

Add some tests for version 0.02

=head1 AUTHOR

LoE<iuml>c TROCHET E<lt>losyme@gmail.comE<gt>

Repository available at L<https://github.com/losyme/Log-Dispatch-Socket>.

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2012 by LoE<iuml>c TROCHET.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut

####### END ############################################################################################################
