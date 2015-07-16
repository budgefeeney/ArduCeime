library("ggplot2")
library("gridExtra")

# Load and parse file into factors and measures
expr <- read.csv("/Users/bryanfeeney/Workspace/ArduCeime/Chap3/plots/results-4-group.csv")
expr$K = factor(expr$K)
expr$P = factor(expr$P)

#qplot(data=subset(expr, Dataset=='ACL' & (Algor=="STM_bohning" | Algor=="STM_bouchard")), y=Perp, x=K, shape=Algor, facets=Segment~P) + ylab('ACL Perplexity') + xlab('Topic Count') + labs(shape='Algorithm') + theme_bw()
#qplot(data=subset(expr, Dataset=='Tweets' & (Algor=="STM_bohning" | Algor=="STM_bouchard")), y=Perp, x=K, shape=Algor, facets=Segment~P) + ylab('Tweet Perplexity') + xlab('Topic Count') + labs(shape='Algorithm') + theme_bw()
#qplot(data=subset(expr, dataset=='Tweet750' & (algor=='LDA' | algor=='CTM/Bohning' | algor=='CTM/Bouchard')), y=QueryPerplexity, x=K, color=algor, shape=algor, facets=~dataset)
      
qplot(data=subset(expr, Dataset=='Tweets'), y=Perp, x=K, shape=Algor, facets=Segment~P) + ylab('Tweet Perplexity') + xlab('Topic Count') + labs(shape='Algorithm') + theme_bw()
qplot(data=subset(expr, Dataset=='ACL' & K != 125 & K != 150), y=Perp, x=K, shape=Algor, facets=Segment~P) + ylab('Tweet Perplexity') + xlab('Topic Count') + labs(shape='Algorithm') + theme_bw()



l <- qplot(data=subset(expr, Dataset=='Tweets' & Segment=="Train" & (Algor=='LDA/VB' | Algor=='CTM_bohning' | Algor=='CTM_bouchard')), y=Perp, x=K, shape=Algor, facets=~Dataset) + ylab('Query Perplexity') + xlab('Topic Count') + theme_bw()
r <- qplot(data=subset(expr, Dataset=='Tweets' & Segment=="Query" & (Algor=='LDA/VB' | Algor=='CTM_bohning' | Algor=='CTM_bouchard')), y=Perp, x=K, shape=Algor, facets=~Dataset) + ylab('Train Perplexity') + xlab('Topic Count') + theme_bw()

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