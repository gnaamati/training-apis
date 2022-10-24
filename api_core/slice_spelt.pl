#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Bio::SeqIO;
use feature qw /say/;
use Bio::EnsEMBL::Utils::IO::FASTASerializer;


my $registry = 'Bio::EnsEMBL::Registry';
#my $reg_conf = '/homes/gnaamati/registries/prod3_gn.reg';
#my $reg_conf = '/homes/gnaamati/registries/prod3_ta_ver1.reg';
#my $reg_conf = '/homes/gnaamati/registries/prod1.reg';
my $reg_conf = '/homes/gnaamati/registries/plants1.reg';
$registry->load_all($reg_conf);

say "getting slice\n";

##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("triticum_aestivum", "core", "slice");
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_1AL_scaff_3976225');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_1AL_scaff_3877574');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','IWGSC_CSS_1AL_scaff_3966124');
my $slice         = $slice_adaptor->fetch_by_region('toplevel','7D');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_000001_1AL');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_000001_1AL');
#my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_000001_1AL');
#my $slices        = $slice_adaptor->fetch_all();
#print Dumper $slices->[1];
#
#

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



#my $seq = $slice->seq;
#say $seq;
__END__

#


#my  @slices = @{$slice_adaptor->fetch_all_by_dbID_list([3144729])};
#my  @slices = @{$slice_adaptor->fetch_all_by_dbID_list([1])};
#print Dumper \@slices;

#134089, 134533, 1, 445,-1

my $slice_end     = $slice->end();
#say $slice->seq;

#my $sub_slice = $slice->sub_Slice(1,941);
#my $sub_slice = $slice->sub_Slice(866,1761);
#my $sub_slice = $slice->sub_Slice(1,788);
#my $sub_slice = $slice->sub_Slice(1315,1938);
#my $start    = 274374681;

my $start    = 261276540;
my $end      = 261277144;
#my $end  =  274374681;

say "$start, $end";
my $sub_slice1 = $slice->sub_Slice($start,$end,1);
#my $sub_slice1 = $slice->sub_Slice($end,$start,-1);
my $seq1 = $sub_slice1->seq;

say "================seq1==========================";
say $seq1;
say "=============================================\n";

__END__

#========================================= 
my $reg_conf = '/homes/gnaamati/registries/prod1.reg';
$registry->load_all($reg_conf);


##fetch a gene by its stable identifier
my $slice_adaptor = $registry->get_adaptor("triticum_aestivum", "core", "slice");
#my $slice        = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_000001_1AL');
#my $slice        = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_130745_2BL');
my $slice         = $slice_adaptor->fetch_by_region('toplevel','TGACv1_scaffold_000105_1AL');

#my $sub_slice = $slice->sub_Slice(204615,205555,-1);
#my $sub_slice = $slice->sub_Slice(202633,203528,-1);
#my $sub_slice = $slice->sub_Slice(134089,134533,-1);
#my $sub_slice = $slice->sub_Slice(76212,76835,-1);
#my $sub_slice = $slice->sub_Slice(17932,17932, 1);
#my $sub_slice = $slice->sub_Slice(17927,17932,1);
#my $sub_slice = $slice->sub_Slice(17927,17932,-1);
#my $sub_slice = $slice->sub_Slice(74879, 78149,-1);

#say "==========================================";
#
#
my $start = 57857 ;
my $end  =  $start + 464;
my $sub_slice2 = $slice->sub_Slice($start,$end,1);
my $seq2 = $sub_slice2->seq;
say "================seq2==========================";
say $seq2;
say "================seq2==========================";

if ($seq1 eq $seq2){
    say "the are the same!!";
}
else{
    say "they are different!!";
}



#my $tgene = $gene->transform('');



