use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
my $server = 'https://rest.ensembl.org';
my $ext = '/overlap/id/ENSG00000157764?feature=variation;content-type=application/json';

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

print Dumper $list;

