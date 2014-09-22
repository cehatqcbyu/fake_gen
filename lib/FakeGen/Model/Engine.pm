package FakeGen::Model::Engine;

# engine for fake_gen web application

use Modern::Perl;
use Moose;
use DBI;

# database user
has 'user'     => (
    is         => 'rw',
    default    => 'cehatqcbyu',
    writer     => 'set_user'
);

# database password
has 'password' => (
    is         => 'rw',
    default    => 'ghbcjyth17',
    writer     => 'set_password'
);

# database name
has 'database' => (
    is         => 'rw',
    default    => 'fake_gen',
    writer     => 'set_database'
);

sub BUILD {
    my $self = shift;
    $self->set_user($self->{user});
    $self->set_password($self->{password});
    $self->set_database($self->{database});
}

sub generate {
    my $self = shift;

    # desired nation and sex
    my $nation = shift;
    my $sex = shift;
    # check input data
    unless ( ($nation eq 'russian') || ($nation eq 'ukrainian') ) {
        $nation = 'russian';
    }
    unless ( ($sex eq 'male') || ($sex eq 'female') ) {
        $sex = 'male';
    }
    # database parameters
    my $user = $self->{user};
    my $password = $self->{password};
    my $database = $self->{database};

    # data variables
    my $name;
    my $surname;
    my $second_name;
    my $country
    my $city;

    # connect to database
    my $dbh = DBI->connect("dbi:mysql:$database", $user, $password) || die "Cannot connect to database: $DBI::errstr\n";

    ### select random name ###
    $name = &get_rand_item($dbh, 'name', $nation, $sex);

    ### select random surname ###
    $surname = &get_rand_item($dbh, 'name', $nation, $sex);

    ### select random second_name ###
    $second_name = &get_rand_item($dbh, 'name', $nation, $sex);

    ### select random city ###
    $city = &get_rand_item($dbh, 'city', $nation);

    return $name, $surname, $second_name, $city;
}

# return random name, surname or second_name from database
sub get_rand_item {
    my $dbh = shift; # connected database
    my $type = shift; # name, second_name or surname
    my $nation = shift || '';
    my $sex = shift || '';

    my @list;
    # database querry
    if ($type eq 'city') {
        my $querry; = "SELECT `$type` FROM `{$type}s` WHERE `nation` = '$nation';";
    }
    else {
        my $querry; = "SELECT `$type` FROM `{$type}s` WHERE `nation` = '$nation' AND `sex` = '$sex';";
    }
    my $sth = $dbh->prepare($querry);
    $sth->execute || die "Cannot execute SQL querry: $DBI::errstr\n";
    # get list of suitable items
    while (my @row = $sth->fetchrow_array) {
        push @list, $row[0];
    }
    # return random item from the list
    return $list[int rand($#list+1)];

}

1;
