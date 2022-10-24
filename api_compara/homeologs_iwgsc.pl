#!/usr/bin/env perl
use 5.14.0;
use warnings;
use Bio::EnsEMBL::Registry;

#my ($species) = @ARGV;
my $species = 'triticum_aestivum';

my $reg = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/prod2-compara-staging.reg';

$reg->load_all($reg_conf);
#my $reg = $registry;

my $mlss_adaptor = $reg->get_adaptor("Multi", "compara", "MethodLinkSpeciesSet");
my $homology_adaptor = $reg->get_adaptor("Multi", "compara", "Homology");

#my $mlss = $mlss_adaptor->fetch_by_method_link_type_registry_aliases('ENSEMBL_ORTHOLOGUES', ["human", "mouse"]);
my $mlss = $mlss_adaptor->fetch_by_method_link_type_registry_aliases('ENSEMBL_HOMOEOLOGUES', ["$species"]);
my $homeologues = $homology_adaptor->fetch_all_by_MethodLinkSpeciesSet($mlss);


say "gene1\tgene2\tdn\tds\ttaxonomy_level\tdescription";

my $c = 0;
foreach my $hom ( @{ $homeologues } ){
    my $gene_members = $hom->get_all_GeneMembers();
    foreach my $member (@{$gene_members}) {
        print $member->stable_id(),"\t";
    }
    print "\t2102\t2102\n";
    $c++;
    if ($c == 10){
        last;
    }
}

