library(tidyverse)

trips <- readr::read_csv("data_hw1/trip_data_8.csv")
fares <- readr::read_csv("data_hw1/trip_fare_8.csv")

fares$pickup_datetime <- as.POSIXct(as.POSIXlt(fares$pickup_datetime, tz = "America/New_York"))

trips$pickup_datetime <- as.POSIXct(as.POSIXlt(trips$pickup_datetime, tz = "America/New_York"))
trips$dropoff_datetime <- as.POSIXct(as.POSIXlt(trips$dropoff_datetime, tz = "America/New_York"))

trips <- filter(trips, format(trips$pickup_datetime,'%d')== "15")
fares <- filter(fares, format(fares$pickup_datetime,'%d')== "15")

write.csv(fares, file = "data_hw1/question_two_fares.csv")
write.csv(trips, file = "data_hw1/question_two_trips.csv")
