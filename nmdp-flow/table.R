singularity <- read.delim("time_singularity.txt", header=TRUE)
docker <- read.delim("time_docker.txt", header=TRUE)

stderr <- function(x) sd(x)/sqrt(length(x))

singularity_mean_exec_time = mean(singularity$duration) / 1000 /60
docker_mean_exec_time = mean(docker$duration) / 1000 /60

singularity_err = stderr(singularity$duration) / 1000 /60
docker_err = stderr(docker$duration) / 1000 /60

singularity_stdev_exec_time = sd(singularity$duration) / 1000 /60
docker_stddev_exec_time = sd(docker$duration) / 1000 /60

# each instance executes 48 tasks 
singularity_mean_task_time = singularity_mean_exec_time / 48
docker_mean_task_time = docker_mean_exec_time / 48

cat(sprintf("VARIANT CALL.   : singularity  docker\n"))
cat(sprintf("Task mean time  : %.1f  %.1f\n", singularity_mean_task_time, docker_mean_task_time))
cat(sprintf("Mean exec time  : %.1f (±%.1f) %.1f (±%.1f) \n", singularity_mean_exec_time, singularity_err, docker_mean_exec_time, docker_err))
cat(sprintf("Stddev exec time: %.1f  %.1f\n", singularity_stdev_exec_time, docker_stddev_exec_time))
cat(sprintf("Slow-down       : %.3f\n" , docker_mean_exec_time/singularity_mean_exec_time))
