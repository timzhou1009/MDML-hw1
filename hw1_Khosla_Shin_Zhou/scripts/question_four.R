library(tidyverse)

fares <- readr::read_csv("data_hw1/question_three_fares.csv")
trips <- readr::read_csv("data_hw1/question_three_trips.csv")

fares$pickup_datetime <- as.POSIXct(as.POSIXlt(fares$pickup_datetime, tz = "America/New_York"))

trips$pickup_datetime <- as.POSIXct(as.POSIXlt(trips$pickup_datetime, tz = "America/New_York"))
trips$dropoff_datetime <- as.POSIXct(as.POSIXlt(trips$dropoff_datetime, tz = "America/New_York"))

taxi_data <- inner_join(trips,fares,by = c("pickup_datetime","medallion"))

dups <- taxi_data %>% count(medallion, hack_license.x, pickup_datetime) %>% filter(n>1)

write.csv(taxi_data, file = "data_hw1/question_four.csv")
