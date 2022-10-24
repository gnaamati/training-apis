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

{

  my $ga = $registry->get_adaptor('triticum_aestivum', 'core', 'Gene');
  my $sa = $registry->get_adaptor('triticum_aestivum', 'core', 'Slice');
  my $tva = $registry->get_adaptor('triticum_aestivum','variation', 'TranscriptVariation');

  my $gene_id = 'TRIAE_CS42_5BL_TGACv1_406377_AA1344780';
  my $gene = $ga->fetch_by_stable_id($gene_id) 
    or die "failed to fetch gene for stable id: $gene_id";

  my $slice = $sa->fetch_by_gene_stable_id(
    $gene->stable_id, 
    #$max_distance
  ) or die "failed to get slice around gene: ".$gene->stable_id;

  $gene = $gene->transfer($slice);

  my @vfs = (
    @{ $slice->get_all_VariationFeatures },
  );


  for my $transcript (@{ $gene->get_all_Transcripts }) {
    warn "transcript: ",$transcript->stable_id,"\n";

    for my $vf(@vfs) {

      warn "variation feature id:",$vf->dbID,"\n";

      my $tv = Bio::EnsEMBL::Variation::TranscriptVariation->new(
        -transcript     => $transcript,
        -variation_feature  => $vf,
        -adaptor      => $tva,
        #-disambiguate_single_nucleotide_alleles => $disambiguate_sn_alleles,
        -no_transfer    => 1,
      );

      my $cons = $tv->display_consequence;
      warn "consequence: $cons\n";
    }
  }
}

1;
