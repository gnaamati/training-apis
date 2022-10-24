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

my $slice = $slice_adaptor->fetch_by_region( 'chromosome', '20', 1, 500_000 );

my $repeat_feats = $slice->get_all_RepeatFeatures();

#Get all the repeat features from chromosome 20:1-500k. Print out
#the name and position of each on the chromosome and the total
#number.

my $count;
for my $rf (@$repeat_feats){
	my $id = $rf->display_id;

	my $s = $rf->hstart;
	my $e = $rf->hend;
	say "$id\t$s\t$e\n";
	$count++;	
}

#say "count is $count";

=comment
Find which genomic region the RefSeq dna entry NM_000059.3
was mapped to. Print the name of the region and coordinates of
the alignment on the genome as well as the name of the region
and coordinates of the alignment on the RefSeq dna entry. Print
the score and percentage identity for the alignment.
ü 
hint: use DnaAlignFeatureAdaptor; use the core schema documentation
as a guide to appropriate methods which correspond to columns in
dna_align_feature table

=cut

my  $dafa = $registry->get_adaptor( 'Human', 'Core', 'DnaAlignFeature' );
my @feats = @{ $dafa->fetch_all_by_hit_name('NM_000059.3') };
for my $f (@feats){
	#print Dumper $f;
	#die('');
	my $perc_iden = $f->percent_id;
	say "-->$perc_iden";
}






























