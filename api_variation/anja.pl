use strict;
use warnings;
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';

$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);

my $variation_adaptor = $registry->get_adaptor('homo_sapiens', 'variation', 'variation');

# OPTIONAL: uncomment the following line to retrieve 1000 genomes phase 3 data also
$variation_adaptor->db->use_vcf(1);

my $variation = $variation_adaptor->fetch_by_name('rs1333049');

my $genotypes = $variation->get_all_SampleGenotypes();

foreach my $genotype (@{$genotypes}) {
  print "Sample ", $genotype->sample->name, " has genotype ", $genotype->genotype_string, "\n";
}
