library(dplyr)
library(XML)
url = "http://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;home_or_away=2;opposition=1;spanmax1=13+Feb+2015;spanmin1=13+Feb+2010;spanval1=span;team=2;template=results;type=batting"
table_1 <- readHTMLTable(url)
length(table_1)
table_1
table_1[`Overall figures`]
mode(table_1)
table_1 <- unlist(table_1)
table_runs <- data.frame(table_1[["Overall figures"]])
names(table_runs)
table_runs <- table_runs[,c(1:15)]
names(table_runs)[11:15] <- c("Fifties","Hundreds","Zeroes","Fours","Sixes")

#World Cup INFO 1

url_batting <- "http://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;filter=advanced;opposition=7;orderby=runs;team=6;template=results;trophy=12;type=batting"
table_bat <- readHTMLTable(url_batting)
batting_figures <- data.frame(table_bat[["Overall figures"]])
dim(batting_figures)
batting_figures <- batting_figures[,c(1:15)]
names(batting_figures)

#Batting Statistics
#Stat 1
#Highest runs in India Pak world cup matches
top_batsmen <- batting_figures[1:5,c(1,3,6,7)]

#Stat 2
#Most number of India Pak matches
batting_figures <- arrange(batting_figures,desc(Mat))
most_matches <- batting_figures[1:5,1:3]

#Stat 3
#Highest Strike rate
batting_figures <- arrange(batting_figures,desc(SR))
highest_strike_rate <- batting_figures[1:5,c(1,10)]

#Bowling Statistics
#Stat 4
#Most number of wickets
url_bowling <- "http://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;filter=advanced;opposition=7;orderby=wickets;team=6;template=results;trophy=12;type=bowling"
table_bowl <- (readHTMLTable(url_bowling))
bowling_figures <- table_bowl[['Overall figures']]

most_wickets <- bowling_figures[1:5,c(1,8,9)]

#Stat 5
#Team Staistics
url_win <- "http://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;filter=advanced;opposition=7;orderby=start;team=6;template=results;trophy=12;type=team;view=results"
win_table <- readHTMLTable(url_win)
win_table <- win_table[['Match results']]
win_table <- win_table[,1:10]

#Partnership table
url_partner <- "http://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;filter=advanced;opposition=7;orderby=fow_score;team=6;template=results;type=fow;view=innings"
table_partner <- readHTMLTable(url_partner)
partner_list <- data.frame(table_partner[['Partnership list']])
scnd_partner <- partner_list[partner_list$Wkt == 2 & partner_list$Inns == 1,]
scnd_partner <- scnd_partner[,c(1,2,3,9)]
write.csv(scnd_partner,"partnership.csv")
