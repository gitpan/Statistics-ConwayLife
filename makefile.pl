use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'Statistics::ConwayLife',
    'VERSION_FROM' => 'ConwayLife.pm', # finds $VERSION
	($] ge '5.005') ? (
        'AUTHOR' => 'Dan Bjorkegren (dan_b@mail.com)',
        'ABSTRACT' => 'Perl extension for simple life simulation',
    ) : (),

);
