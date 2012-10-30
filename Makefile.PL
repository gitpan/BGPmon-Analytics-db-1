use 5.012004;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'BGPmon::Analytics::db',
    VERSION_FROM      => 'lib/BGPmon/Analytics-db.pm', # finds $VERSION
    PREREQ_PM         => { 	'BGPmon::Log' => 0,
				'BGPmon::Translator::XFB2PerlHash::Simple' => 0,
				'BGPmon::Configure'	=> 0,

}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/BGPmon/Analytics-db.pm', # retrieve abstract from module
       AUTHOR         => 'Jason <jason@>') : ()),
);
