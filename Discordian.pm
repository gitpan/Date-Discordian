package Date::Discordian;
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK @SEASONS @DAYS @HOLYDAYS);
require Exporter;
use Time::Local;
use Date::Leapyear qw();

@ISA       = qw(Exporter);
@EXPORT    = qw( discordian inverse_discordian );
@EXPORT_OK = qw( @SEASONS @DAYS );
$VERSION   = (qw'$Revision: 1.26 $')[1];

@SEASONS = qw(Chaos Discord Confusion Bureaucracy Aftermath);
@DAYS =
  ( 'Sweetmorn', 'Boomtime', 'Pungenday', 'Prickle Prickle', 'Setting Orange' );

@HOLYDAYS = (
  [ 'Mungoday', 'Chaoflux' ],  [ 'Mojoday', 'Discoflux' ],
  [ 'Syaday',   'Confuflux' ], [ 'Zaraday', 'Bureflux' ],
  [ 'Maladay',  'Afflux' ],
);

sub discordian {
    my ($datetime) = @_;
    $datetime ||= time;
    my ( $year, $yday, $season, $day, $dow, $yold, $holyday, $datestring );

    ( $year, $yday ) = ( localtime($datetime) )[ 5, 7 ];
    $yday++;    # yday is 0-based;

    if ( Date::Leapyear::isleap( $year + 1900 ) ) {
        if ( $yday <= 59 ) {

            # nothing changes
          } elsif ( $yday == 60 ) {

            # leap day!
            $datestring = "St. Tibb's Day";
          } else {

            # The rest of the year after leap day
            $yday--;
        }
    }    # End leap year stuff

    $season = int( $yday / 73 );
    $day    = ( $yday % 73 ) || 73;
    $dow    = $yday % 5;
    $yold   = $year + 1900 + 1166;

    if ( $day == 5 )     { $holyday = $HOLYDAYS[$season][0]; }
    elsif ( $day == 50 ) { $holyday = $HOLYDAYS[$season][1]; }
    else { $holyday = undef; }

    unless ($datestring) {
        if ($holyday) {
            $datestring =
              $DAYS[ $dow - 1 ] . ' (' . $holyday . '), ' . $SEASONS[$season]
              . ' ' . $day;
          } else {
            $datestring =
              $DAYS[ $dow - 1 ] . ', ' . $SEASONS[$season] . ' ' . $day;
        }
    }

    $datestring .= " YOLD $yold";

    return $datestring;
}

sub inverse_discordian {
    my $discordian = shift;
    my $epoch;

    for ($discordian) {

        # The day does not really matter ...
        s/sweetmorn|boomtime|setting orange|prickle prickle|pungenday//i;
        s/,//g;
        s/YOLD//i;
        s/\s+/ /g;
        s/\(.*?\)//;    # Holydays
        s/^\s+//;
    }

    # Special case - St. Tibb's Day
    if ( $discordian =~ /st\.? tibb'?s day/i ) {
        $discordian =~ m/(\d{4})/;
        my $year = $1;
        $year -= 1166;
        $epoch = timelocal( 0, 0, 0, 29, 1, $year );
      } else {

        # With any luck, we now have "season day year"
        my ( $season, $day, $year ) = split / /, $discordian;
        $year -= 1166;
        $season = lc($season);
        my %seasons = (
          chaos       => 0,
          discord     => 1,
          confusion   => 2,
          bureaucracy => 3,
          aftermath   => 4
        );
        my $doy = $seasons{$season} * 73 + $day;
        $doy++ if ( $doy >= 60 && Date::Leapyear::isleap($year) );
        $epoch = ( $doy - 1 ) * 86400 + timegm( 0, 0, 0, 1, 0, $year );
    }

    return $epoch;
}

1;

__END__

=head1 NAME

Date::Discordian - Calculate the Discordian date of a particular day

=head1 SYNOPSIS

  use Date::Discordian;
  $discordian = discordian(time);
  $epochtime = inverse_discordian('bureaucracy 47, 3166');

=head1 DESCRIPTION

Calculate the Discordian date of a particular 'real' date.

Date::Discordian exports two functions - discordian(), and
inverse_discordian. C<discordian()>,
when given a time value, returns a string, giving the Discordian
date for the given day. I<inverse_discordian()>, given a
Discordian date in the same format that C<discordian()> emits,
returns an epoch time value. It is pretty picky about time
format. Pity.

I'm really not sure how this would ever be used, so if you actually use
this, send me a note.

=head1 Bugs/To Do

	a timestamp-ish form of Discordian (similar to Julian)
	more chicken references.
    Accept C<ddate>-style input.

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

	Rich Bowen <rbowen@rcbowen.com> 
          -- (doubter of the wisdom of Discordianism)
	Matt Cashner <eek@eekeek.org> 
          -- (Sungo the Funky)

=begin CVS

$Header: /home/cvs/date-discordian/Discordian.pm,v 1.26 2001/07/24 15:50:17 rbowen Exp $

$Log: Discordian.pm,v $
Revision 1.26  2001/07/24 15:50:17  rbowen
Added a variety of tests.

Revision 1.25  2000/09/24 11:18:05  rbowen
Completed the inverse_discordian function


=end CVS

=cut

