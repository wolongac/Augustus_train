#########################################################################
#      File Name: filter_homo_psl_result.pl
#    > Author: hwlu
#    > Mail: hongweilu@genetics.ac.cn 
#    Created Time: Sun 25 Nov 2018 05:29:10 PM CST
#########################################################################

#!/usr/bin/perl -w
use strict;

my $psl =shift; 

my %hash;
open(IN,$psl);
while(<IN>){
    chomp;
    my @line = split /\s+/,$_;
    next if ($line[0] !~ /^\d/);
    next if ($line[9] eq $line[13]);
    next if ($line[0] != $line[10] || $line[0] != $line[14]);
    next if ($line[0]/$line[10] < 0.3 || $line[0]/$line[14] < 0.3);
    next if ($line[0]/($line[1]+$line[0]) < 0.7);
    $hash{$line[9]}{$line[13]}=1;
    $hash{$line[13]}{$line[9]}=1;
}
close IN;

my %hash_keep;
my %hash_del;
foreach my $gid (keys %hash){
    next if (exists $hash_keep{$gid});
    next if (exists $hash_del{$gid});
    $hash_keep{$gid}=1;
    foreach my $gid2 (keys %{$hash{$gid}}){
	$hash_del{$gid2}=1;
    }
}

open(OUT,">keep.genes");
foreach my $out (keys  %hash_keep ){
    print OUT  "$out\n";
}
close OUT;
