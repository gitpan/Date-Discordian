use Test::More qw(no_plan);

BEGIN {
    use_ok ('Date::Discordian');
}

ok( discordian(946702800) eq 'Sweetmorn, Chaos 1 YOLD 3166',
    "January 1, 2000");

ok ( discordian(951714000) eq 'Prickle Prickle, Chaos 59 YOLD 3166', 
    "February 28, 2000");

ok( discordian(951800400) eq "St. Tibb's Day YOLD 3166",
    "February 29, 2000");

ok( discordian(966108845) eq 
    'Prickle Prickle (Zaraday), Bureaucracy 5 YOLD 3166',
    "August 12, 2000");

