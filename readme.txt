                      Statistics::ConwayLife
          Perl extension for simple life simulation.
NAME
    Statistics::ConwayLife - Perl extension for simple life
    simulation.

SYNOPSIS
     use Statistics::ConwayLife;
     my $life = Statistics::ConwayLife->new( ([0, 0, 0],
                                              [1, 1, 1],
                                              [0, 0, 0]) );
     $life->run(1);
     print $life->view_output();

    A 3x3 grid is created and run through the algorithm once, then
    the output is printed.

METHODS
    randomlife($width, $height, $chance);
      Returns an array with a random chance of life.
      $width is the width of the array to be created, $height is the
      height (no surprises there). $chance is the chance (out of one)
      of each cell containing a 1 (life). For example, if $chance is .3,
      about 30% of the cells will contain life.

        use Statistics::ConwayLife qw( randomlife );
        my $life = Statistics::ConwayLife->new(randomlife(5, 4, .4));
        $life->run(1);
        print $life->view_output();

     A 5x4 grid with random life is created. There is a 40% chance
     of a cell having life. The grid is run once, then the output is
     printed.

    $life->view_output()
      Returns a string with the data in $life as ones and zeros.
      Line breaks separate each row.

    $life->view_row($y)
      Returns an array of the data in the $y row in $life.

    $life->view_col($x)
      Returns an array of the data in the $x column in $life.

DESCRIPTION
    Statistics::ConwayLife simulates life using John Conway's
    algorithm. A grid of the cells is stored in a 2 dimensional
    array.

    A simple overview of the algorithm: within a grid there are ones
    and zeros. Every time the algorithm is run, a cell surrounded by
    3 living cells will stay as it is, a cell surrounded by 2 living
    cells will come to life, and cells surrounded by any other
    number of living cells will become dead. This simple algorithm
    is able to describe the behavior of living cells and such quite
    well.

VERSION HISTORY
    .52 - final release (nothing changed except status)
    .51 - beta release  (internals improved, package name changed to 
          Statistics::ConwayLife)
    .50 - alpha release (released under package Simulate::ConwayLife)

AUTHOR
    Dan Bjorkegren, dan_b@mail.com

    This library is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.