#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;
use Data::Dumper;


my $registry = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/prod1.reg';
$registry->load_all($reg_conf);

say "getting slice\n";

##fetch a gene by its stable identifier
my $gene_adaptor = $registry->get_adaptor("triticum_aestivum", "core", "gene");
my $gene          = $gene_adaptor->fetch_by_stable_id('TRIAE_CS42_U_TGACv1_641895_AA2106830');

my @db_links = @{$gene->get_all_DBLinks(undef, 'ENSEMBL')};
say scalar @db_links;
for my $db_link (@db_links){
    print Dumper $db_link;
}

__END__


say $gene->stable_id;
my $trans_array_ref = $gene->get_all_Transcripts;
for my $trans (@$trans_array_ref){
    say $trans->stable_id;
    my @db_links = @{$trans->get_all_DBLinks(undef, 'ENSEMBL')};
    say scalar @db_links;
}











#my $tgene = $gene->transform('');



