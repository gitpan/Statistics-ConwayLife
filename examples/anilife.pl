#!/usr/bin/perl -w

# Statistics::ConwayLife Animated GIF example
# Creates an animated GIF of Conway's Life algorithm in action.
#
# Requires Image::Magick and Statistics::ConwayLife
#
# This is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

use strict;
use Image::Magick;
use Statistics::ConwayLife qw( randomlife );


my ($width, $height) = (20, 20); # width, height of image
my $chance = .4; # chance (out of one) that a given cell will live
my $frames = 20; # number of frames to render
my $increment=1; # number of iterations (of the algorithm) per frame

my $filename='life.gif'; # filename for output

my $life = Statistics::ConwayLife->new(randomlife($height, $width, $chance)); # (replace 'randomlife($height, $width, $chance)' with a 2d array to have it make a GIF of your array instead)
my $imagecount;

my $background = new Image::Magick;
$background->Set(size=> $height.'x'.$width);

my $image = new Image::Magick;
$image->Set(size=>$height.'x'.$width);
$image->Read('gradation:black-black'); # (this is inefficient)... change to set color of dead cells (0)

my ($y, $x) = (0, 0);

for $imagecount (0..$frames) {    
	$background->[$imagecount] = $image->Clone(); 

	$life->run($increment);
	my $board = \@$life;
	for $y (0 .. $#{$board}) {
		for $x (0 .. $#{$board->[$y]}) { # messy, messy, messy!
			$background->[$imagecount]->Set("pixel[$x,$y]"=> '#FFFFFF') if ($board->[$y][$x]); # change '#FFFFFF' to set color of live cells (1)

		}
	}
    $background->[$imagecount]->Set(dispose => 2);
}

$background->Set(loop => 1); # loop once
$background->Write("gif:$filename");