#Compute LD in the region 3:196064297-196068186 for the population
#1000GENOMES:phase_3:CEU
use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
my $server = 'https://rest.ensembl.org';
my $ext = '/ld/human/region/3:196064297-196068186/1000GENOMES:phase_3:CEU?';


my $response = $http->get($server.$ext, {
  headers => { 'Content-type' => 'application/json' }
});
   
die "Failed!\n" unless $response->{success};
 
my $list;
if(length $response->{content}) {
  $list = decode_json($response->{content});
}
local $Data::Dumper::Terse = 1;
local $Data::Dumper::Indent = 1;

#print Dumper $list;

for my $l (@$list){
    if (($l->{r2} == 1) and ($l->{d_prime} == 1)){
        print Dumper $l;
    }
}


