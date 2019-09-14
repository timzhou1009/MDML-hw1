library(tidyverse)

taxi_data <- readr::read_csv("data_hw1/joined_taxi_data.csv")

total_trips <- taxi_data %>% group_by(medallion) %>% summarise(total_trips=n())
total_passengers <- taxi_data %>% group_by(medallion) %>% summarise(total_passangers = sum(passenger_count))
total_time_with_passengers <- taxi_data %>% group_by(medallion) %>% summarise(total_time_with_passengers = sum(trip_time_in_secs))
total_distance <- taxi_data %>% group_by(medallion) %>% summarise(total_distance = sum(trip_distance))
total_earnings <- taxi_data %>% group_by(medallion) %>% summarise(total_earnings = sum(total_amount))

medallion <- full_join(total_trips,total_passengers) %>% full_join(total_time_with_passengers) %>% full_join(total_distance) %>% full_join(total_earnings)

write.csv(medallion, file = "data_hw1/question_five.csv")
