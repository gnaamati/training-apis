#Compute LD in the region 3:196064297-196068186 for the population
#1000GENOMES:phase_3:CEU
use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $ext = '/alignment/region/taeniopygia_guttata/2:106041430-106041480:1?method=LASTZ_NET;species_set=taeniopygia_guttata;species_set=gallus_gallus';
my $align = get_http_json($ext);

print Dumper $align;

#$ext = '/alignment/region/human/2:106041430-106041480:1?method=EPO';
$ext = '/alignment/region/human/2:106041430-106041480:1?method=EPO;display_species_set=human;display_species_set=chimp&display_species_set=gorilla';
$align = get_http_json($ext);
print Dumper $align;


sub get_http_json {
    my ($ext, $server) = @_;
    if (!$server){
        $server = 'https://rest.ensembl.org';
    }
    
    my $http = HTTP::Tiny->new();
    my $response = $http->get($server.$ext, {
        headers => { 'Content-type' => 'application/json' }
    });

    if (!$response->{success}){
        #return $response->{http_status};
        return $response->{content};
    }
   
    die "Failed!\n" unless $response->{success};
 
    my $list;
    if(length $response->{content}) {
        $list = decode_json($response->{content});
    }
    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;

    return $list;
}
