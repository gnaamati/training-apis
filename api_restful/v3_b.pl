use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
my $server = 'https://rest.ensembl.org';
my $ext = '/vep/human/id';
my $response = $http->request('POST', $server.$ext, {
  headers => { 
    'Content-type' => 'application/json',
    'Accept' => 'application/json'
  },
  content => '{ "ids" : ["rs56116432", "COSM476" ] }'
});

die "Failed!\n" unless $response->{success};

my $list;
if(length $response->{content}) {
  $list = decode_json($response->{content});
}
local $Data::Dumper::Terse = 1;
local $Data::Dumper::Indent = 1;

print Dumper $list;


 
die "Failed!\n" unless $response->{success};
