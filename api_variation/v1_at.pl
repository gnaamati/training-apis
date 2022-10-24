#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;
use production::Tools::FileReader qw(slurp slurp_hash_list read_file file2hash file2hash_tab line2hash);

my ($a) = @ARGV;
my @lines = slurp($a);


my $registry = 'Bio::EnsEMBL::Registry';

my $reg_conf = '/homes/gnaamati/registries/plants1.reg';
$registry->load_all($reg_conf);

my $va = $registry->get_adaptor('triticum_aestivum','variation', 'variation');

my @names = qw/ENSVATH00000001 ENSVATH00000002 ENSVATH00000003/;
my @names = qw/BA00222391/;

for my $name (@names){
	my $variation = $va->fetch_by_name($name);
	my $source = $variation->source_name();
	my $class = $variation->var_class();
	#say "$name\t$class\t$source";;

        my $var_features = $variation->get_all_VariationFeatures;

        for my $vf (@$var_features){
            say $vf->name;
            say $vf->seq_region_name;
            say $vf->allele_string;
            say $vf->seq_region_start(), "-", $vf->seq_region_end();
            say;
        }


        #print $vf->start(), "-", $vf->end(), '(', $vf->strand(), ')', "\n";

}




=comment
my $gene_adaptor = $registry->get_adaptor('Human','Core','Gene');


my $adaptors = $registry->get_all_DBAdaptors;

for my $a (@$adaptors){
	my $dbc = $a->dbc;
	say $dbc->dbname;
}

=cut


#print  Dumper $adaptors;

