#!/usr/bin/perl 
use strict;
use warnings;
use Test::Most qw{no_plan};
use Data::Dumper; sub D(@){ warn Dumper(@_) };

sub b_chop{ D { BCHOP => join('',_b_chop(@_))
              , IN    => \@_
              }
          }

sub _b_chop {
  my $goal = shift;
  my @opts = @{$_[0]};
  my @first= splice @opts, 0, int($#opts/2)+1; # +1 to prefer @first over what ammounts to second
  #D {GOAL => $goal, SPLIT => [\@first,\@opts] };
  if(@opts) {
    return (_b_chop($goal,\@first),_b_chop($goal,\@opts));
  }
  else {
    my $match = $first[0] eq $goal;
    D {SINGLE => [$goal,@first], MATCH => $match} ;
    return $match ? 1 : 0; # make sure we can return something
  }
}

warn '---------------------------';

is 0,  b_chop(1, [1, 3, 5, 7]);
__END__

is -1, b_chop(3, []);
is -1, b_chop(3, [1]);
is 0,  b_chop(1, [1]);

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



