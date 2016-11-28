#!/bin/bash

function gettime {

    printf "begin\tend\telapsed\tdelta\tduration\trealtime\n" 
    for x in ${1}_{1..5}; do 
      duration=$(tail -n +2 $x/trace.csv | sed 's/-/0/g' | datamash sum 17)
      realtime=$(tail -n +2 $x/trace.csv | sed 's/-/0/g' | datamash sum 18)
      delta=$(groovy delta.groovy "$(cat $x/.nextflow.log | head -n 1 | cut -f 1,2 -d ' ')" "$(cat $x/.nextflow.log | tail -n 1 | cut -f 1,2 -d ' ')")
      printf "$delta\t$duration\t$realtime\n" 
    done

}

gettime $1
 
