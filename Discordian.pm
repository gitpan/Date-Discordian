package Date::Discordian;
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK @SEASONS @DAYS);
require Exporter;

@ISA = qw(Exporter AutoLoader);
@EXPORT = qw( discordian );
@EXPORT_OK = qw( @SEASONS @DAYS isleap);
$VERSION = '1.01';

@SEASONS = qw(Chaos Discord Confusion Bureaucracy Aftermath);
@DAYS = ('Sweetmorn', 'Boomtime', 'Pungenday', 'Prickle Prickle', 'Setting Orange');

sub discordian	{
	my ($datetime) = @_;
	# $datetime ||= time;
	my ($year, $yday, $season, $day, $dow, $datestring);
	
	($year, $yday) = (localtime($datetime))[5, 7];
	$yday++; # yday is 0-based;

	if (isleap($year))	{
		if ($yday <= 59)	{
			# nothing changes
		}
		elsif ($yday == 60)	{
			# leap day!
			return "St. Tib's Day";
		}
		else {
			# The rest of the year after leap day
			$yday--;
		}
	} # End leap year stuff

	$season = int($yday/73);
	$day = ($yday % 73) || 73;
	$dow = $yday % 5;

	$datestring = $DAYS[$dow-1] . ', ' . $SEASONS[$season] . ' ' . $day;
	return $datestring ;
}

sub isleap	{
	my ($year) = @_;
	$year += 1900;
	return 1 if $year%4==0;
	return 1 if ($year%4==0 && !$year%100);
	return 0;
}

1;

__END__

=head1 NAME

Date::Discordian - Calculate the Discordian date of a particular day

=head1 SYNOPSIS

  use Date::Discordian;
  $discordian = discordian(time);

=head1 DESCRIPTION

Calculate the Discordian date of a particular 'real' date.

Date::Discordian exports just one function - discordian() - which,
when given a time value, returns a string, giving the Discordian
date for the given day.

I'm really not sure how this would ever be used, so if you actually use
this, send me a note.

=head1 Bugs/To Do

I'd like for it to be able to return the various Holydays in 
some useful fashion, ala ddate.

=head1 AUTHOR

Rich Bowen <rbowen@rcbowen.com>

=cut
