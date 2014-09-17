package FakeGen::Main;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub show {
  my $self = shift;

  my $message = $self->engine->generate();
  $self->render(message => $message);
}

1;
