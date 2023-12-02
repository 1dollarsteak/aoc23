#!/usr/bin/perl
use Syntax::Construct qw(/r);
use warnings;
use strict;

my $sum = 0;
my @digits = ("one", "two", "three", "four", "five",
              "six", "seven", "eight", "nine");

while (<>) {
  my $first_number;
  my $last_number;
  my $concat_number;

  $first_number = $1 if $_ =~ /[.]?([0-9]|one|two|three|four|five|six|seven|eight|nine).*/;
  $last_number = $1 if $_ =~ /.*([0-9]|one|two|three|four|five|six|seven|eight|nine)/;

  if (defined $first_number) {
    for my $i (0 .. $#digits) {
      my $j = $i + 1;
      $first_number = $first_number =~ s/$digits[$i]/$j/r;
    }
    $concat_number = $first_number;
  }
  if (defined $last_number) {
    for my $i (0 .. $#digits) {
      my $j = $i + 1;
      $last_number = $last_number =~ s/$digits[$i]/$j/r;
    }
    $concat_number .= $last_number;
  }
  $concat_number .= $concat_number if length($concat_number) == 1;

  $sum += $concat_number;
}

print $sum . "\n";
