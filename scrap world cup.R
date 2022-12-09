install.packages("rvest") 
install.packages(ggplo)
library(rvest)
library(dplyr)

##web scraping##
url_worldcup="https://www.skysports.com/world-cup-table"
dataread=rvest::read_html(url_worldcup)
dataread  
tableaux=rvest::html_table(dataread)
length(tableaux) 
tableaux[[1]]
tableaux

##Une fonction qui permet de lire la page web et de compiler les differents tableaux en un seul data frame##
f_wordcup= function(){
  url_worldcup="https://www.skysports.com/world-cup-table"
  dataread=rvest::read_html(url_worldcup)
  tableaux=rvest::html_table(dataread)
  mondial=do.call(rbind,list(tableaux[[1]],tableaux[[2]],tableaux[[3]],tableaux[[4]],tableaux[[5]],tableaux[[6]],tableaux[[7]],tableaux[[8]]))
  }
mondial[1]=NULL
f_wordcup()


##Un graphique en baton avec les 10 equipes##
library(ggplot2)
str(tableaux)
tableaux%>%arrange(desc(pts))%>%head(10)%>%
  ggplot::aes(y=Team, x=Pts))+
  geom_bar(stat="identity")

