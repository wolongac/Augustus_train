grep -P "^\d"  test.psl |awk '{if( $1/($1+$2)>0.7  && $10 != $14){if($11>=$15){print $1"\t"$10"\t"$11"\t"$14"\t"$15}else{print $1"\t"$14"\t"$15"\t"$10"\t"$11}}}' |awk '{print $4}'|sort|uniq >del.list
