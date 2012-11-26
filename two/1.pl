#!/usr/bin/perl 
use strict;
use warnings;
use Test::Most qw{no_plan};
use Data::Dumper; sub D(@){ warn Dumper(@_) };

sub b_chop{
  my $goal = shift;
  my @opts = @{$_[0]};
D {IN => [$goal, \@opts]};
  my ($first,$last) = (0, $#opts);
  my $i;
  do{
    die 'error' if $i++ > 10; # failsafe
    my $mid = int( ($last-$first)/2 );
    D {FML => [$first,$mid,$last]};
    return -1 unless defined $opts[$mid];
    return $mid if $goal  == $opts[$mid];
    $first = $mid if $goal > $opts[$mid];
    $last  = $mid if $goal < $opts[$mid]
  } while($first != $last);
  return -1; 
}


=pod
is -1, b_chop(3, []);
is -1, b_chop(3, [1]);
is 0,  b_chop(1, [1]);
=cut

is 0,  b_chop(1, [1, 3, 5]);
is 1,  b_chop(3, [1, 3, 5]);
is 2,  b_chop(5, [1, 3, 5]);
is -1, b_chop(0, [1, 3, 5]);
is -1, b_chop(2, [1, 3, 5]);
is -1, b_chop(4, [1, 3, 5]);
is -1, b_chop(6, [1, 3, 5]);

is 0,  b_chop(1, [1, 3, 5, 7]);
is 1,  b_chop(3, [1, 3, 5, 7]);
is 2,  b_chop(5, [1, 3, 5, 7]);
is 3,  b_chop(7, [1, 3, 5, 7]);
is -1, b_chop(0, [1, 3, 5, 7]);
is -1, b_chop(2, [1, 3, 5, 7]);
is -1, b_chop(4, [1, 3, 5, 7]);
is -1, b_chop(6, [1, 3, 5, 7]);
is -1, b_chop(8, [1, 3, 5, 7]);



