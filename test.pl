# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..5\n"; }
END {print "not ok 1\n" unless $loaded;}
use Date::Discordian;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

print "January 1, 2000 ... ";
$discordian = discordian(946702800);
if ($discordian eq 'Sweetmorn, Chaos 1')	{
	print "ok 2\n";
}
else {
	print "not ok 2\n";
}

print "February 28, 2000 ... ";
$discordian = discordian(951714000);
if ($discordian eq 'Prickle Prickle, Chaos 59')	{
	print "ok 3\n";
}
else {
	print "not ok 3\n";
}

print "February 29, 2000 ... ";
$discordian = discordian(951800400);
if ($discordian eq 'St. Tib\'s Day')	{
	print "ok 4\n";
}
else {
	print "not ok 4\n";
}

print "August 12, 2000 ... ";
$discordian = discordian(966108845);
if ($discordian eq 'Prickle Prickle, Bureaucracy 5')	{
	print "ok 5\n";
}
else {
	print "not ok 5\n";
}

