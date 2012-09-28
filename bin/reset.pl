#!/usr/bin/perl

=head1 NAME

reset.pl - A script to reset a BGP database to an empty state

=cut

=head1 DEPENDENCIES

The following Perl modules must be installed to use this script:

Getopt::Long

=cut

=head1 USAGE

> ./reset.pl --dbname=database --dblogin=username

=cut

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2012 Colorado State University

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom
    the Software is furnished to do so, subject to the following
    conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.\

    File: reset.pl

    Authors: Jason Bartlett
    Date: 17 August 2012

=cut

BEGIN{
        our $VERSION = '1.02';
};

use strict;
use warnings;
use Getopt::Long;

#Variables to hold the database name and login name
#The default value for both values is just the user's name
my $dbname = getlogin || getpwuid($<);
my $dblogin = getlogin || getpwuid($<);
my $ret = GetOptions(	"dbname=s" => \$dbname,
			"dblogin=s" => \$dblogin);

#Run command to clear the tables
`psql -c "DROP TABLE timeranges,peers,prefixes,ppms,update_import CASCADE;" $dbname $dblogin`;

#Restore the table structure and function definitions
`psql -f ../src/0_table_reset $dbname $dblogin`;
`psql -f ../src/1_import_functions $dbname $dblogin`;

1;
