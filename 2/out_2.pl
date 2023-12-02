#!/usr/bin/perl
use Syntax::Construct qw(/r);
use warnings;
use strict;

# [red, green, blue]
my @bagcounts = (12, 13, 14);
my @max_cubes = (0, 0, 0);
my $game_sums = 0;

while (<>) {
  $_ =~ /([0-9]+)/;
  my $game_id = $1;
  print "new game: " . $game_id . "\n";

  @max_cubes = (0, 0, 0);
  my @split_game = split(/;/, $_);
  for my $i (@split_game) {
    print "new set:\n";
    $i = $i =~ s/Game [0-9]+: //r;
    my @split_sets = split(/,/, $i);
    for my $j (@split_sets) {
      $j = $j =~ s/^\s*//r;
      my @split_reveals = split(/ /, $j);
      chomp $split_reveals[1];
      print "first: " . $split_reveals[0] . " second: " . $split_reveals[1] . ".\n";
      if ($split_reveals[1] eq "red") {
        $max_cubes[0] = $split_reveals[0] if $max_cubes[0] < $split_reveals[0];
      }
      elsif ($split_reveals[1] eq "green") {
        $max_cubes[1] = $split_reveals[0] if $max_cubes[1] < $split_reveals[0];
      }
      elsif ($split_reveals[1] eq "blue") {
        $max_cubes[2] = $split_reveals[0] if $max_cubes[2] < $split_reveals[0];
      }
    }
  }
  $game_sums += $max_cubes[0] * $max_cubes[1] * $max_cubes[2];
  print "#######\n";
}
print $game_sums . "\n";
