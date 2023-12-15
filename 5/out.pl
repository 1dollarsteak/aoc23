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

my @seeds;
my @range_condensed = ();

# mode: 0=init, 1=s2s, 2=s2f, 3=f2w
#       4=w2l,   5=l2t, 6=t2h, 7=h2l
my $mode = 0;

# fill_hash \@range_condensed : %range_expanded
sub fill_hash {
  my %range_expanded = ();
  my @range_condensed = @{$_[0]};

  for my $range_line (@range_condensed) {
    # $range_line[0] = dest
    # $range_line[1] = src
    # $range_line[2] = range
    # %range_expanded{"src"} = dest
    my @range_line = split(/\s/, $$range_line);
    for (my $i=0; $i < $range_line[2]; $i++) {
      my $range_index = $i + $range_line[1];
      $range_expanded{"$range_index"} = $i + $range_line[0];
    }
  }
  return %range_expanded;
}

# translate_items \%range_expanded, \@seeds : @translated
sub translate_items {
  my %range_expanded = %{$_[0]};
  my @seeds = @{$_[1]};
  my @translated = ();

  my $translation = 0;

  for my $seed (@seeds) {
    if ($range_expanded{$seed}) {
      $translation = $range_expanded{$seed};
    } else {
      $translation = $seed;
    }
    print "for seed $seed: $translation .";
  }
  print "\n";
}

# test_in_ranges \@range_condensed, seed : (dest, src, range)
sub test_in_ranges {
  my @range_condensed = @{$_[0]};
  my $to_translate = $_[1];

  for my $range_line (@range_condensed) {
    my @range_line = split(/\s/, $$range_line);
    # $range_line[0] = dest
    # $range_line[1] = src
    # $range_line[2] = range
    if (($to_translate > $range_line[1]) and ($to_translate < ($range_line[1] + $range_line[2]))) {
      return ($range_line[0], $range_line[1], $range_line[2]);
    }
  }
  return 0;
}

while (<>) {
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
        if ($res[0]) {
          print("$seed in range $res[0], $res[1], $res[2].\n");
        } else {
          print ("$seed in no range\n");
        }
      }
      #%seed_to_soil = fill_hash(\@range_condensed);
      @range_condensed = ();
      $mode = 0;
      #print Dumper(\%seed_to_soil);
      #print Dumper(\@seeds);
      #translate_items(\%seed_to_soil, \@seeds);
      exit 0;
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
      %soil_to_fertil = fill_hash(\@range_condensed);
      @range_condensed = ();
      $mode = 0;
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
      %fertil_to_water = fill_hash(\@range_condensed);
      @range_condensed = ();
      $mode = 0;
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
      %water_to_light = fill_hash(\@range_condensed);
      @range_condensed = ();
      $mode = 0;
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
      %light_to_temp = fill_hash(\@range_condensed);
      @range_condensed = ();
      $mode = 0;
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
      %temp_to_humid = fill_hash(\@range_condensed);
      @range_condensed = ();
      $mode = 0;
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
      %humid_to_location = fill_hash(\@range_condensed);
      @range_condensed = ();
      $mode = 0;
    }
  }
}
