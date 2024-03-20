#!/usr/bin/awk
# Universitat Potsdam
# Date: 2024-3-11
# updated: 2024-3-20
# Author: Gaurav Sablok
# for preparing the data for the visualization of the coverage or the length of the assembled unitigs from the pacbiohifi assembly. 
#test.cov is the pacbiohifi coverage file coming from Verkko
gem install youplot
# coverage 
for i in $(ls *.cov); \ 
           do cat $i | awk '{ print $2 }'; done
# length
for i in $(ls *.cov); \
             do cat $i | awk '{ print $2 }'; done
# filtering specific to the coverage values ( storing the coverage values in a hash value and then implementing the awk over the same)
coverage="value"
for i in $(for i in $(ls *.csv); \
      do cat $i | awk '{ print $2 }'; done); \ 
                do if [[ $i -ge "${coverage}" ]]; then echo $i; fi; done
length="value"
for i in $(for i in $(ls *.csv); \
      do cat $i | awk '{ print $3 }'; done); \ 
                do if [[ $i -ge "${length}" ]]; then echo $i; fi; done
# normalizing the coverage according to the length
coveragefile="name"
for i in $(cat "${coveragefile}" | awk '{ print $2 }'); \
                do for j in $(cat "${coveragefile}" | awk '{ print $3 }'); \
                                        do echo $i"\t"$j; done | awk '{ print $1*$2 }'     
#plotting the length before filtering out the short unitigs
lengthselectionsort="variable"
for i in $(cat test.cov | awk '{ print $3 }'); \
                do if [[ $i -ge "${lengthselectionsort}" ]] then; \ 
                                        echo $i; fi; done | youplot barplot
# binning them according to the length filter and then making the sense of the assembled unitigs
 for i in $(cat test.cov | awk '{ print $3 }'); \
                do if [[ $i -ge "${lengthselectionsort}" ]] then; \ 
                                        echo $i; fi; done | youplot histogram
# genome assembled following length filter and the filtered uitigs greater than 10000
cat test.cov | awk '$3 > 10000 { print $3 }' | gawk '{ sum += $1 }; \
                      END { print sum }' && cat test.cov | \
                                            awk '$3 > 10000 { print  $1"\t"$2"\t"$3 }'
# estimating the total of the aligned length based on the computed alignments
pafalignments="aligned.paf"
cat aligned.paf | awk '{ print  $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7" \
                                    \t"$8"\t"$9"\t"$10"\t"$11"\t"$12 }' | \
                                    awk '{ print $4-$3 }' | awk '{ print $1 }' | \
                                                      gawk '{ sum += $1 }; END { print sum }'
cat aligned.paf | awk '{ print  $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7" \
                                    \t"$8"\t"$9"\t"$10"\t"$11"\t"$12 }' | \
                                    awk '{ print $9-$8 }' | awk '{ print $1 }' | \
                                                      gawk '{ sum += $1 }; END { print sum }'
# estimating the total of the aligned length based on the computed alignments
pafalignments="aligned.paf"
genomelength=""genomelength
# query aligned genome fractions  percentage as compared to the genome length of the reference genome
cat aligned.paf | awk '{ print  $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7" \
                                    \t"$8"\t"$9"\t"$10"\t"$11"\t"$12 }' | \
                                    awk '{ print $4-$3 }' | awk '{ print $1 }' | \
                                                      gawk '{ sum += $1 }; END { print sum }' | \
                                                                        awk '{ print $1/$genomelength*100 }'
# reference aligned genome fractions percentage as compared to the genome length of the reference genome
cat aligned.paf | awk '{ print  $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7" \
                                    \t"$8"\t"$9"\t"$10"\t"$11"\t"$12 }' | \
                                    awk '{ print $9-$8 }' | awk '{ print $1 }' | \
                                                      gawk '{ sum += $1 }; END { print sum }' | \
                                                                        awk '{ print $1/$genomelength*100 }'
# calculating the alignment coverage and the genome fraction aligned
cat lastzalignment.txt | awk '{ print $10 }' | cut -f 1 -d "-" > length1.txt \ 
              && cat lastzalignment.txt | awk '{ print $10 }' | cut -f 2 -d "-" > \
                                          length2.txt && paste length1.txt length2.txt \ 
                                                    | awk '{ print $2-$1 }'
# genome aligned length estimation from the lastz alignments coming from the genome aligned or the read alignment
 cat lastzalignment.txt | awk '{ print $12 }' | cut -f 1 -d "-" > length1.txt \ 
              && cat lastzalignment.txt | awk '{ print $12 }' | cut -f 2 -d "-" > \
                                          length2.txt && paste length1.txt length2.txt \ 
                                                    | awk '{ print $2-$1 }' 
# check the cordinates of the maf alignments, sample maf file is present in the repository by adding the regular pattern for the strand align 
declare -a firstcor=()
for i in $(cat test.maf | awk ' { print $2 }' | cut -f 1 -d "/" | grep "+$" | sed "s/+//g");
do 
        firstcor+=("${i}")
done
declare -a secondcor=()
for i in $(cat test.maf | awk ' { print $2 }' | cut -f 1 -d "/" | grep "+$" | sed "s/-//g")
do 
        secondcor+=("${i}")
done
for i in ${firstcor[*]}; 
do 
   grep "${i}" $1
done << $1
for i in ${secondcor[*]}; 
do 
   grep "${i}" $1
done << $1
