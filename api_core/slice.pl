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
#my $reg_conf = '/homes/gnaamati/registries/prod1.reg';
my $reg_conf = '/homes/gnaamati/registries/prod3_77.reg';
$registry->load_all($reg_conf);

say "getting slice\n";

##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("triticum_aestivum", "core", "slice");
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_1AL_scaff_3976225');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_1AL_scaff_3877574');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_1AL_scaff_3966124');
my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_1AL_scaff_1970132');
#134089, 134533, 1, 445,-1

#say $slice->seq;

#my $sub_slice = $slice->sub_Slice(1,941);
#my $sub_slice = $slice->sub_Slice(866,1761);
#my $sub_slice = $slice->sub_Slice(1,788);
#my $sub_slice = $slice->sub_Slice(1315,1938);
my $sub_slice = $slice->sub_Slice(1323,1328);

say "==========================================";
say $sub_slice->seq;



#========================================= 
my$reg_conf = '/homes/gnaamati/registries/prod3_gn.reg';
$registry->load_all($reg_conf);


##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("triticum_aestivum", "core", "slice");
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_000001_1AL');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_130745_2BL');
my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_002985_1AL');

#my $sub_slice = $slice->sub_Slice(204615,205555,-1);
#my $sub_slice = $slice->sub_Slice(202633,203528,-1);
#my $sub_slice = $slice->sub_Slice(134089,134533,-1);
#my $sub_slice = $slice->sub_Slice(76212,76835,-1);
#my $sub_slice = $slice->sub_Slice(17932,17932, 1);
my $sub_slice = $slice->sub_Slice(17927,17932,1);
#my $sub_slice = $slice->sub_Slice(17927,17932,-1);
#my $sub_slice = $slice->sub_Slice(74879, 78149,-1);

#say "==========================================";
say $sub_slice->seq;





#my $tgene = $gene->transform('');



