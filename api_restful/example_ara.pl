use strict;
use warnings;
 
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
my $server = 'http://rest.ensemblgenomes.org';
my $ext = '/lookup/id/AT3G52430?';
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
  print Dumper $hash;
  print "\n";
}
 
