use 5.14.0;
use strict;
use warnings;
 
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
my $server = 'https://rest.ensembl.org';
my $ext = '/lookup/symbol/homo_sapiens/IRAK4?expand=1';


my $response = $http->get($server.$ext, {
  headers => { 'Content-type' => 'application/json' }
});
   
 
die "Failed!\n" unless $response->{success};
 
 
use JSON;
use Data::Dumper;
if(length $response->{content}) {
  my $hash = decode_json($response->{content});
  local $Data::Dumper::Terse = 1;
  local $Data::Dumper::Indent = 1;
  #print Dumper $hash;
  #print "\n";
  print $hash->{id};
  say "hey hey hey";
}
my $id = 'ENSG00000198001';
$ext = "/sequence/id/$id";


my $response = $http->get($server.$ext, {
  headers => { 'Content-type' => 'text/x-fasta' }
});


die "Failed!\n" unless $response->{success};

say $response;
say $response->{content};


 





