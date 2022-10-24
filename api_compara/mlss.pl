#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);

my $reg = $registry;

my $gdb_a = $reg->get_adaptor( "Multi", "compara", "GenomeDB" );
my $gorilla_genome_db   = $gdb_a->fetch_by_registry_name("gorilla");

my $mlss_adaptor = $reg->get_adaptor("Multi", "compara", "MethodLinkSpeciesSet");
my $gorilla_mlss_list = $mlss_adaptor->fetch_all_by_GenomeDB( $gorilla_genome_db );

my $c = 0;
foreach my $mlss ( @{ $gorilla_mlss_list } ) {
    print join( "\t", $mlss->dbID(), $mlss->method->type() ), "\n";
    $c++;
    last if $c >= 100;
}
