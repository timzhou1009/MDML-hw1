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

ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_time_with_passengers, y = total_passangers))

ggsave("figures/question_eight_Shin.png")

ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_time_with_passengers, y = total_trips))

ggsave("figures/question_eight_Khosla_Devin.png")

ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_passangers, y = total_trips))

ggsave("figures/question_eight_Yao.png")
