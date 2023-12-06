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

sub print_number { # row, col
  my $l_row = shift(@_);
  my $l_col = shift(@_);

  my $line = $input_lines[$l_row];
  chomp($line);
  my @line_chars = split(//, $line);
  my $constructed_number = "";

  if ($line_chars[$l_col] =~ /\d/) {
    while (($l_col != 0)) {
      #print "in pn row/col: $l_row/$l_col\n";
      if ($line_chars[$l_col] =~ /[^\d]/) {
        $l_col++;
        last;
      } else {
        $l_col--;
      }
    }
  } else {
    print "print_number: row: $l_row, col: $l_col must be on digit (is: $line_chars[$l_col])\n";
    exit -1;
  }

  #print "in pn final row/col: $l_row/$l_col\n";
  if ($l_col == 0) {
    if ($line_chars[$l_col] =~ /[^\d]/) {
      $l_col++;
    }
  }

  while (($l_col <= $#line_chars) && ($line_chars[$l_col] =~ /\d/)) {
    $constructed_number .= $line_chars[$l_col];
    $l_col++;
  }

  return ($constructed_number, $l_row, $l_col);
}

for my $input_line (@input_lines) { #row
  my @line_chars = split(//, $input_line);
  for my $line_char (@line_chars) { #col
    if ($line_char =~ /\*/) {
      if ($row != 0) {
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
      if ($row != (scalar @input_lines)-1) {
        # line after
        my @tmp_line = split(//, $input_lines[$row+1]);
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
      }

      if (@parts != 1) {
        my @tmp = @parts;
        push (@all_gears, \@tmp);
        #^ [ [2, 2], [2, 3] ]
      }
      @parts = ();
    }
    $col++
  } #col
  $col = 0;
  $row++;
} #row
#print "###\n";
#print Dumper(@all_gears);
#print "###\n";

# erst in komplette zahlen umwandeln anhand der koordinaten
my %gear_sum = ();
my $sum = 0;
for my $gear_coords (@all_gears) {
  for my $gear_coord (@$gear_coords) {
    #print "$gear_coord->[0], $gear_coord->[1]\n";
    my @gear = print_number($gear_coord->[0], $gear_coord->[1]);
    my $coord_string = $gear[0] . "-" . $gear[1] . "-" . ($gear[2]-1);
    #print "$coord_string\n";
    #print "###\n";
    $gear_sum{"$coord_string"} = $gear[0];
  }
  my $size = keys(%gear_sum);
  if ($size == 2) {
    my @i = values(%gear_sum);
    print "$i[0] * $i[1]\n";
    $sum += $i[0] * $i[1];
  }
  %gear_sum = ();
}
print "$sum\n";
