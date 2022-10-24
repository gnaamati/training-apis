#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;


my $registry = 'Bio::EnsEMBL::Registry';
#my $reg_conf = '/homes/gnaamati/registries/stage2.reg';
my $reg_conf = '/homes/egcomp1/Registries/registry.mysql-prod-2-ensrw.v85.pm';
$registry->load_all($reg_conf);

##fetch a gene by its stable identifier
my $exon_adaptor = $registry->get_adaptor("zea_mays", "core", "exon");
my $exon = $exon_adaptor->fetch_by_stable_id('Zm00001d001682_T001.exon1');


my $trans_adaptor = $registry->get_adaptor("zea_mays", "core", "transcript");
my $trans = $trans_adaptor->fetch_by_stable_id('Zm00001d001682_T001');

my @coords = $trans->genomic2cdna($exon->start(), $exon->end(), $exon->strand());

if(@coords && !$coords[-1]->isa('Bio::EnsEMBL::Mapper::Gap')) {
    say "all is well!!\n";
}


print Dumper \@coords;


my $eid = $exon->dbID();
say $eid;


my $tid = $trans->dbID();
say $tid;





#my $tgene = $gene->transform('');



