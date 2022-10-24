#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use feature qw /say/;

my $reg = 'Bio::EnsEMBL::Registry';
$reg->load_registry_from_db(
	-host => 'ensembldb.ensembl.org',
	-user => 'anonymous',
	#-verbose=> 1
);

my $sva = $reg->get_adaptor("human","variation","structuralvariation");
    
my $sv = $sva->fetch_by_name('esv275264');

#say $sv->variation_name(), ":", $sv->var_class();
#say $sv->study->name();

my $svfs = $sv->get_all_StructuralVariationFeatures();
for my $vf (@$svfs){
    #say $vf->seq_region_name;
    #say $vf->seq_region_start(), "-", $vf->seq_region_end();
    #say $vf->inner_start(), "-", $vf->inner_end();
}

my $ssv =  $sv->get_all_SupportingStructuralVariants();

for my $s (@$ssv){
    say $s->display_id();
    say $s->var_class();
}












