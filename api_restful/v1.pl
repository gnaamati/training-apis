use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
my $server = 'https://rest.ensembl.org';
my $ext = '/overlap/region/human/17:80348215-80348333?feature=variation;content-type=application/json';


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

for my $hash (@$list){
    my $id =  $hash->{id};
    #say $hash->{consequence_type};
    my $var_ext = "/variation/human/$id";
    $response = $http->get($server.$var_ext, {
        headers => { 'Content-type' => 'application/json' }
    });
    if(length $response->{content}) {
      my $var_hash = decode_json($response->{content});
      print Dumper $var_hash;
    } 
}

