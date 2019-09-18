library(tidyverse)
library(stringr)
library(lubridate)

taxi_data <- read_csv("data_hw1/joined_taxi_data.csv")
taxi_data <- taxi_data %>% mutate(amount = tip_amount + fare_amount)

taxi_data$pickup_datetime <- as.POSIXct(as.POSIXlt(taxi_data$pickup_datetime, tz = "America/New_York"))
taxi_data$dropoff_datetime <- as.POSIXct(as.POSIXlt(taxi_data$dropoff_datetime, tz = "America/New_York"))

taxi_data <- filter(taxi_data, format(taxi_data$pickup_datetime,'%d') == "15")

taxi_data2 <- crossing(taxi_data,hour = c(0:23))

final <- taxi_data2 %>% mutate(secondsPU = 60*minute(pickup_datetime)+second(pickup_datetime),secondsDO = 60*minute(dropoff_datetime)+second(dropoff_datetime))

final <- final %>% mutate(seconds = as.numeric(difftime(dropoff_datetime,pickup_datetime,units = "secs")))

final <- final %>% 
  mutate(proportion = case_when(hour < hour(pickup_datetime) ~ 0,
                                hour > hour(dropoff_datetime) ~ 0,
                                hour > hour(pickup_datetime) & hour < hour(dropoff_datetime) ~ (3600/seconds),
                                hour == hour(pickup_datetime) & hour == hour(dropoff_datetime) ~ 1,
                                hour == hour(pickup_datetime) & hour < hour(dropoff_datetime) ~ (3600-secondsPU)/seconds, 
                                hour == hour(dropoff_datetime) & hour > hour(pickup_datetime) ~ secondsDO/seconds)) %>% 
  group_by(hack_license,hour) %>%
  summarise(total_time_with_passengers = sum(proportion*trip_time_in_secs),
            miles_with_passengers = sum(proportion*trip_distance),
            earnings = sum(proportion*amount))

write.csv(final, file = "data_hw1/question_seven.csv")
