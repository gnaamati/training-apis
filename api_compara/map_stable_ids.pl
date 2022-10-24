use 5.14.0;
use warnings;
use Data::Dumper;
use lib '/nfs/production/panda/ensemblgenomes/development/gnaamati/lib';
use FileReader qw(slurp slurp_hash_list read_file file2hash file2hash_tab line2hash);

#TRIAE_CS42_5DL_TGACv1_434345_AA1434320.1        TraesCS5D01G429400.1

{
    my ($a) = @ARGV;
    if (@ARGV < 1){
        usage();
    }
    my @lines = slurp($a);
    for my $line (@lines){
        my ($old, $new) = split(/\t/, $line);
        if ($old =~ /\.\d/){
            $old = $`;
        }
        if ($new =~ /\.\d/){
            $new = $`;
        }
        my $sql = "insert into stable_id_event (old_stable_id, old_version, new_stable_id, new_version, mapping_session_id,type,score)".
                  " values ('$old',1,'$new',1,1,'gene',1);";
        say $sql;
    }
}

sub usage {
    say "Usage perl map_stable_ids.pl [a] [b]";
    exit 0;
}
 
