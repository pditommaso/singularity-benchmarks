library(scales)
library(reshape)
library(ggplot2)
library(grid)

NF_stats<-read.csv("plot.csv",header=T)
NF_stats = cbind(NF_stats, shape=rep("16",dim(NF_stats)[1]))

nL = dim(read.table("stats_docker.txt", skip=1, header=F))[1]

NF_median =  data.frame(list( name = c("median"), realtime_docker = read.table("stats_docker.txt", skip=nL, header=F)[,2], realtime_singularity = read.table("stats_singularity.txt", skip=nL, header=F)[,2], shape = c("6")))
NF_mean =  data.frame(list( name = c("mean"), realtime_docker = read.table("stats_docker.txt", skip=nL, header=F)[,3], realtime_singularity = read.table("stats_singularity.txt", skip=nL, header=F)[,3], shape = c("8")))

NF_stats$realtime_docker_log10 = log10((NF_stats$realtime_docker/1000)/60)
NF_stats$realtime_singularity_log10 = log10((NF_stats$realtime_singularity/1000)/60)

max_axis = max(c(NF_stats$realtime_docker_log10, NF_stats$realtime_singularity_log10)) * 1.08
min_axis = min(c(NF_stats$realtime_docker_log10, NF_stats$realtime_singularity_log10)) * 1.01

lbreaks = log10(c(1,10,100,1000))
llabels = c(1,10,100,1000)
png(filename = "fig_correlation.png", width = 5, height = 4, units = 'in', res = 300)
qplot(x=realtime_docker_log10, y=realtime_singularity_log10, data=NF_stats, main="", color=name, ylab="singularity tasks avg. time (mins)", xlab="Docker tasks avg. time (mins)") + 
    geom_point(size = 3, aes(shape = shape)) +
    geom_point( data = NF_median, aes(x=log10((realtime_docker/1000)/60), y=log10((realtime_singularity/1000)/60), shape = shape, color = NA), size = 3) +
    geom_point( data = NF_mean, aes(x=log10((realtime_docker/1000)/60), y=log10((realtime_singularity/1000)/60), shape = shape, color = NA), size = 3) +    
    scale_shape_manual(values = c(16, 6, 8), breaks = c("6","8"), labels = c("median","mean")) +
    geom_abline(intercept = 0, size=.2) +
    scale_x_continuous(limits = c(min_axis,max_axis), breaks = lbreaks, labels = llabels) +
    scale_y_continuous(limits = c(min_axis,max_axis), breaks = lbreaks, labels = llabels) +
    labs(color = "Task", title='Variant calling', shape = "") +
    theme(axis.text.x=element_text(size=10), axis.text.y=element_text(size=10), axis.title.y=element_text(size=8), axis.title.x=element_text(size=8),legend.text=element_text(size=8),legend.title=element_text(size=8))

dev.off()


