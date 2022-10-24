use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
my $server = 'https://rest.ensembl.org';
my $ext = '/vep/human/id/rs189863975?';


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

my $hash = $list->[0];
print Dumper $hash;

my $transcripts = $hash->{'transcript_consequences'};
for my $t (@$transcripts){
    print Dumper $t;
    say $t->{transcript_id};
}

