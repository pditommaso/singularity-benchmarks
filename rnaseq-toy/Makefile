SHELL=/bin/bash -o pipefail

#
# The main files produced by this script are: 
# - table.txt: the stats included in "Table 1" in the manuscript. 
# - fig_correlation.png: the figure included in the manuscript.
# 
all: stats_singularity.txt stats_docker.txt table.txt 

# 
# Collects the pipeline start/stop timestamp and aggregates tasks duration time
# for each "singularity" execution.  
#   
# in : 
# 	singularity_{1..5}/.nextflow.log
# 	singularity_{1..5}/trace.csv
#
# out: 
#	time_singularity.txt
#
time_singularity.txt:
	./time.sh singularity > time_singularity.txt

# 
# Collects the pipeline start/stop timestamp and aggregates tasks duration time
# for each "docker" execution.  
#   
# in : 
# 	docker_{1..10}/.nextflow.log
# 	docker_{1..10}/trace.csv
#
# out: 
#	time_docker.txt
#
time_docker.txt:
	./time.sh docker > time_docker.txt
	
#
# Collects the trace runtime info for each "singularity" execution into a single file,
# rows are sorted by task name (column 4)
#	
# in : 
#	singularity_{1..10}/trace.csv
#
# out: 
#	trace_singularity.txt
#
trace_singularity.txt:
	cat singularity_{1..5}/trace.csv | grep -v 'task_id' | sort -k4 > trace_singularity.txt
	
#
# Collects the trace runtime info for each "docker" execution into a single file,
# rows are sorted by task name (column 4)
#	
# in : 
#	docker_{1..10}/trace.csv
#
# out: 
#	trace_docker.txt
#
trace_docker.txt:
	cat docker_{1..5}/trace.csv | grep -v 'task_id' | sort -k4 > trace_docker.txt
	
#
# Calculates the median duration time grouping for tasks of the same type for each execution,
# both for "singularity" and "docker" executions. 
# 
# Then collects all of them into a tab-separated file, where each line contains 
# three fields: task name; singularity median task execution time; docker median execution time 
# 
# Task duration time is defined as real wall-clock time from task submission to completion, 
# *including* container instantiation time when docker is used.
# 
# in :
#	singularity_{1..5}/trace.csv
#	docker_{1..5}/trace.csv	
# 
# out: 
#  	plot.csv
#	
plot.csv: 
	./plot.sh docker | sort > plot_docker.txt
	./plot.sh singularity | sort > plot_singularity.txt
	groovy join.groovy > plot.csv
	
#
# Create the figure showing the correlation of "singularity" tasks execution time
# vs "docker" tasks executinon time
# 
# in :
# 	plot.csv 
#	stats_singularity.txt 
#	stats_docker.txt
#
# out:   
#  	fig_correlation.png
# 	
fig_correlation.png: plot.csv stats_singularity.txt stats_docker.txt 
	Rscript Figures.R
	
#
# Aggregate median and mean execution time for tasks of the same type across all pipeline 
# runs for the "singularity" benchmark.  
# 
# in : 
# 	trace_singularity.txt
#
# out: 
#	stats_singularity.txt
# 	
stats_singularity.txt: trace_singularity.txt
	./stage.sh singularity > stats_singularity.txt
	
#
# Aggregate median and mean execution time for tasks of the same type across all pipeline 
# runs for the "docker" benchmark.  
# 
# in : 
# 	trace_docker.txt
# out: 
#	stats_docker.txt
# 		
stats_docker.txt: trace_docker.txt
	./stage.sh docker > stats_docker.txt

#
# Produces the main stats included in "Table 1": 
# 	- median pipeline duration time 
#	- standard deviation of pipeline duration time 
# 	- median task duration time
# 
# Where duration time is defined as the wall-clock execution time, *including* the 
# container instantiation time when Docker is used.
# 
# in : 
# 	time_singularity.txt
# 	time_docker.txt
# 
# out: 
#	stats_docker.txt
# 
table.txt: time_singularity.txt time_docker.txt
	Rscript table.R > table.txt
		
#
# Clean-up task
#		
clean:
	rm -rf stats_* time_*.txt *.png plot.csv table.txt plot_* trace_*
