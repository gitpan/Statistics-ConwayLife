package Statistics::ConwayLife;

# Statistics::ConwayLife
# Perl extension for simple life simulation.

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qw(Exporter);
@EXPORT_OK  = qw( randomlife );

$VERSION = '0.51';


sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my (@board) = @_ if (@_);
	my $self = [@board];
	return bless $self, $class;
}

sub randomlife {
	# (columns (x), rows(y), percent chance of life in decimal (eg .8 = 80%))
	my ($y, $x, @board);
	my ($cols, $rows, $percent) = (shift, shift, shift);
	for $y (0 .. $rows-1) {
		for $x (0 .. $cols-1) {
			if (rand() < $percent) {
				$board[$y][$x] = 1;
			} else {
				$board[$y][$x] = 0;
			}
		}
	}
	return @board;
}

sub view_output {
	my $proto = shift;
	my $self  = ref($proto) && $proto;
	my ($y, $x, $n, $cols) = 0;
	my $output;
	my $board = \@$self;
	for $y (0 .. $#{$board}) {
		for $x (0 .. $#{$board->[$y]}) { # messy, messy, messy!
			$output .= $board->[$y][$x];
		}
		$output .= "\n";
	}
	return $output;
}

sub view_row {
	my $proto = shift;
	my $self  = ref($proto) && $proto;
	my $y = shift;
	my $x = 0;
	if ($y > $#{@$self}) {
		return 0;
	}
	my @out;
	for $x (0 .. $#{$$self[$y]}) {
		 push(@out, $$self[$y][$x]);
	}
	return @out;
}

sub view_col {
	my $proto = shift;
	my $self  = ref($proto) && $proto;
	my $x = shift;
	my $y = 0;
	if ($x > $#{$$self[$y]}) {
		return 0;
	}
	my @out;
	for $y (0 .. $#{@$self}) {
		 push(@out, $$self[$y][$x]);
	}
	return @out;
}


sub run {
	my $proto = shift;
	my $self  = ref($proto) && $proto;
	
	my $times = sprintf("%.0f", shift || 1);
	my @newboard; # placeholder

	my ($i, $y, $x, $n, $cols, $surrounding) = 0;
	my $rows = $#{@$self};
	for ($i = 0; $i < $times; $i++) {
		for $y (0 .. $#{@$self}) {
			for $x (0 .. $#{@$self[$y]}) {
				$surrounding = 0;
				$cols = $#{@$self[$y]};
				if ( ($y-1) >= 0) { # north
					if ($$self[$y-1][$x]) {
						$surrounding++;
					}
				}
				if ( ($x+1) <= $cols && ($y-1) >= 0) { # north of east
					if ($$self[$y-1][$x+1]) {
						$surrounding++;
					}
				}

				if ( ($x+1) <= $cols) { # east
					if ($$self[$y][$x+1]) {
						$surrounding++;
					}
				}
				if ( ($x+1) <= $cols && ($y+1) <= $rows) { # south of east
					if ($$self[$y+1][$x+1]) {
						$surrounding++;
					}
				}
				if ( ($y+1) <= $#{@$self}) { # south
					if ($$self[$y+1][$x]) {
						$surrounding++;
					}
				}
				if ( ($x-1) >=0 && ($y+1) <= $rows ) { # south of west
					if ($$self[$y+1][$x-1]) {
						$surrounding++;
					}
				}

				if ( ($x-1) >= 0) { # west
					if ($$self[$y][$x-1]) {
						$surrounding++;
					}
				}
				if ( ($x-1) >= 0 && ($y-1) >= 0) { # north of west
					if ($$self[$y-1][$x-1]) {
						$surrounding++;
					}
				}
				if ($surrounding == 3) {
					$newboard[$y][$x] = 1;
				} elsif ($surrounding == 2) {
					$newboard[$y][$x] = $$self[$y][$x] ? 1 : 0;
				} else {
					$newboard[$y][$x] = 0;
				}
			}
		}

	}
	@$self = @newboard;
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

Statistics::ConwayLife - Perl extension for simple life simulation.

=head1 SYNOPSIS

 use Statistics::ConwayLife;
 my $life = Statistics::ConwayLife->new( ([0, 0, 0],
                                          [1, 1, 1],
                                          [0, 0, 0]) );
 $life->run(1);
 print $life->view_output();

A 3x3 grid is created and run through the algorithm once, then the output is printed.

=head1 METHODS

=item  randomlife($width, $height, $chance);

=over 1

 Returns an array with a random chance of life.
 $width is the width of the array to be created, $height is the 
 height (no surprises there). $chance is the chance (out of one) 
 of each cell containing a 1 (life). For example, if $chance is .3, 
 about 30% of the cells will contain life.

=back

=over 3

 use Statistics::ConwayLife qw( randomlife );
 my $life = Statistics::ConwayLife->new(randomlife(5, 4, .4));
 $life->run(1); 
 print $life->view_output();

=back

=over 1

A 5x4 grid with random life is created. There is a 40% chance of a 
cell having life. The grid is run once, then the output is printed. 

=back

=item $life->view_output()

=over 1

 Returns a string with the data in $life as ones and zeros.
 Line breaks separate each row.

=back

=item $life->view_row($y)

=over 1

 Returns an array of the data in the $y row in $life.

=back

=item $life->view_col($x)

=over 1

 Returns an array of the data in the $x column in $life. 

=back



=head1 DESCRIPTION

Statistics::ConwayLife simulates life using John Conway's algorithm.
A grid of the cells is stored in a 2 dimensional array.

A simple overview of the algorithm: within a grid there are ones
and zeros. Every time the algorithm is run, a cell surrounded by 
3 living cells will stay as it is, a cell surrounded by 2 living 
cells will come to life, and cells surrounded by any other 
number of living cells will become dead. This simple algorithm
is able to describe the behavior of living cells and such quite 
well.

=head1 AUTHOR

Dan Bjorkegren, dan_b@mail.com

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut