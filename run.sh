gb_file=$1
genome=$2
specie_name=$3
augustus="/public-supool/software/augustus-3.2.3"

perl $augustus/scripts/randomSplit.pl $gb_file 20   # *.gb.train   *.gb.test
perl $augustus/scripts/optimize_augustus.pl --species=$specie_name --rounds=5 --cpus=12 --kfold=10 $gb_file\.test --onlytrain=$gb_file\.train --metapars=$augustus/config/species/$specie_name/$specie_name\_metapars.cfg > optimize.out

#without CRF:
$augustus/bin/etraining --species=$specie_name  $gb_file.train   #training
$augustus/bin/augustus --species=$specie_name $gb_file.test > test.2.withoutCRF.out     #evaluate accuracy
#mkdir CRF
#cp $augustus/config/species/$specie_name/*.pbl ./CRF

#with CRF:
#$augustus/bin/etraining --species=$specie_name --CRF=1  $gb_file.train 1>train.CRF.out 2>train.CRF.err  #training
#$augustus/bin/augustus --species=$specie_name $gb_file.test > test.2.CRF.out     #evaluate accuracy

