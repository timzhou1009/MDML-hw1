library(tidyverse)
library(gridExtra)

taxi_data <- readr::read_csv("data_hw1/question_six.csv")

pic1 <- ggplot(data = taxi_data) + geom_bar(mapping = aes(x = hour, y = total_trips),stat = "identity")

pic2 <- ggplot(data=sub_data, aes(x=hour, y=sum_passengers)) + 
  geom_bar(stat = "identity") + xlab("Hour") + ylab("Total number of passengers") + 
  ggtitle("Total number of passengers picked up in each hour on Aug. 15") +
  scale_x_continuous(breaks=c(0,4,8,12,16,20,24), labels=c("0","4","8","12","16","20","24"))

grid.arrange(pic1, pic2,pic3, ncol=2)

ggsave("figures/question_nine.png")
