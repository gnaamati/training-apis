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

  my $ta = $registry->get_adaptor('triticum_aestivum', 'core', 'transcript');
  my $sa = $registry->get_adaptor('triticum_aestivum', 'core', 'Slice');

  my $tr_id = 'TRIAE_CS42_5BL_TGACv1_406377_AA1344780.1';
  my $tr = $ta->fetch_by_stable_id($tr_id);

  my $slice = $sa->fetch_by_transcript_stable_id(
    $tr->stable_id, 
    #$max_distance
  );

  $tr = $tr->transfer($slice);

  use Data::Dumper;
  $Data::Dumper::Maxdepth = 3;
  $Data::Dumper::Indent = 1;
  print STDERR Dumper $tr->get_TranscriptMapper->genomic2cdna(225, 225, 1);
}
