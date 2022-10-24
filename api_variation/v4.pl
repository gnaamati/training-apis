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

my $slice_adaptor =
    Bio::EnsEMBL::Registry->get_adaptor( "human", "core", "slice" );

my $slice = $slice_adaptor->fetch_by_region( 'chromosome', '13', 48987260, 48990000 );
my $var_features = $slice->get_all_VariationFeatures;

for my $vf (@$var_features){
    say $vf->name;
    say $vf->seq_region_name;
    say $vf->allele_string;
    say $vf->seq_region_start(), "-", $vf->seq_region_end();
    say;
}






