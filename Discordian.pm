package Date::Discordian;
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK @SEASONS @DAYS @HOLYDAYS);
require Exporter;

@ISA = qw(Exporter AutoLoader);
@EXPORT = qw( discordian );
@EXPORT_OK = qw( @SEASONS @DAYS isleap);
$VERSION = '1.03';

@SEASONS = qw(Chaos Discord Confusion Bureaucracy Aftermath);
@DAYS = ('Sweetmorn', 'Boomtime', 'Pungenday', 'Prickle Prickle', 'Setting Orange');

@HOLYDAYS = ( [ 'Mungoday', 'Chaoflux' ],                                      
              [ 'Mojoday', 'Discoflux' ],                                      
              [ 'Syaday', 'Confuflux' ],                                       
              [ 'Zaraday', 'Bureflux' ],                                       
              [ 'Maladay', 'Afflux' ],                                         
            ); 


sub discordian	{
	my ($datetime) = @_;
	$datetime ||= time;
	my ($year, $yday, $season, $day, $dow, $yold, $holyday, $datestring);
	
	($year, $yday) = (localtime($datetime))[5, 7];
	$yday++; # yday is 0-based;

	if (isleap($year))	{
		if ($yday <= 59)	{
			# nothing changes
		}
		elsif ($yday == 60)	{
			# leap day!
			$datestring = "St. Tibb's Day";
		}
		else {
			# The rest of the year after leap day
			$yday--;
		}
	} # End leap year stuff

	$season = int($yday/73);
	$day = ($yday % 73) || 73;
	$dow = $yday % 5;
    $yold = $year + 1900 + 1166;

    if($day == 5) { $holyday = $HOLYDAYS[$season][0]; }                        
    elsif ($day == 50) { $holyday = $HOLYDAYS[$season][1]; }                   
    else { $holyday = undef; }        
    
    unless($datestring) {
        if($holyday) {
        	$datestring = $DAYS[$dow-1] . ' ('. $holyday .'), ' . $SEASONS[$season] . ' ' . $day;
        } else {
            $datestring = $DAYS[$dow-1] . ', ' . $SEASONS[$season] . ' ' . $day;
        } 
    }

    $datestring .= " YOLD $yold";

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

a timestamp-ish form of Discordian (similar to Julian)
conversion back from Discordian to epoch
more chicken references.

=head1 General comments

You can find out more about the Discordian Calendar at
http://www.concentric.net/~darkfox/DiscoCal.html and at a plethora
of other sites on the Internet.

It is related to the Principia Discordia 
(http://members.xoom.com/ffungo/titlepage.html)
and the "religion" of Discordianism. I suppose that there are people
that actually take this sort of thing seriously. But then, there are
people that collect Beanie Babies, so what do you expect?

=head1 AUTHOR

	Rich Bowen <rbowen@rcbowen.com> (doubter of the wisdom of Discordianism)
	Matt Cashner <sungo@earthling.net> (Sungo the Funky)

=cut
