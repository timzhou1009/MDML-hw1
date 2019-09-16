library(tidyverse)
library(gridExtra)

taxi_data <- readr::read_csv("data_hw1/question_six.csv")

pic1 <- ggplot(data = taxi_data) + geom_bar(mapping = aes(x = hour, y = total_trips),stat = "identity")



grid.arrange(pic1, pic2,pic3, ncol=2)

ggsave("figures/question_nine.png")
