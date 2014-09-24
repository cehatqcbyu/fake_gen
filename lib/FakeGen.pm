package FakeGen;
use Mojo::Base 'Mojolicious';

use FakeGen::Model::Engine;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Make signed cookies secure
  $self->secret(['Secret-tsssss']);
  $self->helper(engine => sub { state $engine = FakeGen::Model::Engine->new(); });

  # Router
  my $r = $self->routes;

  # /
  $r->get('/')->to('main#show_form');
  $r->post('/')->to('main#show');
}

1;
