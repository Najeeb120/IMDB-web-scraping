
install.packages('rvest')

library(rvest)

movie_db<-read_html('http://www.imdb.com/movies-in-theaters/?ref_=nv_mv_inth_1')



title <- movie_db%>%html_nodes("h4 a")%>%html_text() 
title


movie_genre <- movie_db%>%html_nodes("time+span")%>%html_text() 
movie_genre

time <- movie_db%>%html_nodes("time")%>%html_text() 
time

metascore <-movie_db%>%html_nodes(".rating_txt")%>%html_nodes("strong")%>%html_text() 

metascore

imdb_df <- data.frame(title,movie_genre,time,metascore)

imdb_df$time <-gsub("min","",imdb_df$time)
imdb_df$time <-as.numeric(imdb_df$time)

imdb_df$title[imdb_df$movie_genre!= "Action" & imdb_df$time<200]




movie_genre_time<-by(imdb_df$time,movie_genre,function(x) mean(x))

barplot(movie_genre_time,main="Average movie length by genre",xlab="Number of genres",ylab="Time in mins")


movie_long_time<-by(imdb_df$time,movie_genre,function(x) max(x))

barplot(movie_long_time,main="Average movie length by genre",xlab="movies",ylab="Time in mins")


table(imdb_df$title,imdb_df$metascore)

barplot(movie_highscore,main="Average movie length by genre",xlab="movies",ylab="Time in mins")

