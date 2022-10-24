#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::AlignIO;
use feature qw /say/;

my $reg = 'Bio::EnsEMBL::Registry';
$reg->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");
my $gene_mem =$gene_member_adaptor->fetch_by_stable_id('ENSMUSG00000004843');

my $homology_adaptor = $reg->get_adaptor("Multi", "compara", "Homology");

my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-TARGET_SPECIES => 'human', -METHOD_LINK_TYPE => 'ENSEMBL_ORTHOLOGUES');

for my $o (@$orthologs){
    say $o->toString;
    say $o->dn();
    my $simple_align = $o->get_SimpleAlign(-SEQ_TYPE => 'cds');
    #my $alignIO = Bio::AlignIO->newFh(-format => 'clustalw');
    #print $simple_align->percentage_identity;
    my $id =  $simple_align->overall_percentage_identity;
    say $id;
    #print $alignIO $simple_align;
    
    #my $mems = $o->get_all_GeneMembers();
    #for my $m (@$mems){
    #    say $m->stable_id;
    #}
}
die;

#==================
my $mlss_adaptor = $reg->get_adaptor('Multi', 'compara', 'MethodLinkSpeciesSet');
my $mlss = $mlss_adaptor->fetch_by_method_link_type_registry_aliases('ENSEMBL_ORTHOLOGUES', ['human', 'mouse']);

my $count = 0;
my $homology_adaptor = $reg->get_adaptor("Multi", "compara", "Homology");
my $homologs = $homology_adaptor->fetch_all_by_MethodLinkSpeciesSet($mlss);
for my $h (@$homologs){
    if ($h->description =~ 'ortholog_one2one'){
        $count++;
    }
}
say $count;

die;
#==================
my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");
my $gene_mem =$gene_member_adaptor->fetch_by_stable_id('ENSG00000229314');

my $homology_adaptor = $reg->get_adaptor("Multi", "compara", "Homology");

my $orthologs = $homology_adaptor->fetch_all_by_Member($gene_mem,-TARGET_SPECIES => 'human', -METHOD_LINK_TYPE => 'ENSEMBL_ORTHOLOGUES');

for my $o (@$orthologs){
    say $o->description;
    my $mems = $o->get_all_GeneMembers();
    for my $m (@$mems){
        say $m->stable_id;
    }
}




#say $seq_mem->source_name(); 
#say $seq_mem->sequence();

=comment
my $hg_adaptor = $registry->get_adaptor("human", "core", "Gene");
my $genes = $hg_adaptor->fetch_all_by_external_name('FRAS1');
for my $gene (@$genes){
    my $sid =  $gene->stable_id();
    say $sid;
    my $seq_mem =
        $seq_member_adaptor->fetch_by_stable_id($sid);
    say $seq_mem->sequence();

}
=cut


#my $sid = $gene->stable_id();
#say $sid;

#my $seq_member_adaptor = $registry->get_adaptor("Multi", "compara", "SeqMember");
