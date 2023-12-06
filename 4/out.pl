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
  $winning_number = $1 if $_ =~ /Card \d+:\s((\s*[\d]{,2}\s*){5})/;
  $current_number = $1 if $_ =~ /Card \d+:\s.*\s(([\d]{,2}\s*){8})/;
  
  for my $w_num (split(/\s/, $winning_number)) {
    print "$w_num . ";
  }
  print "\n";
}
