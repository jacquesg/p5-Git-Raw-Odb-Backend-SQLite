package Git::Raw::Odb::Backend::SQLite;

use strict;
use warnings;

use Git::Raw;
use DBD::SQLite;

require XSLoader;
XSLoader::load('Git::Raw::Odb::Backend::SQLite', $Git::Raw::Odb::Backend::SQLite::VERSION);

=head1 NAME

Git::Raw::Odb::Backend::SQLite - SQLite backend for Git::Raw

=head1 SYNPOSIS

	use Git::Raw;
	use Git::Raw::Odb::Backend::SQLite;

	my $repo = Git::Raw::Repository->open('somepath/');
	my $sqlite = Git::Raw::Odb::Backend::SQLite->new('databasefile.db');

	my $odb = $repo->odb;
	$odb->add_backend($sqlite, 99);

=head1 DESCRIPTION

A SQLite backend for L<C<Git::Raw>>.

=head1 METHODS

=head2 new( $file )

Create a new backend instance using C<$file> as the database file.

=head1 AUTHOR

Jacques Germishuys <jacquesg@striata.com>

=head1 LICENSE AND COPYRIGHT

Copyright 2016 Jacques Germishuys.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Git::Raw::Odb::Backend::SQLite
