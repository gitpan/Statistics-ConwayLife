#!/usr/bin/perl -w

# Statistics::ConwayLife Random 1/0 String example
# Creates a string with a random occurance of ones and zeros.
#
# Requires Statistics::ConwayLife
#
# This is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# NOTE
#  This script is horribly inefficient, and shouldn't use Statistics::ConwayLife at all.
#  But there's only so many uses for such a module :).

use Statistics::ConwayLife qw(randomlife);

my @b = randomlife(300, 100, .5);
my $x = Statistics::ConwayLife->new(@b);
$n = $x->view_output();
$n =~ s/\n//g;
print $n;