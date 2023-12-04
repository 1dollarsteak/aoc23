#!/usr/bin/perl
use Syntax::Construct qw(/r);
use Data::Dumper::Perltidy;
use List::Util 'sum';
use warnings;
use strict;

my @input_lines = ();
my $row = 0;
my $col = 0;
my @parts = ();
my @all_gears = ();

while(<>) {
  push(@input_lines, $_);
}

for my $input_line (@input_lines) { #row
  my @line_chars = split(//, $input_line);
  for my $line_char (@line_chars) { #col
    if ($line_char =~ /\*/) {
      # line before
      my @tmp_line = split(//, $input_lines[$row-1]);
      if ($tmp_line[$col-1] =~ /\d/) {
        my @tmp = ($row-1, $col-1);
        push(@parts, \@tmp);
      }
      if ($tmp_line[$col] =~ /\d/) {
        my @tmp = ($row-1, $col);
        push(@parts, \@tmp);
      }
      if ($tmp_line[$col+1] =~ /\d/) {
        my @tmp = ($row-1, $col+1);
        push(@parts, \@tmp);
      }
      # this line
      if ($line_chars[$col-1] =~ /\d/) {
        my @tmp = ($row, $col-1);
        push(@parts, \@tmp);
      }
      if ($line_chars[$col+1] =~ /\d/) {
        my @tmp = ($row, $col+1);
        push(@parts, \@tmp);
      }
      # line after
      @tmp_line = split(//, $input_lines[$row+1]);
      if ($tmp_line[$col-1] =~ /\d/) {
        my @tmp = ($row+1, $col-1);
        push(@parts, \@tmp);
      }
      if ($tmp_line[$col] =~ /\d/) {
        my @tmp = ($row+1, $col);
        push(@parts, \@tmp);
      }
      if ($tmp_line[$col+1] =~ /\d/) {
        my @tmp = ($row+1, $col+1);
        push(@parts, \@tmp);
      }

      if (@parts != 1) {
        my @tmp = @parts;
        push (@all_gears, \@tmp);
        #^ [ [2, 2], [2, 3] ]
        # erst in komplette zahlen umwandeln anhand der koordinaten
        # prüfen ob es nur zwei zahlen sind
          # die dann malnehmen
          # und zur summe aufaddieren
      }
      @parts = ();
    }
    $col++
  } #col
  $col = 0;
  $row++;
} #row

print Dumper(@all_gears);
