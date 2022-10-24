#Compute LD in the region 3:196064297-196068186 for the population
#1000GENOMES:phase_3:CEU
use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $ext = '/family/id/PTHR10740_SF4';
my $family = get_http_json($ext);

$ext = "/family/id/PTHR10740_SF4?aligned=1;sequence=cdna;member_source=ensembl";
$family = get_http_json($ext);

$ext = "/family/member/id/ENSG00000283087/";
$family = get_http_json($ext);
#print Dumper $family;


$ext = "/family/member/symbol/human/HOXD4-201?aligned=0;sequence=none;member_source=ensembl";

$family = get_http_json($ext);
print Dumper $family;

##grep protein_id for data


sub get_http_json {
    my ($ext, $server) = @_;
    if (!$server){
        $server = 'https://rest.ensembl.org';
    }
    
    my $http = HTTP::Tiny->new();
    my $response = $http->get($server.$ext, {
        headers => { 'Content-type' => 'application/json' }
    });

    if (!$response->{success}){
        #return $response->{http_status};
        return $response->{content};
    }
   
    die "Failed!\n" unless $response->{success};
 
    my $list;
    if(length $response->{content}) {
        $list = decode_json($response->{content});
    }
    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;

    return $list;
}
