augustus=/public-supool/software/augustus-3.2.3
#specie=$1

#perl $augustus/scripts/new_species.pl --species=$specie
etraining --species=generic --stopCodonExcludedFromCDS=false trainingSetComplete.gb 2> train.err
cat train.err | perl -ne 'print "$1\n" if /in sequence (\S+):/' > badlist
perl $augustus/scripts/filterGenes.pl badlist trainingSetComplete.gb > training.gb

