library(tidyverse)

taxi_data <- read_csv("data_hw1/joined_taxi_data.csv")
taxi_data <- filter(taxi_data, format(taxi_data$pickup_datetime,'%d')== "15")

taxi_data <- crossing(taxi_data,c(0:23))

# use case_when

case_when(
  
)
