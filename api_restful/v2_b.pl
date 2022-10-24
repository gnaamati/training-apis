use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
my $server = 'https://rest.ensembl.org';
my $ext = '/phenotype/term/homo_sapiens/coffee%20consumption?';


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

my $min_p_val = 1;
my $min_phen;

for my $l (@$list){
    my $id = $l->{Variation};
    $ext = "/variation/human/$id?";

    my $response = $http->get($server.$ext, {
      headers => { 'Content-type' => 'application/json' }
      });

    die "Failed!\n" unless $response->{success};
    if(length $response->{content}) {
      my $hash = decode_json($response->{content});
      print Dumper $hash;
    }

}

