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
my $v = $va->fetch_by_name('rs671');

my $vfs = $v->get_all_VariationFeatures();
for my $vf (@$vfs){
    say $vf->seq_region_name;
    say $vf->allele_string;
    say $vf->seq_region_start(), "-", $vf->seq_region_end();
    say;
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

