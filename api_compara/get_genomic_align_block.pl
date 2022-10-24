#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $reg = 'Bio::EnsEMBL::Registry';
#my $reg_conf = '/homes/gnaamati/registries/compara_prod_3.reg';
my $reg_conf = '/homes/gnaamati/registries/prod1-compara-merged.reg';
$reg->load_all($reg_conf);
#my $slice_adaptor = $reg->get_adaptor("triticum_aestivum", "core", "slice");
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_250239_3DL');

my $genomedb_adaptor  = $reg->get_adaptor("Multi", "compara", 'GenomeDB');
my $genome_db_adaptor = Bio::EnsEMBL::Registry->get_adaptor( "Multi", "compara", "GenomeDB");

my $genomedb = $genome_db_adaptor->fetch_by_registry_name('triticum_aestivum');
say $genomedb->dbID;


my $mlss_adaptor = $reg->get_adaptor("Multi", "compara", "MethodLinkSpeciesSet");

my $mlss = $mlss_adaptor->fetch_by_method_link_type_GenomeDBs('POLYPLOID', [$genomedb], 1);
say $mlss->dbID;

my $genomic_align_block_adaptor = $reg->get_adaptor("Multi", "compara", "GenomicAlignBlock");

#my $genomic_align_blocks = $genomic_align_block_adaptor->fetch_all_by_MethodLinkSpeciesSet_Slice($mlss, $slice);

#my $length = scalar (@$genomic_align_blocks);
#say "length = $length";

