#!/usr/bin/perl
use Syntax::Construct qw(/r);
use Data::Dumper;
use warnings;
use strict;

my @winning_numbers = ();
my @current_numbers = ();
my $winning_number;
my $current_number;

while (<>) {
  $winning_number = $1 if $_ =~ /Card\s*\d+:\s((\s*[\d]{,2}\s*){10})/;
  $current_number = $1 if $_ =~ /Card\s*\d+:\s.*\s\| (([\d]{,2}\s*){25})/;
  
  my @tmp_w = ();
  my @tmp_c = ();
  for my $w_num (split(/\s/, $winning_number)) {
    if (($w_num =~ /\d{,2}/) && ($w_num ne "")) {
      push(@tmp_w, $w_num);
    }
  }
  push(@winning_numbers, \@tmp_w);
  for my $c_num (split(/\s/, $current_number)) {
    if (($c_num =~ /\d{,2}/) && ($c_num ne "")) {
      push(@tmp_c, $c_num);
    }
  }
  push(@current_numbers, \@tmp_c);
}

my $sum = 0;
my $score = 0;
my $card_index = 0;
for my $w_cards (@winning_numbers) {
  for my $winning_number (@$w_cards) {
    for my $current_number (@{$current_numbers[$card_index]}) {
      if ($winning_number == $current_number) {
        print "winning: $current_number\n";
        $score++;
      }
    }
  }
  if ($score > 0) {
    $score--;
    $sum += (2**$score);
    print "2**$score = " . 2**$score . "\n";
    $score = 0;
  }
  $card_index++;
  print "new card\n";
}
print "$sum\n";
