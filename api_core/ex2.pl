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

my $slice_adaptor =
    Bio::EnsEMBL::Registry->get_adaptor( "human", "core", "slice" );

  # get a slice for each clone in the database
#for my $ch_slice ( @{ $slice_adaptor->fetch_all('chromosome') } ) {
#	say $ch_slice->seq_region_name();
	#say $ch_slice->length();
    # do something with clone
# }

#die('');

=comment
Fetch the sequence of the first 10MB of chromosome 20 and write
it to a file in FASTA format. Print the number of genes in this
region.
hint: Slice objects inherit from Bio::Seq so can be written to file easily using
Bio::SeqIO, e.g.:
my $output = Bio::SeqIO->new( -file=>'>filename.fasta',
-format=>'Fasta');
$output->write_seq($slice);
=cut


my $slc = $slice_adaptor->fetch_by_gene_stable_id('ENSG00000101266',2000);

my $slice2 = $slice_adaptor->fetch_by_region( 'chromosome', '20', 1, 1e6 );
#my $output = Bio::SeqIO->new( -file=>'>filename.fasta', -format=>'Fasta');
#$output->write_seq($slice2);

my $count;
for my $gene ( @{ $slice2->get_all_Genes } ) {
	say $gene->stable_id;
}
say "count is $count";






