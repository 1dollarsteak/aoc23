#!/usr/bin/perl
use Syntax::Construct qw(/r);
use Data::Dumper;
use warnings;
use strict;

my %seed_to_soil = ();
my %soil_to_fertil = ();
my %fertil_to_water = ();
my %water_to_light = ();
my %light_to_temp = ();
my %temp_to_humid = ();
my %humid_to_location = ();

my @translated_values = ();
my $translated_value;

my @seeds;
my @range_condensed = ();

# mode: 0=init, 1=s2s, 2=s2f, 3=f2w
#       4=w2l,   5=l2t, 6=t2h, 7=h2l
my $mode = 0;

# test_in_ranges \@range_condensed, seed : (dest, src, range)
sub test_in_ranges {
  my @range_condensed = @{$_[0]};
  my $to_translate = $_[1];

  for my $range_line (@range_condensed) {
    my @range_line = split(/\s/, $$range_line);
    # $range_line[0] = dest
    # $range_line[1] = src
    # $range_line[2] = range
    if (($to_translate >= $range_line[1]) and ($to_translate < ($range_line[1] + $range_line[2]))) {
      print("$to_translate match in $range_line[0], $range_line[1], $range_line[2]\n");
      return ($range_line[0], $range_line[1], $range_line[2]);
    }
  }
  return -1;
}

while (<>) {
  print($_ . "\n");
  if ($_ =~ /seeds:/) {
    @seeds = split(/\s/, ($_ =~ s/^seeds: //r));
  }
  elsif ((/seed-to-soil/) || ($mode == 1)) {
    $mode = 1;
    if ($_ =~ /^\d.*/) {
      my $line = $_;
      chomp($line);
      push(@range_condensed, \$line);
    }
    elsif ($_ =~ /^.$/s) {
      for my $seed (@seeds) {
        my @res = test_in_ranges(\@range_condensed, $seed);
        if ($res[0] != -1) {
          $translated_value = $seed - $res[1] + $res[0];
        } else {
          $translated_value = $seed + 0;
        }
        push(@translated_values, $translated_value);
      }
      @range_condensed = ();
      $mode = 0;
      @seeds = @translated_values;
      @translated_values = ();
      print Dumper(\@seeds);
    }
  }
  elsif ((/soil-to-fertilizer/) || ($mode == 2)) {
    $mode = 2;
    if ($_ =~ /^\d.*/) {
      my $line = $_;
      chomp($line);
      push(@range_condensed, \$line);
    }
    elsif ($_ =~ /^.$/s) {
      for my $seed (@seeds) {
        my @res = test_in_ranges(\@range_condensed, $seed);
        if ($res[0] != -1) {
          $translated_value = $seed - $res[1] + $res[0];
        } else {
          $translated_value = $seed + 0;
        }
        push(@translated_values, $translated_value);
      }
      @range_condensed = ();
      $mode = 0;
      @seeds = @translated_values;
      @translated_values = ();
      print Dumper(\@seeds);
    }
  }
  elsif ((/fertilizer-to-water/) || ($mode == 3)) {
    $mode = 3;
    if ($_ =~ /^\d.*/) {
      my $line = $_;
      chomp($line);
      push(@range_condensed, \$line);
    }
    elsif ($_ =~ /^.$/s) {
      for my $seed (@seeds) {
        my @res = test_in_ranges(\@range_condensed, $seed);
        if ($res[0] != -1) {
          $translated_value = $seed - $res[1] + $res[0];
        } else {
          $translated_value = $seed + 0;
        }
        push(@translated_values, $translated_value);
      }
      @range_condensed = ();
      $mode = 0;
      @seeds = @translated_values;
      @translated_values = ();
      print Dumper(\@seeds);
    }
  }
  elsif ((/water-to-light/) || ($mode == 4)) {
    $mode = 4;
    if ($_ =~ /^\d.*/) {
      my $line = $_;
      chomp($line);
      push(@range_condensed, \$line);
    }
    elsif ($_ =~ /^.$/s) {
      for my $seed (@seeds) {
        my @res = test_in_ranges(\@range_condensed, $seed);
        if ($res[0] != -1) {
          $translated_value = $seed - $res[1] + $res[0];
        } else {
          $translated_value = $seed + 0;
        }
        push(@translated_values, $translated_value);
      }
      @range_condensed = ();
      $mode = 0;
      @seeds = @translated_values;
      @translated_values = ();
      print Dumper(\@seeds);
    }
  }
  elsif ((/light-to-temperature/) || ($mode == 5)) {
    $mode = 5;
    if ($_ =~ /^\d.*/) {
      my $line = $_;
      chomp($line);
      push(@range_condensed, \$line);
    }
    elsif ($_ =~ /^.$/s) {
      for my $seed (@seeds) {
        my @res = test_in_ranges(\@range_condensed, $seed);
        if ($res[0] != -1) {
          $translated_value = $seed - $res[1] + $res[0];
        } else {
          $translated_value = $seed + 0;
        }
        push(@translated_values, $translated_value);
      }
      @range_condensed = ();
      $mode = 0;
      @seeds = @translated_values;
      @translated_values = ();
      print Dumper(\@seeds);
    }
  }
  elsif ((/temperature-to-humidity/) || ($mode == 6)) {
    $mode = 6;
    if ($_ =~ /^\d.*/) {
      my $line = $_;
      chomp($line);
      push(@range_condensed, \$line);
    }
    elsif ($_ =~ /^.$/s) {
      for my $seed (@seeds) {
        my @res = test_in_ranges(\@range_condensed, $seed);
        if ($res[0] != -1) {
          $translated_value = $seed - $res[1] + $res[0];
        } else {
          $translated_value = $seed + 0;
        }
        push(@translated_values, $translated_value);
      }
      @range_condensed = ();
      $mode = 0;
      @seeds = @translated_values;
      @translated_values = ();
      print Dumper(\@seeds);
    }
  }
  elsif ((/humidity-to-location/) || ($mode == 7)) {
    $mode = 7;
    if ($_ =~ /^\d.*/) {
      my $line = $_;
      chomp($line);
      push(@range_condensed, \$line);
    }
    elsif ($_ =~ /^.$/s) {
      for my $seed (@seeds) {
        my @res = test_in_ranges(\@range_condensed, $seed);
        if ($res[0] != -1) {
          $translated_value = $seed - $res[1] + $res[0];
        } else {
          $translated_value = $seed + 0;
        }
        push(@translated_values, $translated_value);
      }
      @range_condensed = ();
      $mode = 0;
      @seeds = @translated_values;
      @translated_values = ();
    }
  }
}
print Dumper(\@seeds);
