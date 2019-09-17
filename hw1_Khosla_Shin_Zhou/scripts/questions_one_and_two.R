library(tidyverse)

trips <- readr::read_csv("data_hw1/trip_data_8.csv")
fares <- readr::read_csv("data_hw1/trip_fare_8.csv")

trips <- filter(trips, format(trips$pickup_datetime,'%d')== "15")
fares <- filter(fares, format(fares$pickup_datetime,'%d')== "15")

write.csv(fares, file = "data_hw1/question_two_fares.csv")
write.csv(trips, file = "data_hw1/question_two_trips.csv")
