use Test::More qw(no_plan);

BEGIN {
    use_ok ('Date::Discordian');
}

ok( inverse_discordian('Sweetmorn, Chaos 1 YOLD 3166') == 946684800,
    "January 1, 2000");

ok( inverse_discordian('Prickle Prickle, Chaos 59 YOLD 3166') ==951696000,
    "February 28, 2000");

ok( inverse_discordian( "St. Tibb's Day YOLD 3166") == 951800400,
    "February 29, 2000");

ok( inverse_discordian('Prickle Prickle (Zaraday), Bureaucracy 5 YOLD 3166') ==
966038400, "August 12, 2000");

