#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;


my $registry = 'Bio::EnsEMBL::Registry';
#my $reg_conf = '/homes/gnaamati/registries/prod3_gn.reg';
#my $reg_conf = '/homes/gnaamati/registries/prod3_ta_ver1.reg';
my $reg_conf = '/homes/gnaamati/registries/prod1.reg';
$registry->load_all($reg_conf);

say "getting slice\n";

##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("hordeum_vulgare", "core", "slice");
my $slice         = $slice_adaptor->fetch_by_region('toplevel','HVVMRXALLEA0018H22_C4');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_1AL_scaff_3877574');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_2BL_scaff_7951634');
#my $sub_slice = $slice->sub_Slice(134089,134533,-1);
#my $sub_slice = $slice->sub_Slice(76212,76835,-1);
my $sub_slice = $slice->sub_Slice(50,100);

#say "==========================================";
say $sub_slice->seq;


my $gene_adaptor  = $registry->get_adaptor("hordeum_vulgare", "core", "gene");
my $gene          = $gene_adaptor->fetch_by_stable_id('HORVU7Hr1G104340');

say $gene->stable_id;









#my $tgene = $gene->transform('');



