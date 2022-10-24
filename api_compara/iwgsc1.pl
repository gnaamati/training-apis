#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::AlignIO;
use Data::Dumper;
use feature qw /say/;

my $reg = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/compara_test_iwgsc.reg';
$reg->load_all($reg_conf);

my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");
my $gene_mem =$gene_member_adaptor->fetch_by_stable_id('TRIAE_CS42_3AL_TGACv1_196076_AA0657130');
#my $gene_mem =$gene_member_adaptor->fetch_by_stable_id('HORVU3Hr1G071120');
print Dumper $gene_mem;

my $homology_adaptor = $reg->get_adaptor("Multi", "compara", "Homology");

#my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-TARGET_SPECIES => 'hordeum_vulgare');
#my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-TARGET_SPECIES => 'hordeum_vulgare', -METHOD_LINK_TYPE => 'ENSEMBL_ORTHOLOGUES');
#my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-TARGET_SPECIES => 'hordeum_vulgare');

#my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-TARGET_SPECIES => 'triticum_iwgsc');
#my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-TARGET_SPECIES => 'glycine_max');
#my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-TARGET_SPECIES => 'solanum_lycopersicum');

my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-METHOD_LINK_TYPE => 'ENSEMBL_ORTHOLOGUES');

for my $o (@$orthologs){
    say $o->toString;
    say $o->dn();
    #my $simple_align = $o->get_SimpleAlign(-SEQ_TYPE => 'cds');
    #my $alignIO = Bio::AlignIO->newFh(-format => 'clustalw');
    #print $alignIO $simple_align;
    
    #my $mems = $o->get_all_GeneMembers();
    #for my $m (@$mems){
    #    say $m->stable_id;
    #}
}
