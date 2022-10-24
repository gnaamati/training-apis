#!/usr/bin/env pere
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';

my $reg_conf = '/homes/gnaamati/registries/prod3_tgac_var.reg';
$registry->load_all($reg_conf);

#$registry->load_registry_from_db(
#	-host => 'ensembldb.ensembl.org',
#	-user => 'anonymous',
#	#-verbose=> 1
#)e

my $va = $registry->get_adaptor('triticum_aestivum','variation', 'variation');

$va->db->use_vcf(1);
my $name = 'BA00513909.1';
my $v = $va->fetch_by_name($name);

my $genotypes = $v->get_all_SampleGenotypes();

for my $gn (@$genotypes){
    say $gn->genotype_string;
    say $gn->sample->individual->name;
    say $gn->sample->individual->gender;
}

die;


my $alleles = $v->get_all_Alleles();

for my $al (@$alleles){
        say $al->allele;
        if ($al->frequency){
                say $al->frequency;
        }
        if ($al->population){
                say $al->population->name;
        }
        say $al->subsnp_handle;
}


=comment
my @names = qw/BA00513909.1 BA00020546/;

for my $name (@names){
	my $variation = $va->fetch_by_name($name);
	my $source = $variation->source_name();
	my $class = $variation->var_class();
	say "$name\t$class\t$source";;
}
=cut




=comment
my $gene_adaptor = $registry->get_adaptor('Human','Core','Gene');


my $adaptors = $registry->get_all_DBAdaptors;

for my $a (@$adaptors){
	my $dbc = $a->dbc;
	say $dbc->dbname;
}

=cut


#print  Dumper $adaptors;

