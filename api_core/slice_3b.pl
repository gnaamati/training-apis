#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;


my $registry = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/prod3_3B.reg';
$registry->load_all($reg_conf);

say "getting slice\n";

##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("triticum_aestivum", "core", "slice");
my $slice         = $slice_adaptor->fetch_by_region('toplevel','3B');
#134089, 134533, 1, 445,-1

#say $slice->seq;

#my $sub_slice = $slice->sub_Slice(1,941);
#my $sub_slice = $slice->sub_Slice(866,1761);
#my $sub_slice = $slice->sub_Slice(1,788);
#my $sub_slice = $slice->sub_Slice(774365866,774366366);
my $sub_slice = $slice->sub_Slice(536572883, 536573274);

say "==========================================";
say $sub_slice->seq;


#========================================= 
#my $reg_conf = '/homes/gnaamati/registries/prod3_gn.reg';
$reg_conf = '/homes/gnaamati/registries/prod3_gn.reg';
$registry->load_all($reg_conf);


##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("triticum_aestivum", "core", "slice");
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_249002_3B');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_247204_3B');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_249014_3B');
my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_249016_3B');

#my $sub_slice = $slice->sub_Slice(204615,205555,-1);
#my $sub_slice = $slice->sub_Slice(202633,203528,-1);
#my $sub_slice = $slice->sub_Slice(488,569,-1);
#my $sub_slice = $slice->sub_Slice(310,363,1);
my $sub_slice = $slice->sub_Slice(109,500,-1);

say "==========================================";
say $sub_slice->seq;

#774434471       767352450       767352532       TGACv1_scaffold_247204_3B       -       684     115     197     76/82




#my $tgene = $gene->transform('');



