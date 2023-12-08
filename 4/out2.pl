#!/usr/bin/perl
use Syntax::Construct qw(/r);
use Data::Dumper;
use warnings;
use strict;

my @winning_numbers = ();
my @current_numbers = ();
my $winning_number;
my $current_number;
my @card_stack = ();

while (<>) {
  $winning_number = $1 if $_ =~ /Card\s*\d+:\s((\s*[\d]{,2}\s*){10})/;
  $current_number = $1 if $_ =~ /Card\s*\d+:\s.*\s\| (([\d]{,2}\s*)*)/;
  
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
#print scalar @current_numbers . "\n";
#print scalar @winning_numbers . "\n";
for (my $i=0; $i<@winning_numbers; $i++) {
  push(@card_stack, 1);
}

my $sum = 0;
my $score = 0;
my $card_index = 0;
my $card_copies = 0;
for my $w_cards (@winning_numbers) { # card
  $card_copies = $card_stack[$card_index];
  print "looping index $card_index $card_copies times\n";
  for (my $i=0; $i < $card_copies; $i++) {
    for my $winning_number (@$w_cards) { # number on winning side
      for my $current_number (@{$current_numbers[$card_index]}) {
        if ($winning_number == $current_number) {
          #print "match on $card_index, with " . $winning_number . "\n";
          #print "winning: $current_number\n";
          $score++;
        }
      }
    }
    if ($score > 0) {
      for (my $i=1; (($i <= $score) && ($i+$card_index < @winning_numbers)); $i++) {
        $card_stack[$card_index+$i]++;
      }
      $score = 0;
    }
  }
  print "end loop\n";
  print Dumper(@card_stack);
  $card_index++;
  print "new card\n";
}

map { $sum += $_ } @card_stack;
print "$sum \n";
