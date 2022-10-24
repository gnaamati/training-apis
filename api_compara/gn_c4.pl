#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;
use Bio::AlignIO;

my $reg = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/compara_gene_tree.reg';
$reg->load_all($reg_conf);

my $tree_adaptor = $reg->get_adaptor("Multi", "compara", "GeneTree");
my $tree = $tree_adaptor->fetch_by_stable_id('EPlGT00750000068395');
#$tree->print_tree();


my $members = $tree->get_all_Members;
for my $m (@$members){
    if ($m->stable_id =~ /TGACv1/){
        say $m->stable_id;
    }
}


