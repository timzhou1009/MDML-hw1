library(tidyverse)

trips <- read.csv("data_hw1/question_two_trips.csv")
fares <- read.csv("data_hw1/question_two_fares.csv")

fares$pickup_datetime <- as.POSIXct(as.POSIXlt(fares$pickup_datetime, tz = "America/New_York"))

trips$pickup_datetime <- as.POSIXct(as.POSIXlt(trips$pickup_datetime, tz = "America/New_York"))
trips$dropoff_datetime <- as.POSIXct(as.POSIXlt(trips$dropoff_datetime, tz = "America/New_York"))

sum(is.na(trips$store_and_fwd_flag))
sum(is.na(trips$dropoff_latitude))
sum(is.na(trips$dropoff_longitude))

# I find that there are NA's in these columns. There are many in the store_and_fwd_flag column and 3 in the dropoff_latitude and 3 in the dropoff_longitude. When we look at the data dictionary, we can see that the store_and_fwd_flag is an unkown attribute. Since most of these are NA, it makes sense to simply drop this column. 

trips <- trips[,-5]

sum(is.na(fares))

# I do not find that there are any NA's in the fares tibble and when looking at the data dictionary, all of the variables look like they could be useful so there is no need to remove anything. 

# We also have the pickup/dropoff date and time in the same column currenty. It may be helpful to have these split up so I will create new column with this individual data. 

trips$pickup_date <- as.Date(trips$pickup_datetime)
trips$pickup_time <- format(as.POSIXct(trips$pickup_datetime),"%H:%M:%S")

trips$dropoff_date <- as.Date(trips$dropoff_datetime)
trips$dropoff_time <- format(as.POSIXct(trips$dropoff_datetime),"%H:%M:%S")

# I find that there are some surcharges which have negative values so I will remove them.
fares <- filter(fares, fares$surcharge >= 0)

# I find that there are some mta_tax which have negative values so I will remove them.
fares <- filter(fares, fares$mta_tax > 0)

# I find that there are some tips which have negative values so I will remove them.
fares <- filter(fares, fares$tip_amount >= 0)

# I find that there are some toll amounts which have negative values so I will remove them.
fares <- filter(fares, fares$total_amount > 0)

# I find that there are some total amounts which have negative values so I will remove them.
fares <- filter(fares, fares$tolls_amount >= 0)

# I find that there are some payment codes which do not make sense so I will remove them.
fares <- filter(fares, fares$payment_type == "CRD" | fares$payment_type == "CSH")

# I find that there are some fares which have negative values so I will remove them.
fares <- filter(fares, fares$fare_amount >= 2.5)

# When looking at the location of pickup and drop off location some fo the longitudes and latitudes were in the middle of the Atlantic ocean. I found an approximation for Jersey, NYC and Long Island and subset to only include these.

w <- -74.619802
e <- -73.677250
n <- 41.326017
s <- 40.486098

trips <- filter(trips, trips$pickup_longitude > w & trips$pickup_longitude < e)
trips <- filter(trips, trips$pickup_latitude > s & trips$pickup_latitude < n)

trips <- filter(trips, trips$dropoff_longitude > w & trips$dropoff_longitude < e)
trips <- filter(trips, trips$dropoff_latitude > s & trips$dropoff_latitude < n)

# I find that there are some trip times which are negative and 0 so I will remove them.
trips <- filter(trips, trips$trip_time_in_secs > 0)

# I find that there are some trip passenger counts which are negative and 0 so I will remove them.
trips <- filter(trips, trips$passenger_count > 0)

write.csv(fares, file = "data_hw1/question_three_fares.csv")
write.csv(trips, file = "data_hw1/question_three_trips.csv")



