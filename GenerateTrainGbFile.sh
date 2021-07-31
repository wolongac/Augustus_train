augustus=/public-supool/software/augustus-3.2.3
gff=$1
genome=$2
my_species=$3
perl $augustus/scripts/new_species.pl --species=$my_species
perl $augustus/scripts/gff2gbSmallDNA.pl $gff $genome 50 trainingSetComplete.gb
$augustus/bin/etraining --species=$my_species --stopCodonExcludedFromCDS=false trainingSetComplete.gb 2> train.err
cat train.err | perl -ne 'print "$1\n" if /in sequence (\S+):/' > badlist
perl $augustus/scripts/filterGenes.pl badlist trainingSetComplete.gb > training.gb
