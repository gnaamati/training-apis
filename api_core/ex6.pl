#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

##fetch a gene by its stable identifier
my $gene_adaptor = $registry->get_adaptor("human", "core", "gene");
my $gene = $gene_adaptor->fetch_by_stable_id('ENSG00000139618');

my $ont_adaptor = $registry->get_adaptor("Multi", "Ontology", "OntologyTerm");

my $db_links = $gene->get_all_DBLinks('GO');
for my $db_link (@$db_links){
    say $db_link->display_id;
    my $ont = $ont_adaptor->fetch_by_accession($db_link->display_id);
    say $ont->definition;
}

