#Compute LD in the region 3:196064297-196068186 for the population
#1000GENOMES:phase_3:CEU
use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
#my $ext = '/genetree/id/ENSGT00390000003602';
#my $tree = get_http_json($ext);

my $ext = '/genetree/member/id/ENSG00000189221?nh_format=full';
my $ext = '/cafe/genetree/member/id/ENSG00000189221?';
my $tree = get_http_json($ext);

say $tree;

##grep protein_id for data


sub get_http_json {
    my ($ext, $server) = @_;
    if (!$server){
        $server = 'https://rest.ensembl.org';
    }

    my $url = $server.$ext;
    say $url;
    die('');
    
    my $http = HTTP::Tiny->new();
    my $response = $http->get($server.$ext, {
        #headers => { 'Content-type' => 'application/json' }
        headers => { 'Content-type' => 'text/x-nh' }
    });

    if (!$response->{success}){
        #return $response->{http_status};
        return $response->{content};
    }

    print $response->{content};
    return;
   
    die "Failed!\n" unless $response->{success};
 
    my $list;
    if(length $response->{content}) {
        $list = decode_json($response->{content});
    }
    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;

    return $list;
}
