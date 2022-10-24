#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;
use Bio::AlignIO;

my $reg = 'Bio::EnsEMBL::Registry';
$reg->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

my $tree_adaptor = $reg->get_adaptor("Multi", "compara", "GeneTree");

my $trees = $tree_adaptor->fetch_all();

for my $tree (@$trees){
    #print Dumper $tree;
    $tree->print_tree();
    die('');
}


#my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");
#my $gene_mem =  $gene_member_adaptor->fetch_by_stable_id('ENSG00000238344');
#my $tree = $tree_adaptor->fetch_default_for_Member($gene_mem);

#my $members = $tree->get_all_Members;
#for my $m (@$members){
#    say $m->stable_id;
#}

#my $simple_align = $tree->get_SimpleAlign();
#my $alignIO = Bio::AlignIO->newFh(-format => 'clustalw');
#print $alignIO $simple_align;


=comment
Print all the members of the tree containing the human ncRNA gene ENSG00000238344, and their alignment
Create a script which gets the Bio::EnsEMBL::Compara::GeneMember for the human gene ENSG00000238344. Get the corresponding gene tree and print its leaves. In other words, you will print all the homologues of the human gene.

Hint: Get the tree for this gene member by calling fetch_default_for_Member(). Use the get_all_Members() method to retrieve the list of all the leaves (members), and print their stable ID. As in the first exercise of the Family section, use get_SimpleAlign() to print the alignment.



my $tree = $tree_adaptor->fetch_by_stable_id('ENSGT00390000003602');

$tree->print_tree();
=cut

