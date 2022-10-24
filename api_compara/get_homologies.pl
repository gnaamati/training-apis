##Get homology for 2 organisms
use 5.14.0;
use strict;
#use warnings;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::EnsEMBL::Registry;
use Data::Dumper;

#my ($org1, $org2) = @ARGV;
my ($org1, $org2) = ('arabidopsis_thaliana', 'arabidopsis_lyrata');

## Load the registry automatically
my $reg = 'Bio::EnsEMBL::Registry';
my $reg_conf = '/homes/gnaamati/registries/prod1-compara-staging.reg';
#my $reg_conf = '/homes/gnaamati/registries/compara_test_iwgsc.reg';
#my $reg_conf = '/homes/gnaamati/registries/prod1-compara-staging.reg';
$reg->load_all($reg_conf);
my $wheat_hash;
my $barley_hash;

my @genes = get_genes($reg, $org1);

## Get the compara member adaptor
my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");
my $align_mem_adaptor   = $reg->get_adaptor("Multi", "compara", "AlignedMember");

## Get the compara homology adaptor
my $homology_adaptor = $reg->get_adaptor("Multi", "compara", "Homology");
my $count = 0;
say "gene1\tgene2\tdn\tds\ttaxonomy_level\tdescription";
for my $gene_id (@genes) {

    ## Get the compara member
    my $gene_member = $gene_member_adaptor->fetch_by_stable_id($gene_id);

    ## Get all the homologs in the other species
    my $all_homologies;
    #my $all_homologies = $homology_adaptor->fetch_all_by_Member($gene_member);
    #eval { $all_homologies = $homology_adaptor->fetch_all_by_Member($gene_member); };
    eval { $all_homologies = $homology_adaptor->fetch_all_by_Member($gene_member, -TARGET_SPECIES => $org2); };
    #next if $@;
    #
    ## For each homology get relavant info
    foreach my $this_homology (@{$all_homologies}) {
        my $gene_members = $this_homology->get_all_GeneMembers();
        foreach my $this_member (@{$gene_members}) {
            my $sid = $this_member->stable_id;
            print $this_member->stable_id(),"\t";
        }



        #my ($sid1, $sid2) = ($gene_members->[0]->stable_id, $gene_members->[1]->stable_id);
        
        #say "$sid1, $sid2\n";
        #if ($sid1 =~ /^Traes/){
            #$wheat_hash->{$sid1}++;
            #$barley_hash->{$sid2}++;
        #}
        #elsif ($sid2 =~ /^Traes/){
            #$wheat_hash->{$sid2}++;
            #$barley_hash->{$sid1}++;
        #}

        #foreach my $this_member (@{$gene_members}) {
            #my $sid = $this_member->stable_id;
            #if ($sid =~ /^Traes/){
                #$wheat_hash->{$sid}++;
                #print "$sid\n";
            #}
            #if ($sid =~ /^HOR/){
                #$barley_hash->{$sid}++;
                #print "$sid\n";
            #}
        
            #print $this_member->stable_id(),"\t";
        #}

        print $this_homology->dn,"\t";
        print $this_homology->ds,"\t";
        print $this_homology->taxonomy_level,"\t";
        print $this_homology->description,"\n";
        #my $aligned_member = $align_mem_adaptor->fetch_all_by_Homology($this_homology);
        #print Dumper $aligned_member;

    }
    $count++;
    if ($count % 1000 == 0){
        warn "$count\n";
        #die('');
    }
}

#print Dumper $wheat_hash;
print Dumper $barley_hash;

#======================================== 
sub get_genes {
    my ($registry, $org) = @_;

    my $gene_adaptor = $registry->get_adaptor("$org", "core", "Gene");

    my $genes_aref = $gene_adaptor->fetch_all_by_biotype('protein_coding');
    #my $genes_aref = $gene_adaptor->fetch_all;
    
    my $count = 0;
    my @genes_output = ();
    for my $gene ( @{$genes_aref} ){
        push @genes_output, $gene->stable_id;
        #if ($count++ == 100){
        #    last;
        #}
    }
    #print Dumper \@genes_output;
    #die('');
    return @genes_output;
}





__END__

#======================================== 
sub get_genes {
    my ($registry, $org) = @_;

    my $gene_adaptor = $registry->get_adaptor("$org", "core", "Gene");

    #my $genes_aref = $gene_adaptor->fetch_all_by_biotype('protein_coding');
    my $genes_aref = $gene_adaptor->fetch_all;
    my @genes = ();
    for my $gene ( @{$genes_aref} ){
        my $biotype = $gene->biotype;
        if (($biotype eq 'protein_coding') or ($biotype =~ /pseudogene/)){
            my $sid = $gene->stable_id;
            push @genes, $sid;
        }
    }
    return @genes;
}

