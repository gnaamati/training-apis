#Compute LD in the region 3:196064297-196068186 for the population
#1000GENOMES:phase_3:CEU
use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $ext = '/regulatory/species/homo_sapiens/epigenome?';

my $list = get_http_json($ext);
#print Dumper $list;

##get espn gene
$ext = '/xrefs/symbol/homo_sapiens/ESPN';
my $h = get_http_json($ext);
print Dumper $h;
my $id = $h->[0]->{id};
say $id;
$ext = "/lookup/id/$id";

##Get Ensembl gene
$ext = "/lookup/id/$id";
my $gene = get_http_json($ext);
print Dumper $gene;

# 2.3 Get region 1000bp upstream  
my $chro  = $gene->{'seq_region_name'};
my $start = $gene->{'start'};
$start    = $start-1000;
my $end   = $gene->{'start'};
say "$chro\t$start\t$end\t";

# 2.4 Find Regulatory Features in this area
$ext = "/overlap/region/human/$chro:$start-$end?feature=regulatory";
my $region = get_http_json($ext);
$start = $region->[0]->{start};
$end   = $region->[0]->{end};

say "reg $start-$end";

# 2.5 Get Motif features
$ext = "/overlap/region/human/$chro:$start-$end?feature=motif";
my $motifs = get_http_json($ext);

say ">>>>>Variations\n\n\n";

for my $m (@$motifs){
    $start = $m->{start};
    $end   = $m->{end};
    $ext = "/overlap/region/human/$chro:$start-$end?feature=variation";
    my $vars = get_http_json($ext);
    print Dumper $vars;
}
    

sub get_http_json {
    my ($ext, $server) = @_;
    if (!$server){
        $server = 'https://rest.ensembl.org';
    }
    
    my $http = HTTP::Tiny->new();
    my $response = $http->get($server.$ext, {
        headers => { 'Content-type' => 'application/json' }
    });

    #if (!$response->{success}){
        #return $response->{http_status};
     #   return $response->{content};
    #}
   
    die "Failed!\n" unless $response->{success};
 
    my $list;
    if(length $response->{content}) {
        $list = decode_json($response->{content});
    }
    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;

    return $list;
}
