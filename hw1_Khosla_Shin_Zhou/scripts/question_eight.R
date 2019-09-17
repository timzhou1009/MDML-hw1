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

ggsave("figures/question_eight_Shin_Jeewoen.png")

ggsave("figures/question_eight_Zhou_Zixuan.png")
