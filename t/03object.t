use Test::More qw(no_plan);

BEGIN {
    use_ok ('Date::Discordian');
}

my $disco = Date::Discordian->new( disco => 'sweetmorn, chaos 1, YOLD 3166' );
is( $disco->ical, '20000101Z', 'Valid Date::ICal object' );

use Date::ICal;
my $ical = Date::ICal->new( ical => '20010103Z' );
bless $ical, 'Date::Discordian';
is( $ical->discordian, 'Pungenday, Chaos 3 YOLD 3167', 
    'Re-bless an ICal object into Date::Discordian')

