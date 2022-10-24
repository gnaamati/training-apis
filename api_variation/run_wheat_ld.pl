use strict;
use warnings;
use Data::Dumper;
use Bio::EnsEMBL::Registry;
use 5.14.0;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'mysql-ens-plants-prod-1',
        -user => 'ensro',
        -port => '4243',
        -db_version => 99,
);

my $variation_adaptor = $registry->get_adaptor('triticum_aestivum', 'variation', 'variation');
my $population_adaptor =  $registry->get_adaptor('triticum_aestivum', 'variation', 'population');

my $population =  $population_adaptor->fetch_by_name('Axiom');

$variation_adaptor->db->use_vcf(1);



my $sa = $registry->get_adaptor('triticum_aestivum', 'core', 'slice');
my $lda = $registry->get_adaptor('triticum_aestivum', 'variation', 'ldfeaturecontainer');
my $vfa = $registry->get_adaptor('triticum_aestivum', 'variation', 'variationfeature');
$vfa->db->use_vcf(1);
# Get a LDFeatureContainer for a region

my $slice = $sa->fetch_by_region('chromosome', '5A', 1, 500_000_000);
#my $slice = $sa->fetch_by_region('chromosome', '4A', $start, $end);
my $ldContainer = $lda->fetch_by_Slice($slice, $population);
my @ld_values = @{$ldContainer->get_all_ld_values()};
foreach my $hash (@ld_values) {
    my $vf1 = $hash->{'variation1'};
    my $vf2 = $hash->{'variation2'};
    my $r2 = $hash->{r2};
    my $d_prime = $hash->{d_prime};

    print join(', ', $variation1,$variation2, $r2, $d_prime), "\n";
}
