#!/usr/bin/perl
use warnings;
use strict;

my $sum = 0;
while (<>) {
  my $first_number;
  my $last_number;
  my $concat_number;

  $first_number = $1 if $_ =~ /[.]?([0-9]).*/;
  $last_number = $1 if $_ =~ /[.]?[0-9].*([0-9])/;

  $concat_number = $first_number if defined $first_number;
  $concat_number .= $last_number if defined $last_number;
  $concat_number .= $concat_number if length($concat_number) == 1;
  
  $sum += $concat_number;
}

print $sum . "\n";
