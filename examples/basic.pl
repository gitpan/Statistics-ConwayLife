#!/usr/bin/perl -w

# Statistics::ConwayLife Basic Usage
#
# Requires Statistics::ConwayLife
#
# This is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

use Statistics::ConwayLife;

# run a random life sample
my @b = randomlife(5, 5, .4);
my $x = Statistics::ConwayLife->new(@b);
print $x->view_output();
$x->run(1);
print "--\n";
print $x->view_output();

# run a 'real life' sample
my $life = Statistics::ConwayLife->new( ([0, 0, 0],
                                         [1, 1, 1],
                                         [0, 0, 0]) );
print $life->view_output();
$life->run(1);
print "--\n";
print $life->view_output();