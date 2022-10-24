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

my $family_adaptor = $reg->get_adaptor("Multi", "compara", "Family");


my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");
my $gene_mem =  $gene_member_adaptor->fetch_by_stable_id('ENSG00000139618');

my $families = $family_adaptor->fetch_all_by_GeneMember($gene_mem);
for my $fam (@$families){
    say $fam->description();
    my $mems = $fam->get_all_Members();
    for my $mem (@$mems){
        print $mem->source_name(), " ", $mem->stable_id(), " (", $mem->taxon()->name(),")--";
        say $mem->taxon()->common_name;
        #say $mem->stable_id;
    }
}




=comment
my $family = $family_adaptor->fetch_by_stable_id('ENSFM00250000006121');

my $simple_align = $family->get_SimpleAlign();
my $alignIO = Bio::AlignIO->newFh(-format => 'clustalw');
print $alignIO $simple_align;
=cut


