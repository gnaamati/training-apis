#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

##fetch a gene by its stable identifier
my $gene_adaptor = $registry->get_adaptor("human", "core", "gene");
my $gene = $gene_adaptor->fetch_by_stable_id('ENSG00000123427');
#my $gene = $gene_adaptor->fetch_by_display_label('CSNK2A1');

#print out the gene, its transcripts, and its exons
print "Gene: ", get_string($gene), "\n";

my $transcripts = $gene->get_all_Transcripts;
for my $t (@$transcripts){
    #print Dumper $t;
    #my $translation = $t->translation;
    #print "Translation: ", $translation->stable_id, "\n";
    #die;
    
    print "transcript: ", get_string($t), "\n";
    my $exons = $t->get_all_Exons;
    for my $e (@$exons){
        print "exons ", get_string($e), "\n";
    }
}

# helper function: returns location and stable_id string for a feature
sub get_string {
    my $feature = shift;
    my $stable_id = $feature->stable_id;
    my $seq_region = $feature->slice->seq_region_name;
    my $start = $feature->start;
    my $end = $feature->end;
    my $strand = $feature->strand;
    return "$stable_id $seq_region:$start-$end($strand)";
}






























