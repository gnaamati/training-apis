#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

my $va = $registry->get_adaptor('human','variation', 'variation');

my $name = 'rs671';
my $v = $va->fetch_by_name($name);

my $publications = $v->get_all_Publications();

for my $p (@$publications){
    say $p->title;
    say $p->pmid;
    say $p->year;
    say "======";
}


my $pa = $registry->get_adaptor('human','variation', 'publication');
my $pub = $pa->fetch_by_pmid(18187665); 
my $vars = $pub->variations;

for my $v (@$vars){
    say $v->name;
}




