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

my $gene_adaptor = $registry->get_adaptor('Human','Core','Gene');


my $adaptors = $registry->get_all_DBAdaptors;

for my $a (@$adaptors){
	my $dbc = $a->dbc;
	say $dbc->dbname;
}


#print  Dumper $adaptors;

