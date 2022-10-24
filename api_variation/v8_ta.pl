#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';

my $reg_conf = '/homes/gnaamati/registries/prod3_tgac_var.reg';
$registry->load_all($reg_conf);

#
my $tva = $registry->get_adaptor('triticum_aestivum','variation', 'TranscriptVariation');
#

my $ta         = $registry->get_adaptor('triticum_aestivum', 'core', 'Transcript');
my $transcript = $ta->fetch_by_stable_id('Traes_2DS_698DAD811.1');

#my $tva = $registry->get_adaptor('human', 'variation', 'TranscriptVariation');
#my $va  = $registry->get_adaptor('human', 'variation', 'Variation');
#my $vfa = $registry->get_adaptor('human', 'variation', 'VariationFeature');


for my $tv (@{ $tva->fetch_all_by_Transcripts([$transcript]) }) {
    my $cons = $tv->display_consequence;

    #if ($cons ne 'missense_variant'){   
    #    next;
    #}
    say $cons;
    print "cdna coords: ", $tv->cdna_start, '-', $tv->cdna_end, "\n";
    print "cds coords: ", $tv->cds_start, '-', $tv->cds_end, "\n";
    print "pep coords: ", $tv->translation_start, '-',$tv->translation_end, "\n";
    print "amino acid change: ", $tv->pep_allele_string, "\n";
    #print "codon change: ", $tv->codons, "\n";
    say $tv->variation_feature->variation->name;
}




