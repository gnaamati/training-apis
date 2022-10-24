#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;


my $registry = 'Bio::EnsEMBL::Registry';
#my $reg_conf = '/homes/gnaamati/registries/prod3_gn.reg';
#my $reg_conf = '/homes/gnaamati/registries/prod3_ta_ver1.reg';
my $reg_conf = '/homes/gnaamati/registries/prod1.reg';
$registry->load_all($reg_conf);

my $ta           = $registry->get_adaptor("hordeum_vulgare", "core", "transcript");
#my $transcript   = $ta->fetch_by_stable_id('HORVU1Hr1G016910.2');
my $transcript   = $ta->fetch_by_stable_id('HORVU7Hr1G117890.1');

say $transcript->stable_id;
my $transl = $transcript->translation;
say $transl->stable_id;










#my $tgene = $gene->transform('');



