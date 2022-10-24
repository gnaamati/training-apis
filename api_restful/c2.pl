use 5.14.0;
use strict;
use warnings;
 
use HTTP::Tiny;
 
my $http = HTTP::Tiny->new();
 
#my $server = 'https://rest.ensembl.org';
#my $ext = '/lookup/symbol/homo_sapiens/IRAK4?expand=1';
my $server='http://rest.ensemblgenomes.org';
#my $ext='lookup/id/AT3G52430?content-type=application/json;expand=1';
my $ext='lookup/id/AT3G52430?content-type=application/json;expand=1';

warn $server.$ext;


my $response = $http->get($server.$ext, {
  headers => { 'Content-type' => 'application/json' }
});
   
 
die "Failed!\n" unless $response->{success};
use JSON;
use Data::Dumper;
my $hash;
if(length $response->{content}) {
  $hash = decode_json($response->{content});
  local $Data::Dumper::Terse = 1;
  local $Data::Dumper::Indent = 1;
}

#print Dumper $hash;
print "\n";
my $transcripts = $hash->{'Transcript'};
my @transcripts;
#print Dumper $transcripts;
for my $t (@$transcripts) {
    say $t->{id};
    push @transcripts, $t->{id};
}
 
# Create the data body to be sent to the server
my $data = encode_json( { ids => \@transcripts } );

my $sequence_endpoint = "/sequence/id";

my $sequences = fetch_endpoint_POST($server.$sequence_endpoint,
                    $data,
                    'text/x-fasta');

# Print the results we received
print "$sequences";


sub fetch_endpoint_POST {
    my ($request, $data, $content_type) = @_;
    $content_type ||= 'application/json';

    my $response = $http->request('POST', $request,
                                  { headers => { 'Content-type' => $content_type },
                                    content => $data } );

    die "Failed!\n" unless $response->{success};

    if($content_type eq 'application/json') {
    return decode_json($response->{content});
    } else {
    return $response->{content};
    }
}


