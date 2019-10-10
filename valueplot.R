#plot 4 major sports leagues average franchise values
install.packages("ggplot2")
install.packages("plotly")
library(ggplot2)
library(reshape2)
library(plotly)

MLB <- read.csv("mlb-avg-value.csv", header = FALSE)
NBA <- read.csv("nba-avg-value.csv", header = FALSE)
NFL <- read.csv("nfl-avg-value.csv", header = FALSE)
NHL <- read.csv("nhl-avg-value.csv", header = FALSE)

names(MLB) <- c("Year", "Average MLB Franchise Value")
names(NBA) <- c("Year", "Average NBA Franchise Value")
names(NFL) <- c("Year", "Average NFL Franchise Value")
names(NHL) <- c("Year", "Average NHL Franchise Value")

fulldata <- merge(MLB, NBA)
fulldata <- merge(fulldata, NFL)
fulldata <- merge(fulldata, NHL)
names(fulldata) <- c("Year", "MLB", "NBA", "NFL", "NHL")
#remove commas
fulldata$MLB <- gsub(",", "", fulldata$MLB)
fulldata$NBA <- gsub(",", "", fulldata$NBA)
fulldata$NFL <- gsub(",", "", fulldata$NFL)
fulldata$NHL <- gsub(",", "", fulldata$NHL)

melted <- melt(fulldata, id.vars = "Year")
melted$value <- as.numeric(melted$value)
p <- ggplot(data = melted, aes(x = Year, y = value, group = factor(variable))) + 
  geom_line(size=0.5, aes(color=variable), alpha=1) +
  labs(title = "Average Franchise Value of 4 Major Sports Leagues from 2002 to 2018", 
       y = "Franchise Value (in Millions USD)", 
       x = "Year") +
  theme(plot.title = element_text(size = 8, hjust = 0.5))

pl <- ggplotly(p)
htmlwidgets::saveWidget(as_widget(pl), "graph.html")
