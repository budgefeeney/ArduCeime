# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

number_ticks <- function(n) {function(limits) pretty(limits, n)}

prm <- read.csv("~/Library/Mobile Documents/com~apple~CloudDocs/Results/ACL/PrecRecAtM.csv")
mms <- read.csv("~/Library/Mobile Documents/com~apple~CloudDocs/Results/ACL/mapetc.csv")

prm$TopicCount = factor(prm$TopicCount)
prm$M = factor(prm$M)

prmSummary = subset(prm, TopicCount != 70 & TopicCount != 90 & TopicCount != 100 & M != 20 & M != 40 & M != 500)

rec_plot <- qplot(data=subset(prm, TopicCount != 70 & TopicCount != 90 & TopicCount != 100 & M != 20 & M != 40 & M != 500), x=TopicCount, y=RecallAll, color=M, group=M) + geom_point() + geom_line() + ylab("Recall at M")
prec_plot <- qplot(data=subset(prm, TopicCount != 70 & TopicCount != 90 & TopicCount != 100 & M != 20 & M != 40 & M != 500), x=TopicCount, y=PrecisionAll, color=M, group=M) + geom_point() + geom_line() + ylab("Precision at M")

mpr_plot <- ggplot(data=subset(mms, TopicCount != 70 & TopicCount != 90 & TopicCount != 100), aes(TopicCount)) + 
  geom_line(aes(y = MAP, colour = "MAP")) + 
  geom_point(aes(y = MAP, colour = "MAP")) + 
  geom_line(aes(y = MRR, colour = "MRR")) + 
  geom_point(aes(y = MRR, colour = "MRR")) +
  theme(legend.title=element_blank()) +
  scale_x_continuous(breaks=number_ticks(7))

prp_plot <- ggplot(data=subset(mms, TopicCount != 70 & TopicCount != 90 & TopicCount != 100), aes(TopicCount)) + 
  geom_line(aes(y = Perplexity, colour = "Perplexity")) + 
  geom_point(aes(y = Perplexity, colour = "Perplexity"))  +
  theme(legend.position="none") +
  scale_x_continuous(breaks=number_ticks(7))

multiplot(prec_plot, mpr_plot, rec_plot, prp_plot, cols=2)




