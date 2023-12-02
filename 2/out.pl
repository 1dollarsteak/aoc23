#!/usr/bin/perl
use Syntax::Construct qw(/r);
use warnings;
use strict;

# [red, green, blue]
my @bagcounts = (12, 13, 14);
my $game_sums = 0;
while (<>) {
  $_ =~ /([0-9]+)/;
  my $game_id = $1;
  print "new game: " . $game_id . "\n";
  my @split_game = split(/;/, $_);
  my $game_possible = 1;
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
        if ($split_reveals[0] > $bagcounts[0]) {
          $game_possible = 0;
        }
      }
      elsif ($split_reveals[1] eq "green") {
        if ($split_reveals[0] > $bagcounts[1]) {
          $game_possible = 0;
        }
      }
      elsif ($split_reveals[1] eq "blue") {
        if ($split_reveals[0] > $bagcounts[2]) {
          $game_possible = 0;
        }
      }
    }
  }
  if ($game_possible == 1) {
    $game_sums += $game_id;
  }
  print "#######\n";
}
print $game_sums . "\n";
