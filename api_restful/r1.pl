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

##Get efo data
my $server = 'http://www.ebi.ac.uk/';
for my $l (@$list){
    my $efo_id = $l->{'efo_id'};
    if ($efo_id){
        #say $efo_id;
        $ext = "/ols/api/ontologies/efo/terms?short_name=$efo_id";
        my $h = get_http_json($ext, $server);
        #print Dumper $h;
        my $link = $h->{'_links'}{'self'}{'href'};
        say $link;
    }
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
