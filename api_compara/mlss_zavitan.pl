#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $reg = 'Bio::EnsEMBL::Registry';
#my $reg_conf = '/homes/gnaamati/registries/compara_prod_3.reg';
my $reg_conf = '/homes/gnaamati/registries/prod2-compara-master.reg';
$reg->load_all($reg_conf);

#my $genomedb_adaptor            = $reg->get_adaptor("Multi", "compara", 'GenomeDB');
#my $genome_db_adaptor = Bio::EnsEMBL::Registry->get_adaptor( "Multi", "compara", "GenomeDB");
    
#my $genomedb = $genome_db_adaptor->fetch_by_registry_name('triticum_aestivum');
#say $genomedb->dbID;


my $mlss_adaptor = $reg->get_adaptor("Multi", "compara", "MethodLinkSpeciesSet");
my $mlss_id = 9741;
my $mlss_id = 200411;

#my $gorilla_mlss_list = $mlss_adaptor->fetch_all_by_GenomeDB('');

#my $c = 0;
#foreach my $mlss ( @{ $gorilla_mlss_list } ) {
#    print join( "\t", $mlss->dbID(), $mlss->method->type() ), "\n";
    
#}


my $mlss = $mlss_adaptor->fetch_by_dbID($mlss_id);

#print Dumper $mlss;




#my $mlss = $mlss_adaptor->fetch_by_method_link_type_GenomeDBs('POLYPLOID', [$genomedb], 1);
#say $mlss->dbID;

