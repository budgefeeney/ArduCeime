library("ggplot2")
library("gridExtra")

# Load and parse file into factors and measures
expr <- read.csv("/Users/bryanfeeney/Workspace/ArduCeime/Chap2/plots/NIPS-Old.csv")
expr$K = factor(expr$K)
expr$P = factor(expr$P)

qplot(data=expr, y=BohQp, x=K, facets=~P, main="STM/Bohning Query Perplexity")  + ylab("Query Perplexity") + xlab("Topic Count") + ylim(c(0,2500)) + theme_bw()
qplot(data=expr, y=BouQp, x=K, facets=~P, main="STM/Bouchard Query Perplexity") + ylab("Query Perplexity") + xlab("Topic Count") + ylim(c(0,2500)) + theme_bw()
#qplot(data=subset(expr, dataset=='Tweet750' & (algor=='LDA' | algor=='CTM/Bohning' | algor=='CTM/Bouchard')), y=QueryPerplexity, x=K, color=algor, shape=algor, facets=~dataset)

# l <- qplot(data=subset(expr, dataset=='Tweet750' & (algor=='LDA' | algor=='CTM/Bohning' | algor=='CTM/Bouchard')), y=QueryPerplexity, x=K, color=algor, shape=algor, facets=~dataset)
# r <- qplot(data=subset(expr, dataset=='Tweet750' & (algor=='LDA' | algor=='CTM/Bohning' | algor=='CTM/Bouchard')), y=TrainPerplexity, x=K, color=algor, shape=algor, facets=~dataset)
# 
# g_legend<-function(p){
#   tmp <- ggplotGrob(p)
#   leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
#   legend <- tmp$grobs[[leg]]
#   return(legend)}
# 
# legend <- g_legend(l)
# lwidth <- sum(legend$width)
# 
# ## using grid.arrange for convenience
# ## could also manually push viewports
# grid.arrange(arrangeGrob(l + theme(legend.position="none"),
#                          r + theme(legend.position="none")
# ), legend, 
# widths=unit.c(unit(1, "npc") - lwidth, lwidth), nrow=1)