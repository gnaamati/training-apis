#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

my $ta  = $registry->get_adaptor('human', 'core', 'Transcript');
my $tva = $registry->get_adaptor('human', 'variation', 'TranscriptVariation');
my $va  = $registry->get_adaptor('human', 'variation', 'Variation');
my $vfa = $registry->get_adaptor('human', 'variation', 'VariationFeature');

  # fetch all TranscriptVariations related to a Transcript
my $transcript = $ta->fetch_by_stable_id('ENST00000001008');
for my $tv (@{ $tva->fetch_all_by_Transcripts([$transcript]) }) {
    my $tva = $tv->get_all_alternate_TranscriptVariationAlleles;
    for my $t (@$tva){
        print "Allele string:", $t->allele_string, "\n";
        print "Codon string:", $t->display_codon_allele_string, "\n";
        print "amino acid change: ", $t->pep_allele_string, "\n";
        print "resulting codon: ", $t->codon, "\n";
        print "reference codon: ", $t->transcript_variation->get_reference_TranscriptVariationAllele->codon, "\n";
        print "PolyPhen prediction: ", $t->polyphen_prediction, "\n";
        print "SIFT prediction: ", $t->sift_prediction, "\n";
        say '=========================';
    }
}

=comment
for my $tv (@{ $tva->fetch_all_by_Transcripts([$transcript]) }) {
    my $cons = $tv->display_consequence;

    if ($cons ne 'missense_variant'){   
        next;
    }
    say $cons;
    #print "cdna coords: ", $tv->cdna_start, '-', $tv->cdna_end, "\n";
    #print "cds coords: ", $tv->cds_start, '-', $tv->cds_end, "\n";
    #print "pep coords: ", $tv->translation_start, '-',$tv->translation_end, "\n";
    print "amino acid change: ", $tv->pep_allele_string, "\n";
    #print "codon change: ", $tv->codons, "\n";
    say $tv->variation_feature->variation->name;
}
=cut




