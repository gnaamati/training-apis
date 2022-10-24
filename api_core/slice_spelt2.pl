#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;
use Bio::EnsEMBL::Utils::IO::FASTASerializer;


my $registry = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/plants1.reg';
$registry->load_all($reg_conf);

say "getting slice\n";

##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("triticum_spelta", "core", "slice");
my $slice         = $slice_adaptor->fetch_by_region('toplevel','7D');

my $genome_file = '/nfs/nobackup/ensemblgenomes/gnaamati/repeats/arabidopsis_spelt/triticum_spelta/test.fa';
open(my $fh, '>', $genome_file) or die("Cannot open file $genome_file: $!");

my $header_function =
      sub {
        my $slice = shift;
        return $slice->seq_region_name;
      };

my $serializer = Bio::EnsEMBL::Utils::IO::FASTASerializer->new(
    $fh,
    $header_function,
    1000,
    80,
);

$serializer->print_Seq($slice);

