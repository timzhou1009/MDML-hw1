library(tidyverse)
library(gridExtra)

taxi_data <- readr::read_csv("data_hw1/question_five.csv")

pic1 <- ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_time_with_passengers, y = total_passangers))

pic2 <- ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_time_with_passengers, y = total_trips))

pic3 <- ggplot(data = taxi_data) + geom_point(mapping = aes(x = total_passangers, y = total_trips))

grid.arrange(pic1, pic2,pic3, ncol=2)
