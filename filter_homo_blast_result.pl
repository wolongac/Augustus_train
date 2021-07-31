#########################################################################
#      File Name: filter_homo_blast_result.pl
#    > Author: hwlu
#    > Mail: hongweilu@genetics.ac.cn 
#    Created Time: Sun 25 Nov 2018 05:29:10 PM CST
#########################################################################

#!/usr/bin/perl -w
use strict;

my $blast =shift; #outfmt = 6

my %hash;
open(IN,$blast);
while(<IN>){
    chomp;
    my @line = split /\s+/,$_;
    next if ($line[2] < 60);
    next if ($line[0] eq $line[1]);
    $line[1] =~s/_.*//g;
    next if ($line[0] eq $line[1]);
    $hash{$line[0]}{$line[1]}="-";
    $hash{$line[1]}{$line[0]}="-";
}
close IN;

my %hash_keep;
my %hash_del;
foreach my $gid (keys %hash){
    next if (exists $hash_keep{$gid});
    next if (exists $hash_del{$gid});
    $hash_keep{$gid}="-";
    foreach my $gid2 (keys %{$hash{$gid}}){
	$hash_del{$gid2};
    }
}

open(OUT,">keep.genes");
foreach my $out (keys  %hash_keep ){
    print OUT  "$out\n";
}
close OUT;
