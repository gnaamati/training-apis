#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

my $genome_db_adaptor = Bio::EnsEMBL::Registry->get_adaptor( "Multi", "compara", "GenomeDB");
my $list_ref_of_gdbs = $genome_db_adaptor->fetch_all();
foreach my $genome_db( @{ $list_ref_of_gdbs } ){
     print join( "\t",$genome_db->name(),$genome_db->dbID(),$genome_db->assembly(),),"\n";
}


#my $homo_s = $genome_db_adaptor->fetch_by_registry_name('chimp');

#my $dnafrag_adaptor = $registry->get_adaptor("Multi", "compara", "DnaFrag");
#my $chimp_chr_dnafrags = 
#    $dnafrag_adaptor->fetch_all_by_GenomeDB_region( $homo_s, 'chromosome' );

#foreach my $dnafrag (@{ $chimp_chr_dnafrags }){
#    print "Chromsome ", $dnafrag->name(), " contains ", $dnafrag->length(), " bp.\n";
#}

