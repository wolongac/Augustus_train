#!/usr/bin/perl -w
use strict;

my $gb=shift;

open(IN,"$gb");

my $gid;
my $locus;
my %hash;
while(<IN>){
	chomp;
	if($_ =~ /LOCUS/){
		my @line = split /\s+/,$_;
		$locus = $line[1];
		while (<IN>){
			chomp;
			if($_ =~ /\/gene=/){
				($gid) = $_ =~ /gene="(.*?)"/;
				my $tid = $gid;
				$gid =~ s/\.T\d\d//g;
				$hash{$gid}{$tid}{"locus"}=$locus;
				my ($start,$end) = $locus =~ /_(\d+)-(\d+)/;
				my $length = abs ($start - $end);
				$hash{$gid}{$tid}{"length"} = $length;
				last;
			}
		}
	}
}

close IN;

my $flag=0;
foreach my $gid (keys %hash){
	$flag=0;
	foreach my $tid ( sort {$hash{$gid}{$b}{"length"} <=> $hash{$gid}{$a}{"length"}}  keys %{$hash{$gid}}){
		if($flag==0){
			$flag=1;
		}else{
			print "$hash{$gid}{$tid}{'locus'}\n";
		}
	}
}

