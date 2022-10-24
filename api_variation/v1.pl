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

my @names = qw/rs1333049 rs56385407 COSM998 CI003207/;

for my $name (@names){
	my $variation = $va->fetch_by_name($name);
	my $source = $variation->source_name();
	my $class = $variation->var_class();
	say "$name\t$class\t$source";;
}




=comment
my $gene_adaptor = $registry->get_adaptor('Human','Core','Gene');


my $adaptors = $registry->get_all_DBAdaptors;

for my $a (@$adaptors){
	my $dbc = $a->dbc;
	say $dbc->dbname;
}

=cut


#print  Dumper $adaptors;

