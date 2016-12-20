Singularity Benchmarks 
-----------------------

This repository contains the scripts to produce than benchmark table 
comparing Singularity vs Docker performance published at 
[this link](https://www.nextflow.io/blog/2016/more-fun-containers-hpc.html).

Quick start 
------------

To reproduce the table from raw data clone this repository:

	git clone https://github.com/pditommaso/singularity-benchmarks.git && cd singularity-benchmarks

Then pull the required Docker image: 

	docker pull cbcrg/make-peerj5515
	
Finally launch the `make` script using the following command: 

	bash make-all.sh
	
(if you don't want or cannot use Docker, you will need to download and install 
the required dependencies: R, Datamash, Make and Groovy. See the included 
[Dockefile](https://raw.githubusercontent.com/cbcrg/docker-benchmarks/master/Dockerfile) for configuration details).


Related links 
-------------

* https://peerj.com/articles/1273/
* https://github.com/cbcrg/docker-benchmarks 