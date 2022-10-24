use 5.14.0;
use warnings;
use Data::Dumper;
use lib '/nfs/production/panda/ensemblgenomes/development/gnaamati/lib';
use FileReader qw(slurp read_file file2hash file2hash_tab line2hash get_gene_adaptor);

{
    my $reg_conf = '/homes/gnaamati/registries/prod1.reg';
    my $gene_adaptor = get_gene_adaptor($reg_conf, 'triticum_aestivum');

    my $gene = $gene_adaptor->fetch_by_stable_id('TRIAE_CS42_U_TGACv1_641895_AA2106830');
    say $gene->dbID;


}

