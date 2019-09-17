library(tidyverse)
library(stringr)
library(lubridate)

taxi_data <- read_csv("data_hw1/joined_taxi_data.csv")
taxi_data <- filter(taxi_data, format(taxi_data$pickup_datetime,'%d') == "15")
taxi_data <- filter(taxi_data, format(taxi_data$dropoff_datetime,'%d') == "15")
taxi_data$pickup_datetime <- as.POSIXct(taxi_data$pickup_datetime, tz = "UTC")
taxi_data$dropoff_datetime <- as.POSIXct(taxi_data$dropoff_datetime, tz = "UTC")

taxi_data2 <- crossing(taxi_data,hour = c(0:23))

test2 <- filter(taxi_data2, hour(taxi_data2$pickup_datetime) != hour(taxi_data2$dropoff_datetime))
test3 <- test2[1:24,]
test4 <- filter(test2, test2$trip_time_in_secs == max(test2$trip_time_in_secs))

x <- taxi_data$hack_license[which.max(taxi_data$trip_time_in_secs)]
y <- filter(test2, test2$hack_license == x)

taxi <- test2 %>% 
  mutate(proportion = case_when(hour < hour(pickup_datetime) ~ 0,
                                hour > hour(dropoff_datetime) ~ 0,
                                hour > hour(pickup_datetime) & hour < hour(dropoff_datetime) ~ (3599/trip_time_in_secs),
                                hour == hour(pickup_datetime) & hour == hour(dropoff_datetime) ~ 1,
                                hour == hour(pickup_datetime) & hour < hour(dropoff_datetime) ~ as.numeric(difftime(ceiling_date(pickup_datetime,unit = "h"),pickup_datetime,unit = "secs"))/trip_time_in_secs, 
                                hour == hour(dropoff_datetime) & hour > hour(pickup_datetime) ~ as.numeric(difftime(dropoff_datetime,floor_date(dropoff_datetime),unit = "h"),units = "secs"))/trip_time_in_secs) %>% 
  group_by(hack_license,hour) %>%
  summarise(total_time_with_passengers = sum(proportion*trip_time_in_secs),
            miles_with_passengers = sum(proportion*trip_distance),
            earnings = sum(proportion*total_amount))

write.csv(question_six, file = "data_hw1/question_seven.csv")
