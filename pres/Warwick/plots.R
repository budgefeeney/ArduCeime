prm <- read.csv("~/Library/Mobile Documents/com~apple~CloudDocs/Results/ACL/PrecRecAtM.csv")
mms <- read.csv("~/Library/Mobile Documents/com~apple~CloudDocs/Results/ACL/mapetc.csv")

prm$TopicCount = factor(prm$TopicCount)
prm$M = factor(prm$M)

prmSummary = subset(prm, TopicCount != 70 & TopicCount != 90 & TopicCount != 100 & M != 20 & M != 40 & M != 500)

qplot(data=subset(prm, TopicCount != 70 & TopicCount != 90 & TopicCount != 100 & M != 20 & M != 40 & M != 500), x=TopicCount, y=RecallAll, color=M, group=M) + geom_point() + geom_line() + ylab("Recall at M")
qplot(data=subset(prm, TopicCount != 70 & TopicCount != 90 & TopicCount != 100 & M != 20 & M != 40 & M != 500), x=TopicCount, y=PrecisionAll, color=M, group=M) + geom_point() + geom_line() + ylab("Precision at M")
