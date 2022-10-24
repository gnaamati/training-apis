use strict;
use warnings;
use Data::Dumper;
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'mysql-ens-plants-prod-1',
        -user => 'ensro',
        -port => '4243',
);


my $variation_adaptor = $registry->get_adaptor('triticum_aestivum', 'variation', 'variation');

# OPTIONAL: uncomment the following line to retrieve 1000 genomes phase 3 data also
$variation_adaptor->db->use_vcf(1);

#my $variation = $variation_adaptor->fetch_by_name('BA00222391');
#my $variation = $variation_adaptor->fetch_by_name('BA00232763');
#my $variation = $variation_adaptor->fetch_by_name('BA00000251');
my $variation = $variation_adaptor->fetch_by_name('BA00173112');

my $genotypes = $variation->get_all_SampleGenotypes();

foreach my $genotype (@{$genotypes}) {
  print "Sample ", $genotype->sample->name, " has genotype ", $genotype->genotype_string, "\n";
}
