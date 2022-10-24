#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;
use production::Tools::FileReader qw(slurp slurp_hash_list read_file file2hash file2hash_tab line2hash);

my $registry = 'Bio::EnsEMBL::Registry';

my $reg_conf = '/homes/gnaamati/registries/plants1.reg';
$registry->load_all($reg_conf);

my $va = $registry->get_adaptor('triticum_aestivum','variation', 'variation');

##Get all the LD pairs
my ($a) = @ARGV;
my @lines = slurp($a);

for my $line (@lines){
    say $line;
    my ($var1, $var2) = split (/, /, $line);
    my $var_obj1 = $va->fetch_by_name($var1);
    my $var_obj2 = $va->fetch_by_name($var2);
    my $var_features1 = $var_obj1->get_all_VariationFeatures;
    my $var_features2 = $var_obj2->get_all_VariationFeatures;
    for my $vf (@$var_features1){
        print $vf->name,":",$vf->seq_region_name,":",$vf->allele_string,":";
        say $vf->seq_region_start(), "-", $vf->seq_region_end();
    }
    for my $vf (@$var_features2){
        print $vf->name,":",$vf->seq_region_name,":",$vf->allele_string,":";
        say $vf->seq_region_start(), "-", $vf->seq_region_end();
    }
    say "  ";

}

