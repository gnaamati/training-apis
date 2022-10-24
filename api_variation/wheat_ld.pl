use strict;
use warnings;
use Data::Dumper;
use Bio::EnsEMBL::Registry;
use 5.14.0;

my $registry = 'Bio::EnsEMBL::Registry';

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'mysql-ens-plants-prod-1',
        -user => 'ensro',
        -port => '4243',
);

my $variation_adaptor = $registry->get_adaptor('triticum_aestivum', 'variation', 'variation');
$variation_adaptor->db->use_vcf(1);



my $sa = $registry->get_adaptor('triticum_aestivum', 'core', 'slice');
my $lda = $registry->get_adaptor('triticum_aestivum', 'variation', 'ldfeaturecontainer');
my $vfa = $registry->get_adaptor('triticum_aestivum', 'variation', 'variationfeature');
$vfa->db->use_vcf(1);

# Get a LDFeatureContainer for a region
my $slice = $sa->fetch_by_region('chromosome', '1A', 1e6, 2e6);

my $ldContainer = $lda->fetch_by_Slice($slice);

say "Name of the ldContainer is: ", $ldContainer->name();

# fetch ld featureContainer for a particular variation feature
my $vf = $vfa->fetch_by_dbID(322707);
my $ldContainer = $lda->fetch_by_VariationFeature($vf);

say "Name of the ldContainer: ", $ldContainer->name();
my $r_square_values = $ldContainer->get_all_r_square_values();
my $pops = $ldContainer->get_all_populations();

print Dumper $pops;
print Dumper $r_square_values;

