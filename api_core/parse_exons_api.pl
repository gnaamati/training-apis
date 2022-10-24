use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;
use lib '/nfs/production/panda/ensemblgenomes/development/gnaamati/lib';
use FileReader qw(slurp read_file file2hash file2hash_tab);
use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::Utils::Exception;

##q ==> exon
##s ==> seq_region
#my @exons = slurp($exon_file);
{
    my ($exon_file, $reg_file) = @ARGV;
    if (@ARGV < 1){
        usage();
    }
    if (!$reg_file){
        $reg_file = '/homes/gnaamati/registries/prod3_tgac.reg';
    }

    open IN, "<", $exon_file or die "can't open $exon_file\n";
    my $count = 0;

    my $slice_adaptor = get_slice_adaptor($reg_file);

    my $visited = {};
    #for my $e (@exons){
    while (my $e = <IN>){
        chomp($e);
        #my @list = split(/\t/, $e);
        #my ($exon_name,$sseqid,$pident,$length,$qstart,$qend,$sstart,$send,$evalue,$bitscore,$qlen,$btop, $strand,$nident,$mismatch,$positive,$gaps) = split(/\t/, $e);
        my ($exon_name,$sseqid,$pident,$length,$qstart,$qend,$sstart,$send,$evalue,$bitscore,$qlen,$btop,$strand,$nident,$mismatch,$positive,$gaps) = split(/\t/, $e);
        my @data = split(/\t/, $e);

        #if ($exon_name ne 'Traes_4DL_5FC277EA7.E1'){
        #if ($exon_name !~ /^Traes\_/){
        #    next;
        #}


        #say $strand;
        if ($strand eq 'plus'){
            $strand = 1;   
        }
        else{
            $strand = -1;
        }

        ##Just look at the top exon
        if ($visited->{$exon_name}){
            next;
        }
        $visited->{$exon_name}++;
        
        ##Get the coverage
        my $hcoverage = ($positive + $mismatch) / $qlen;

        #my $sql = "update dna_align_feature set hcoverage = '$hcoverage' where hit_name ='$exon_name'";
        #say $sql;
        #next;

        ##Remove EG from fasta header
        if ($sseqid =~ /^EG\:/){
            $sseqid = $';
        }

        my $slice = $slice_adaptor->fetch_by_region('toplevel',$sseqid);
        my $seq_region_id = $slice_adaptor->get_seq_region_id($slice);
        say "seq_region id = $seq_region_id\n";

        my $sql = qq{
insert into dna_align_feature (seq_region_id, seq_region_start,seq_region_end,seq_region_strand,hit_start,hit_end,hit_strand,hit_name,score,evalue,perc_ident,hcoverage,analysis_id) values($seq_region_id, $sstart, $send,$strand,$qstart, $qend,1,'$exon_name',$bitscore,$evalue, $pident, $hcoverage, 176);
        };

        say $sql;

        #if ($count++ == 1000){
        #    die;
        #}
    }
}

#======================================== 
sub get_slice_adaptor {
#======================================== 
    my ($reg_file) = @_;
    Bio::EnsEMBL::Registry->load_all($reg_file);
    my $species = 'triticum_aestivum';
    my $slice_adaptor = Bio::EnsEMBL::Registry->get_adaptor($species, 'Core', 'Slice');
    return $slice_adaptor;
}

=comment
    
    #print Dumper $slice_adaptor;

    my $slice = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_000007_1AL');
    my $srid = $slice_adaptor->get_seq_region_id($slice);

    say $srid;
    #my $id = '';

    #print Dumper $slice;

    
    #my $db_adaptor = 
    #  Bio::EnsEMBL::Registry->get_DBAdaptor('triticum_aestivum', 'core');
    #print Dumper $db_adaptor;
    #my $sr_adaptor = $db_adaptor->get_adaptor('exon');
    #print Dumper $sr_adaptor;
    die;
=cut


sub usage {
    say "Usage perl parse_exons.pl [a] [b]";
    exit 0;
}
 
