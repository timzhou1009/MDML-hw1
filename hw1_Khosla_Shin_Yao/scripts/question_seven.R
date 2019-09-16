library(tidyverse)
library(stringr)
library(lubridate)

taxi_data <- read_csv("data_hw1/joined_taxi_data.csv")
taxi_data <- filter(taxi_data, format(taxi_data$pickup_datetime,'%d') == "15")

taxi_data <- crossing(taxi_data,hour = c(0:23))

taxi_data <- taxi_data %>% 
  mutate(proportion = case_when(hour < hour(pickup_datetime) ~ 0,
                                hour > hour(dropoff_datetime) ~ 0,
                                hour > hour(pickup_datetime) & hour < hour(dropoff_datetime) ~ (3600/trip_time_in_secs),
                                hour == hour(pickup_datetime) & hour == hour(dropoff_datetime) ~ 1,
                                hour == hour(pickup_datetime) & hour < hour(dropoff_datetime) ~ (time_length(ceiling_date(pickup_datetime,unit = "h")-pickup_datetime))/trip_time_in_secs, 
                                hour == hour(dropoff_datetime) & hour > hour(pickup_datetime) ~ ((time_length(dropoff_datetime - floor_date(dropoff_datetime,unit = "h"))))/trip_time_in_secs)) %>%
  group_by(hack_license,hour) %>%
  summarise(total_time_with_passengers = sum(proportion*trip_time_in_secs),
            miles_with_passengers = sum(proportion*trip_distance),
            earnings = sum(proportion*total_amount))

write.csv(question_six, file = "data_hw1/question_seven.csv")
