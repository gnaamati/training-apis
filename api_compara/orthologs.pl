#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);

my $reg = $registry;

my $mlss_adaptor = $reg->get_adaptor("Multi", "compara", "MethodLinkSpeciesSet");
my $homology_adaptor = $reg->get_adaptor("Multi", "compara", "Homology");

my $mlss = $mlss_adaptor->fetch_by_method_link_type_registry_aliases('ENSEMBL_ORTHOLOGUES', ["human", "mouse"]);
my $orthologs = $homology_adaptor->fetch_all_by_MethodLinkSpeciesSet($mlss);

my $c = 0;
foreach my $orth ( @{ $orthologs } ){
    my $gene_members = $orth->get_all_GeneMembers();
    foreach my $member (@{$gene_members}) {
        print $member->stable_id(),"\t";
    }

    print $orth->dn,"\t";
    print $orth->ds,"\t";
    print $orth->taxonomy_level,"\t";
    print $orth->description,"\n";

    #print $orth->toString(), "\n" if $orth->is_tree_compliant();
    $c++;
    last if $c >= 100;
}
