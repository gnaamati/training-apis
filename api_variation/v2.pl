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

$va->db->use_vcf(1);
my $name = 'rs1333049';
my $v = $va->fetch_by_name($name);

my $alleles = $v->get_all_Alleles();

for my $al (@$alleles){
  	say $al->allele;
    	if ($al->frequency){
    		say $al->frequency;
	}
 	if ($al->population){
    		say $al->population->name;
	}
	say $al->subsnp_handle;
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

