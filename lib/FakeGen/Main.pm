package FakeGen::Main;
use Mojo::Base 'Mojolicious::Controller';
use utf8;

# render main page (post to /)
sub show {
  my $self = shift;

  #get initial parameters
  my $nation = $self->param('country_choise') || '';
  my $sex = $self->param('gender_choise') || '';
  my $country;
  my $gender;

  # set country
  given ($nation) {
      when ('russian')   { $country = 'Россия' }
      when ('ukrainian') { $country = 'Украина' }
      default            { $country = 'Россия' }
  }

  # set gender
  given ($sex) {
      when ('male')   { $gender = 'Мужской' }
      when ('female') { $gender = 'Женский' }
      default         { $gender = 'Мужской' }
  }

  # generate random account based on nation and sex
  my ($name, $surname, $second_name, $city) = $self->engine->generate($nation, $sex);

  # render page
  $self->render (
                name        => $name, 
                surname     => $surname,
                second_name => $second_name,
                gender      => $gender,
                country     => $country,
                city        => $city
  );
}

# just show form (get to /)
sub show_form {
    my $self = shift;

    $self->render;
}

1;
