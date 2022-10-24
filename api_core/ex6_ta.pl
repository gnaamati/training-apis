#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;


my $registry = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/prod3_gn.reg';
$registry->load_all($reg_conf);

##fetch a gene by its stable identifier
my $gene_adaptor = $registry->get_adaptor("triticum_aestivum", "core", "gene");
my $gene = $gene_adaptor->fetch_by_stable_id('Traes_4DS_4BD85B5C7');

#my $tgene = $gene->transform('');



