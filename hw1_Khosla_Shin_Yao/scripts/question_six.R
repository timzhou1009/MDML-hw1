library(tidyverse)

taxi_data <- readr::read_csv("data_hw1/joined_taxi_data.csv")

total_passengers_picked_up <- 
  taxi_data %>% group_by(hack_license,hour = lubridate::hour(pickup_datetime)) %>% summarise(total_passengers_picked_up = sum(passenger_count))

total_trips <- 
  taxi_data  %>% group_by(hack_license,hour = lubridate::hour(pickup_datetime)) %>% summarise(total_trips=n())

test <- crossing(unique(taxi_data$hack_license),c(0:23)) 

colnames(test) <- c("hack_license","hour")

question_six1 <- full_join(test,total_passengers_picked_up)
question_six2 <- full_join(test,total_trips)

question_six <- full_join(question_six1,question_six2)

question_six[is.na(question_six)] <- 0

write.csv(question_six, file = "data_hw1/question_six.csv")
