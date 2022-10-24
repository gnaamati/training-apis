#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/prod3_tgac_var.reg';
$registry->load_all($reg_conf);

my $slice_adaptor =
    Bio::EnsEMBL::Registry->get_adaptor( "triticum_aestivum", "core", "slice" );

#my $slice = $slice_adaptor->fetch_by_region('toplevel',$sseqid);

#my $slice = $slice_adaptor->fetch_by_region( 'toplevel', 'TGACv1_scaffold_000215_1AL',1,183478);
my $slice = $slice_adaptor->fetch_by_region( 'toplevel', 'TGACv1_scaffold_000545_1AL',30000,30100);
#print Dumper $slice;

my $var_features = $slice->get_all_VariationFeatures;

print Dumper $var_features;

for my $vf (@$var_features){
    say $vf->name;
    say $vf->seq_region_name;
    say $vf->allele_string;
    say $vf->seq_region_start(), "-", $vf->seq_region_end();
    say;
}






