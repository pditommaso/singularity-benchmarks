for x in 1 2 3 4 5; do mv dckr$x docker_$x; mv sing$x singularity_$x; done
for x in {docker,singularity}_{1..5}; do mv $x/trace.txt $x/trace.csv; done
