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

my $seq_member_adaptor = $registry->get_adaptor("Multi", "compara", "SeqMember");
my $seq_mem =
 $seq_member_adaptor->fetch_by_stable_id('O93279');

say $seq_mem->source_name(); 
say $seq_mem->sequence();

my $hg_adaptor = $registry->get_adaptor("human", "core", "Gene");
my $genes = $hg_adaptor->fetch_all_by_external_name('FRAS1');
for my $gene (@$genes){
    my $sid =  $gene->stable_id();
    say $sid;
    my $seq_mem =
        $seq_member_adaptor->fetch_by_stable_id($sid);
    print Dumper $seq_mem;
    say $seq_mem->sequence();

}


#my $sid = $gene->stable_id();
#say $sid;

#my $seq_member_adaptor = $registry->get_adaptor("Multi", "compara", "SeqMember");
