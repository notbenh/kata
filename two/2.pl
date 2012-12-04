#!/usr/bin/perl 
use strict;
use warnings;
use Test::Most qw{no_plan};
use Data::Dumper; sub D(@){ warn Dumper(@_) };
use v5.14;

=pod

!!! COMPLETE HACK !!!

This does not follow the binary split path but it does get at the matched index

=cut

sub b_chop{
  my $goal = shift;
  my $i=0;
  my %input = map{$_=>$i++} @{$_[0]}; # make a hash 
  return defined $input{$goal} ? $input{$goal} : -1; 
}


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



