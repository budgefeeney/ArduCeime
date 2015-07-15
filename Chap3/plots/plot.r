library("ggplot2")
library("gridExtra")

# Load and parse file into factors and measures
expr <- read.csv("/Users/bryanfeeney/iCloud/Results/SideTopicResults/results-3.csv")
expr$K = factor(expr$K)
expr$P = factor(expr$P)

qplot(data=subset(expr, Algor=='STM_bouchard' | Algor=='STM_bohning'), y=Tperp, x=K, shape=Dataset, facets=Algor~P) + ylab('Train Perplexity') + xlab('Topic Count') + labs(shape='Features') + theme_bw()
#qplot(data=subset(expr, dataset=='Tweet750' & (algor=='LDA' | algor=='CTM/Bohning' | algor=='CTM/Bouchard')), y=QueryPerplexity, x=K, color=algor, shape=algor, facets=~dataset)
      
l <- qplot(data=subset(expr, Dataset=='Tweets' & (Algor=='LDA/VB' | Algor=='CTM_bohning' | Algor=='CTM_bouchard')), y=Qperp, x=K, shape=Algor, facets=~Dataset) + ylab('Query Perplexity') + xlab('Topic Count') + theme_bw()
r <- qplot(data=subset(expr, Dataset=='Tweets' & (Algor=='LDA/VB' | Algor=='CTM_bohning' | Algor=='CTM_bouchard')), y=Tperp, x=K, shape=Algor, facets=~Dataset) + ylab('Train Perplexity') + xlab('Topic Count') + theme_bw()

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