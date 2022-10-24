#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'mysql-ens-plants-prod-1',
        -user => 'ensro',
        -port => '4243',
);

my $slice_adaptor =
    Bio::EnsEMBL::Registry->get_adaptor( "arabidopsis_thaliana", "core", "slice" );

my $slice = $slice_adaptor->fetch_by_region( 'chromosome', '1', 10000, 20000);
my $var_features = $slice->get_all_VariationFeatures;

for my $vf (@$var_features){
    say $vf->name;
    say $vf->seq_region_name;
    say $vf->allele_string;
    say $vf->seq_region_start(), "-", $vf->seq_region_end();
    say;
}






