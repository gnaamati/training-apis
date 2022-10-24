#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'mysql-eg-prod-1.ebi.ac.uk',
        -user => 'ensro',
        -port => '4238',
);

##Get adaptors
my $tva = $registry->get_adaptor('triticum_aestivum','variation', 'TranscriptVariation');
my $vfa = $registry->get_adaptor('triticum_aestivum', 'variation', 'VariationFeature');
my $ta         = $registry->get_adaptor('triticum_aestivum', 'core', 'Transcript');

##Get transcript and variation feature
my $transcript = $ta->fetch_by_stable_id('TRIAE_CS42_5BL_TGACv1_406377_AA1344780.2');
my $vf = $vfa->fetch_by_dbID('111716');

my $tv = Bio::EnsEMBL::Variation::TranscriptVariation->new(
        -transcript         => $transcript,
        -variation_feature  => $vf,
        -adaptor            => $tva,
        #-disambiguate_single_nucleotide_alleles => $disambiguate_sn_alleles,
        -no_transfer        => 1,
      );

my $cons = $tv->display_consequence;
say $cons;

