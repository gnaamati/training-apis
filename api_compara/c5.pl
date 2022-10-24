#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $reg = 'Bio::EnsEMBL::Registry';
$reg->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

#my $genome_db_adaptor = Bio::EnsEMBL::Registry->get_adaptor( "Multi", "compara", "GenomeDB");
my $mlss_adaptor = $reg->get_adaptor("Multi", "compara", "MethodLinkSpeciesSet");

#Print the list of the species for the 13 eutherian mammals EPO alignments
#Hint:use the MethodLinkSpeciesSet adaptor fetch_by_method_link_type_species_set_name() method, and then the MethodLinkSpeciesSet (object) species_set_obj()->genome_dbs() method (this brings back a list-ref of GenomeDB objects). The method_link_type is EPO and the species_set_name is mammals.

my $mlss = 
    $mlss_adaptor->fetch_by_method_link_type_species_set_name("EPO", "mammals");

my $gdbs = $mlss->species_set_obj()->genome_dbs();
for my $gdb (@$gdbs){
    if ($gdb){
        say $gdb->name,'--',$gdb->taxon->common_name;
    }
}
die('');




#my $gorilla_mlss_list = $mlss_adaptor->fetch_all_by_GenomeDB( $gorilla_genome_db );
#my $all = $mlss_adaptor->fetch_all();

#my $all_types = $mlss_adaptor->method->type();

#my $count;
#for my $a (@$all){
#    my $type = $a->method->type();
#    say $type;
    #$count++;
#}
#say $count;



#my $homo_s = $genome_db_adaptor->fetch_by_registry_name('chimp');


