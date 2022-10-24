#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

my $va = $registry->get_adaptor('human','variation', 'variation');

my $name = 'rs6495122';
my $v = $va->fetch_by_name($name);

my $phenotypes = $v->get_all_PhenotypeFeatures();

for my $p (@$phenotypes){
    say $p->phenotype->description();
    say $p->p_value();
    say $p->source_name();
    say $p->risk_allele;

    #say $gn->sample->individual->name;
    #say $gn->sample->individual->gender;
}

say "\n\n\n";
say $v->minor_allele;
say $v->ancestral_allele;
say $v->minor_allele_frequency;





