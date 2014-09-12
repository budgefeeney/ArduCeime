library("ggplot2")
library("gridExtra")

# Load and parse file into factors and measures
expr <- read.csv("/Users/bryanfeeney/Workspace/ArduCeime/Chap2/plots/Tweet750Results.csv")
expr$K = factor(expr$K)
expr$P = factor(expr$P)

qplot(data=subset(expr, algor=='STM/Bouchard' | algor=='STM/Bohning'), y=TrainPerplexity, x=K, shape=dataset, facets=algor~P) + ylab('Train Perplexity') + xlab('Topic Count') + labs(shape='Features') + theme_bw()
#qplot(data=subset(expr, dataset=='Tweet750' & (algor=='LDA' | algor=='CTM/Bohning' | algor=='CTM/Bouchard')), y=QueryPerplexity, x=K, color=algor, shape=algor, facets=~dataset)
      
l <- qplot(data=subset(expr, dataset=='Tweet750' & (algor=='LDA' | algor=='CTM/Bohning' | algor=='CTM/Bouchard')), y=QueryPerplexity, x=K, shape=algor, facets=~dataset) + ylab('Query Perplexit') + xlab('Topic Count') + theme_bw()
r <- qplot(data=subset(expr, dataset=='Tweet750' & (algor=='LDA' | algor=='CTM/Bohning' | algor=='CTM/Bouchard')), y=TrainPerplexity, x=K, shape=algor, facets=~dataset) + ylab('Query Perplexit') + xlab('Topic Count') + theme_bw()

g_legend<-function(p){
  tmp <- ggplotGrob(p)
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

legend <- g_legend(l)
lwidth <- sum(legend$width)

## using grid.arrange for convenience
## could also manually push viewports
grid.arrange(arrangeGrob(l + theme(legend.position="none"),
                         r + theme(legend.position="none")
                        ), legend, 
             widths=unit.c(unit(1, "npc") - lwidth, lwidth), nrow=1)