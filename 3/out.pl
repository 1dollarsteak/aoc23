#!/usr/bin/perl
use Syntax::Construct qw(/r);
use Data::Dumper::Perltidy;
use warnings;
use strict;

my $sum = 0;
my $match = 0;
my $constructed_number = "";
my $arr_pos = 0;
my $last_arr_pos = -1;
my @last_line = ();
my @check_next = ();
my @possible_numbers = ();
my $possible_number_index = 0;
my %matching_numbers = ();
my $same = 0;

while (<>) {
  my @chars = split(//, $_);
  if ($#check_next != 0) {
    # check positions
    for my $pos_arr (@check_next) {
      my $i = 0;
      for my $pos (@$pos_arr) {
        if ($i != 0) {
          if ($pos != -1) {
            if ($chars[$pos] =~ /[^\w\d.]/) {
              $match = 1;
              $matching_numbers{"$@{check_next}[0]"} = $possible_numbers[$@{check_next}[0]-1];
              print "check_next: $check_next[0], pos: $pos, i: $i, check_next_length: $#check_next \n";
            }
          }
        }
        $i++;
      }
    }
    @check_next = ();
  }
  for my $char (@chars) {
    next if $char eq "\n";
    if ($char =~ /\d/) {
      print "char: " . $char . " at pos: " . $arr_pos . "\n";
      if ((($arr_pos == 0) && ($last_arr_pos == -1)) || ($arr_pos-1 != $last_arr_pos)) {
        print "new\n";
        $same = 0;
        if ($constructed_number ne "") {
          push(@possible_numbers, $constructed_number);
          $possible_number_index++;
        }
        if ($match == 1) {
          print "match, the number is: " . $constructed_number . "\n";
          $match = 0;
          $matching_numbers{"$possible_number_index"} = $possible_numbers[$possible_number_index-1];
        } else {
          print "no match, the number is: " . $constructed_number . "\n";
        }
        # add arr_pos -1, arr_pos, arr_pos +1 into check_next
        my @tmp = ($possible_number_index, $arr_pos, $arr_pos-1, $arr_pos+1);
        push(@check_next, \@tmp);
        $constructed_number = $char;
        # check left and right in $_
        if ($chars[$arr_pos-1] =~ /[^\w\d.]/) {
          $match = 1;
        } elsif ($chars[$arr_pos+1] =~ /[^\w\d.]/) {
          $match = 1;
        }
        # check arr_pos -1, arr_pos, arr_pos +1 in last_line
        if ($#last_line != -1) {
          if ($last_line[$arr_pos-1] =~ /[^\w\d.]/) {
            $match = 1;
          }
          elsif ($last_line[$arr_pos] =~ /[^\w\d.]/) {
            $match = 1;
          }
          elsif ($last_line[$arr_pos+1] =~ /[^\w\d.]/) {
            $match = 1;
          }
        }
      }
      else {
        print "same\n";
        $same = 1;
        $constructed_number .= $char;
        # add arr_pos, arr_pos +1 into check_next
        my @tmp = ($possible_number_index, $arr_pos, $arr_pos+1);
        push(@check_next, \@tmp);
        # check right in $_
        if ($chars[$arr_pos+1] =~ /[^\w\d.]/) {
          $match = 1;
        }
        # check arr_pos, arr_pos +1 in last_line
        if ($#last_line != -1) {
          if ($last_line[$arr_pos] =~ /[^\w\d.]/) {
            $match = 1;
          }
          elsif ($last_line[$arr_pos+1] =~ /[^\w\d.]/) {
            $match = 1;
          }
        }
      }
      $last_arr_pos = $arr_pos;
    }
    $arr_pos++;
  }

  # new line nearly begins
  if ($same == 1) { # todo: last  number of file must be included.
    if ($constructed_number ne "") {
      push(@possible_numbers, $constructed_number);
      $possible_number_index++;
    }
  }
  $arr_pos = 0;
  $last_arr_pos = -1;
  $match = 0;
  @last_line = split(//, $_);
  print Dumper(@check_next);
  print "###\n";
}
print Dumper(@possible_numbers);
print "###\n";
print Dumper(%matching_numbers);
