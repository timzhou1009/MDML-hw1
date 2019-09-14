library(tidyverse)

fares <- readr::read_csv("data_hw1/question_three_fares.csv")
trips <- readr::read_csv("data_hw1/question_three_trips.csv")

taxi_data <- inner_join(trips,fares,by = c("pickup_datetime","medallion"))

write.csv(taxi_data, file = "data_hw1/question_four.csv")
