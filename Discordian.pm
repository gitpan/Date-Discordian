package Date::Discordian;
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK @SEASONS @DAYS);
require Exporter;

@ISA = qw(Exporter AutoLoader);
@EXPORT = qw( discordian );
@EXPORT_OK = qw( @SEASONS @DAYS );
$VERSION = '1.00';

@SEASONS = qw(Chaos Discord Confusion Bureaucracy Aftermath);
@DAYS = ('Sweetmorn', 'Boomtime', 'Pungenday', 'Prickle Prickle', 'Setting Orange');

sub discordian	{
	my ($date) = @_;
	my ($yday, $season, $day, $dow, $datestring);
	
	$yday = (localtime($date))[7];
	($season, $day);
	$season = int($yday/73);
	$day = $yday % 73;
	$dow = $yday % 5;

	$datestring = $DAYS[$dow-1] . ', ' . $SEASONS[$season] . ' ' . $day;
	return wantarray ? ($season, $day, $dow) : $datestring ;
}

1;

__END__

=head1 NAME

Date::Discordian - Calculate the Discordian date of a particular day

=head1 SYNOPSIS

  use Date::Discordian;
  $discordian = discordian(time);
  ($season, $day, $day_of_week) = discordian(time);

=head1 DESCRIPTION

Calculate the Discordian date of a particular 'real' date.

Date::Discordian exports just one function - discordian() - which,
when given a time value, returns either a list of the Discordian
season, day of that season, and the day of the week, or a single string
of those values, depending on context.

I'm really not sure how this would ever be used, so if you actually use
this, send me a note.

=head1 Bugs/To Do

Does not handle leap years at all. In fact, it's really not working
correctly now. It's off by a day. Sort of. It appears to work, because
2000 is a leap year.

Also, I'd like for it to be able to return the various Holydays in 
some useful fashion, ala ddate.

=head1 AUTHOR

Rich Bowen <rbowen@rcbowen.com>

=cut
