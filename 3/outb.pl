#!/usr/bin/perl
use Syntax::Construct qw(/r);
use Data::Dumper::Perltidy;
use List::Util 'sum';
use warnings;
use strict;

my @input_lines = ();
my @numbers = (); # (number, x, y1, y2, y3, yn)
my $constructed_number = "";
my $row = 0;
my $col = 0;
my @cols = ();
my %matching_numbers = ();

while(<>) {
  push(@input_lines, $_);
}

for my $input_line (@input_lines) { #row
  my @line_chars = split(//, $input_line);
  for my $line_char (@line_chars) { #col
    if ($line_char =~ /\d/) {
      $constructed_number .= $line_char;
      push(@cols, $col);
    } elsif ($constructed_number ne "") {
      my @tmp = ($constructed_number, $row, @cols);
      push(@numbers, \@tmp);
      $constructed_number = "";
      @cols = ();
    }
    $col++
  } #col
  $col = 0;
  $row++;
} #row

for my $number (@numbers) {
  # the line before
  if ($number->[1] != 0) {
    my @line_chars = split(//, $input_lines[$number->[1]-1]);
    for (my $i=2; $i<=$#{$number}; $i++) {
      if ($line_chars[$number->[$i]] =~ /[^\w\d.\n]/) {
        $matching_numbers{join("-", @$number)} = $number->[0];
      }
      if ($line_chars[$number->[$i]-1] =~ /[^\w\d.\n]/) {
        $matching_numbers{join("-", @$number)} = $number->[0];
      }
      if ($line_chars[$number->[$i]+1] =~ /[^\w\d.\n]/) {
        $matching_numbers{join("-", @$number)} = $number->[0];
      }
    }
  }
  # the line
  my @line_chars = split(//, $input_lines[$number->[1]]);
  for (my $i=2; $i<=$#{$number}; $i++) {
    if ($line_chars[$number->[$i]] =~ /[^\w\d.\n]/) {
      $matching_numbers{join("-", @$number)} = $number->[0];
    }
    if ($line_chars[$number->[$i]-1] =~ /[^\w\d.\n]/) {
      $matching_numbers{join("-", @$number)} = $number->[0];
    }
    if ($line_chars[$number->[$i]+1] =~ /[^\w\d.\n]/) {
      $matching_numbers{join("-", @$number)} = $number->[0];
    }
  }
  # the line after
  if ($number->[1] != $#input_lines) {
    my @line_chars = split(//, $input_lines[$number->[1]+1]);
    for (my $i=2; $i<=$#{$number}; $i++) {
      if ($line_chars[$number->[$i]] =~ /[^\w\d.\n]/) {
        $matching_numbers{join("-", @$number)} = $number->[0];
      }
      if ($line_chars[$number->[$i]-1] =~ /[^\w\d.\n]/) {
        $matching_numbers{join("-", @$number)} = $number->[0];
      }
      if ($line_chars[$number->[$i]+1] =~ /[^\w\d.\n]/) {
        $matching_numbers{join("-", @$number)} = $number->[0];
      }
    }
  }
}

print Dumper(%matching_numbers);
print sum(values(%matching_numbers)) . "\n";
