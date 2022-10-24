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

#========================================= 
my $reg_conf = '/homes/gnaamati/registries/eg_mirror.reg';
$registry->load_all($reg_conf);


##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("aegilops_tauschii", "core", "slice");
#my $slice        = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_000001_1AL');

my $slice         = $slice_adaptor->fetch_by_region('toplevel','Scaffold154377');

#my $sub_slice = $slice->sub_Slice(204615,205555,-1);
#my $sub_slice = $slice->sub_Slice(202633,203528,-1);
#my $sub_slice = $slice->sub_Slice(134089,134533,-1);
#my $sub_slice = $slice->sub_Slice(76212,76835,-1);
#my $sub_slice = $slice->sub_Slice(17932,17932, 1);
#my $sub_slice = $slice->sub_Slice(17927,17932,1);
#my $sub_slice = $slice->sub_Slice(17927,17932,-1);
#my $sub_slice = $slice->sub_Slice(74879, 78149,-1);

#say "==========================================";
#
#
#my $start = 57857 ;
my $start = 1 ;
#my $end  =  $start + 464;
my $end  =  537;
my $sub_slice2 = $slice->sub_Slice($start,$end,-1);
my $seq2 = $sub_slice2->seq;
say "================seq==old==========================";
say $seq2;
say "================seq2==========================";



#my $tgene = $gene->transform('');



