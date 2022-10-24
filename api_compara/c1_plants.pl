#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $reg = 'Bio::EnsEMBL::Registry';
#my $reg_conf = '/homes/gnaamati/registries/compara_gene_tree.reg';
my $reg_conf = '/homes/gnaamati/registries/compara_prod_3.reg';
$reg->load_all($reg_conf);

#$registry->load_registry_from_db(
#	-host   => 'mysql-eg-prod-1.ebi.ac.uk',
#	-user   => 'ensro',
#        -port   => 4238,
        #-dbname => 'ensembl_compara_plants_hom_32_85'
	#-verbose=> 1
#);

my $genome_db_adaptor = Bio::EnsEMBL::Registry->get_adaptor( "Multi", "compara", "GenomeDB");
my $list_ref_of_gdbs = $genome_db_adaptor->fetch_all();
my $c = 0;
foreach my $genome_db( @{ $list_ref_of_gdbs } ){
    $c++;
     print join( "\t",$genome_db->name(),$genome_db->genebuild(),$genome_db->assembly(),),"\n";
}

say $c;

__END__


#my $homo_s = $genome_db_adaptor->fetch_by_registry_name('chimp');
my $test = $genome_db_adaptor->fetch_by_registry_name('oryza_sativa');

my $dnafrag_adaptor = $registry->get_adaptor("Multi", "compara", "DnaFrag");
my $chimp_chr_dnafrags = 
    $dnafrag_adaptor->fetch_all_by_GenomeDB_region( $test, 'chromosome' );

foreach my $dnafrag (@{ $chimp_chr_dnafrags }){
    print "Chromsome ", $dnafrag->name(), " contains ", $dnafrag->length(), " bp.\n";
}

