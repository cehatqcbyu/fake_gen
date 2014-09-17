package FakeGen::Model::Engine;

use Modern::Perl;
use Moose;

sub BUILD {
}

sub generate {
    my $self = shift;
    
    my $rand = int(rand(100) + 1);
    return $rand;
}

1;
