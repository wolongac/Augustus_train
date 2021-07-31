augustus="/public-supool/software/augustus-3.2.3"
bam=$1  #sorted

$augustus/bin/bam2hints --in=$bam --out=hints.intron.gff --maxgenelen=30000 --intronsonly
/public-supool/software/augustus-3.2.3/auxprogs/bam2wig/bam2wig $bam >$bam.wig
cat $bam.wig |perl  $augustus/scripts/wig2hints.pl --width=10 --margin=10 --minthresh=2 --minscore=4 --prune=0.1 --src=W --type=ep --UCSC=unstranded.track --radius=4.5 --pri=4 --strand="." > hints.exonpart.gff

cat hints.intron.gff hints.exonpart.gff > hints.rnaseq.gff

