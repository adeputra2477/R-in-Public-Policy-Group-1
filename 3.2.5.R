library(nycflights13)
library(tidyverse)

# 3.2.5
# Q1
# Flights with an arrival delay of two or more hours
arrival_delay_2hrs <- flights |> 
  filter(arr_delay >= 120)

# Flights that flew to Houston (IAH or HOU)
flights_to_houston <- flights |> 
  filter(dest %in% c("IAH", "HOU"))

# Flights that flew to Houston (IAH or HOU) using |
flights_to_houston <- flights |>
  filter(dest == "IAH" | dest == "HOU")

# Flights operated by United, American, or Delta
flights_by_ua_aa_dl <- flights |>
  filter(carrier %in% c("UA", "AA", "DL"))

# Flights that departed in summer (July, August, and September)
summer_flights <- flights |>
  filter(month %in% c(7, 8, 9))

# Flights that arrived more than two hours late but didn’t leave late
late_arrival_on_time_departure <- flights |>
  filter(arr_delay > 120 & dep_delay <= 0)

# Flights that were delayed by at least an hour, but made up over 30 minutes in flight
made_up_time <- flights |>
  filter(dep_delay >= 60 & (dep_delay - arr_delay) > 30)

#Q2

# Sort flights by departure delay in descending order
longest_dep_delays <- flights |>
  arrange(desc(dep_delay))

head(longest_dep_delays, 5)

#Q3

# Calculate speed (distance divided by air time) and sort by speed in descending order
fastest_flights <- flights |>
  mutate(speed = distance / air_time * 60) |> # Convert to miles per hour
  arrange(desc(speed))
head(fastest_flights, 5)

#Q4

# Check if there was at least one flight on each day of 2013
flights_by_day <- flights |>
  group_by(year, month, day) |>
  summarise(flight_count = n())

all_days_covered <- nrow(flights_by_day) == 365
all_days_covered

#Q5

# Find the flight that traveled the farthest distance
farthest_flight <- flights |>
  arrange(desc(distance)) |>
  head(1)

# Find the flight that traveled the least distance
shortest_flight <- flights |>
  arrange(distance) |>
  head(1)

#Q6

#Filtering the data first reduces the size of the dataset, making the subsequent sorting operation faster. For example, if you filter out most of the rows first, sorting fewer rows will be quicker.