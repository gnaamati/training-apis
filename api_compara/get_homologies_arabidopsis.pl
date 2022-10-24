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
$reg->load_all($reg_conf);

## Get the adaptors
my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");
my $homology_adaptor    = $reg->get_adaptor("Multi", "compara", "Homology");
my $align_mem_adaptor   = $reg->get_adaptor("Multi", "compara", "AlignedMember");

my $count = 0;
say "gene1\tgene2\tdn\tds\ttaxonomy_level\tdescription";
my $gene_id =   'AT1G01040';
#my $gene_id =   'AT3G11415';

## Get the compara member
my $gene_member = $gene_member_adaptor->fetch_by_stable_id($gene_id);


## Get all the homologs in the other species
my $all_homologies;
eval { $all_homologies = $homology_adaptor->fetch_all_by_Member($gene_member, -TARGET_SPECIES => $org2); };
next if $@;

## For each homology get relavant info
foreach my $this_homology (@{$all_homologies}) {

    #my $gene_members = $this_homology->get_all_GeneMembers();
    my $gene_members = $this_homology->get_all_Members();
    foreach my $this_member (@{$gene_members}) {
        print $this_member->genome_db_id,"\t";
        print $this_member->perc_id,"<==\n";
    }

    print $this_homology->dn,"\t";
    print $this_homology->ds,"\t";
    print $this_homology->taxonomy_level,"\t";
    print $this_homology->description,"\n";
    print $this_homology->toString,"\n";

    #my $aligned_member = $align_mem_adaptor->fetch_all_by_Homology($this_homology);
    #print Dumper $aligned_member;

}
