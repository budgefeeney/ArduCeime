library('ggplot2')

sm <- read.csv("~/Workspace/ArduCeime/Chap1/plots/summary-all-on-all-clean.csv", header=FALSE)

sm$Algorithm = factor(sm$V1)
sm$TopicCount = factor(sm$V2)
sm$Dataset = factor(sm$V3)
sm$Iterations = factor(sm$V4)
sm$Perplexity = factor(sm$V5)

sm$clusters = sm$TopicCount

qplot(data=subset(sm, clusters==2 | clusters==3 | clusters==25 | clusters==30 | clusters==35 | clusters==40 | clusters==50 | clusters==60 | clusters==70 | clusters==80 | clusters==90 | clusters==100 | clusters==125 ), x=clusters, y=Perplexity, shape=Iterations, facets=Dataset~Algorithm) + labs(shape='Iterations') + xlab('Topic Count') + theme_bw()


