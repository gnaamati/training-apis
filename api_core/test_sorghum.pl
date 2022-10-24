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
my $reg_conf = '/homes/gnaamati/registries/prod1.reg';
$registry->load_all($reg_conf);

my $ta           = $registry->get_adaptor("sorghum_bicolor", "core", "transcript");
#my $tr   = $ta->fetch_by_stable_id('HORVU1Hr1G016910.2');
#my $tr   = $ta->fetch_by_stable_id('EES11166');
my $tr   = $ta->fetch_by_dbID(26738);
#say $tr->dbID;);
#say $tr;
#say $tr->dbID;

my $end_exon = '';
my $end_exon_id = '';
foreach my $exon (@{$tr->get_all_Exons()}) {
    if(!$end_exon && $exon->dbID() == $end_exon_id ) {
        say $exon->dbID;
    }
}
        #if(!$start_exon && $exon->dbID() == $start_exon_id ) {
        #  $start_exon = $exon;
        #  last if($end_exon);
        #}

        #if(!$end_exon && $exon->dbID() == $end_exon_id ) {
        #  $end_exon = $exon;
        #  last if($start_exon);
        #}
      #}




#say $transcript->stable_id;
my $transl = $tr->translation;
say $transl->stable_id;










#my $tgene = $gene->transform('');



