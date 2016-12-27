#!perl

use Test::More;
use File::Spec::Unix;
use File::Spec::Functions qw(catfile rel2abs);
use File::Slurp::Tiny qw(write_file);
use File::Path qw(make_path);
use Git::Raw::Odb::Backend::SQLite;

my $native_path = rel2abs(catfile('t', 'test_repo'));
my $path = File::Spec::Unix -> rel2abs(File::Spec::Unix -> catfile('t', 'test_repo'));
make_path($path);

my $repo = Git::Raw::Repository -> init($native_path, 0);
isa_ok $repo, 'Git::Raw::Repository';

my $sqlite = Git::Raw::Odb::Backend::SQLite->new (catfile($repo->path, 'odb.db'));
isa_ok $sqlite, 'Git::Raw::Odb::Backend';

my $odb = Git::Raw::Odb->new();
$odb->add_backend($sqlite, 99);
is $odb->backend_count, 1;

$repo->odb($odb);

my $file  = $repo->workdir.'test';
write_file($file, 'this is a test');

my $index = $repo->index;
$index->add('test');

my $tree = $index->write_tree;
isa_ok $tree, 'Git::Raw::Tree';

my $time = 1482678859;
my $me = Git::Raw::Signature->new('me', 'me@home', $time, 0);
my $commit = Git::Raw::Commit->create($repo, "initial commit\n", $me, $me, [], $tree);
isa_ok $commit, 'Git::Raw::Commit';
is $commit->id, '6f0f7cd9bc75988e6534759f4e0a8ce65aa71bcd';

my $lookup = Git::Raw::Commit->lookup($repo, $commit->id);
ok(defined($lookup));

done_testing;
