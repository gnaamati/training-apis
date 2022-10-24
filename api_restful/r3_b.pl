#Compute LD in the region 3:196064297-196068186 for the population
#1000GENOMES:phase_3:CEU
use 5.14.0;
use strict;
use warnings;

use JSON;
use Data::Dumper;
 
use HTTP::Tiny;
 
my $ext = '/eqtl/tissue/homo_sapiens?';

my $list = get_http_json($ext);
print Dumper $list;

##$ext = "/eqtl/id/homo_sapiens/ENSG00000122435?statistic=p-value;tissue=Whole_Blood;variant_name=rs2736340";

$ext='/eqtl/variant_name/homo_sapiens/rs2736340?statistic=p-value;tissue=Whole_Blood;';

$list = get_http_json($ext);
print Dumper $list;

for my $l (@$list){
    if ($l->{value} < 0.00005){
        say $l->{gene};
    }
}


sub get_http_json {
    my ($ext, $server) = @_;
    if (!$server){
        $server = 'https://rest.ensembl.org';
    }
    
    my $http = HTTP::Tiny->new();
    my $response = $http->get($server.$ext, {
        headers => { 'Content-type' => 'application/json' }
    });

    #if (!$response->{success}){
        #return $response->{http_status};
     #   return $response->{content};
    #}
   
    die "Failed!\n" unless $response->{success};
 
    my $list;
    if(length $response->{content}) {
        $list = decode_json($response->{content});
    }
    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;

    return $list;
}
