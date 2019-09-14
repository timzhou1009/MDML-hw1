library(tidyverse)

taxi_data <- readr::read_csv("data_hw1/joined_taxi_data.csv")

total_time_with_passengers <- 
  taxi_data %>% filter(lubridate::day(pickup_datetime) == 15) %>% group_by(hack_license,day = lubridate::day(pickup_datetime)) %>% summarise(total_time_with_passengers = mean(trip_time_in_secs))

total_distance <- 
  taxi_data  %>% filter(lubridate::day(pickup_datetime) == 15) %>% group_by(hack_license,day = lubridate::day(pickup_datetime)) %>% summarise(total_distance = mean(trip_distance))

total_earnings <- 
  taxi_data  %>% filter(lubridate::day(pickup_datetime) == 15) %>% group_by(hack_license,day = lubridate::day(pickup_datetime)) %>% summarise(total_earnings = mean(total_amount))

test <- crossing(unique(taxi_data$hack_license[lubridate::day(taxi_data$pickup_datetime) == 15]),c(0:23)) 

colnames(test) <- c("hack_license","hour")

question_7.1 <- full_join(test,total_time_with_passengers)
question_7.2 <- full_join(test,total_distance)
question_7.3 <- full_join(test,total_earnings)

question_seven <- full_join(question_7.1,question_7.2, by = c("hack_license", "hour")) %>% full_join(question_7.3, by = c("hack_license", "hour"))

question_seven <- question_seven[,-c(3,5,7)]

write.csv(question_seven, file = "data_hw1/question_seven.csv")
