library(tidyverse)

taxi_data <- readr::read_csv("data_hw1/question_five.csv")

ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_trips, y = total_earnings))

ggsave("figures/question_eight_trips.png")

ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_passangers, y = total_earnings))

ggsave("figures/question_eight_passengers.png")

ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_time_with_passengers, y = total_earnings))

ggsave("figures/question_eight_time_with_passengers.png")

ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_distance, y = total_earnings))

ggsave("figures/question_eight_distance.png")

taxi_data <- readr::read_csv("data_hw1/question_six.csv")

ggplot(data = taxi_data) + geom_bar(mapping = aes(x = hour, y = total_trips),stat = "identity") + ggtitle("Number of trips per hour") + xlab("Hour") + ylab("Number of trips")

ggsave("figures/question_eight_Khosla_Devin.png")

sub_data = group_by(taxi_data, hour) %>% 
  summarize(sum_passengers = sum(total_passengers_picked_up) )
p <- ggplot(data=sub_data, aes(x=hour, y=sum_passengers))
p + geom_bar(stat = "identity") + xlab("Hour") + ylab("Total number of passengers") + 
  ggtitle("Total number of passengers picked up in each hour on Aug. 15") +
  scale_x_continuous(breaks=c(0,4,8,12,16,20,24), labels=c("0","4","8","12","16","20","24"))

ggsave("figures/question_eight_Shin_Jeewoen.png")

taxi_data2 <- readr::read_csv("data_hw1/question_seven.csv")

ggplot(data = taxi_data2) + geom_point(mapping = aes(x = hour, y = earnings)) + ggtitle("Earnings regarding each hour") + xlab("Hour") + ylab("Earnings")

ggsave("figures/question_eight_Zhou_Zixuan.png")
