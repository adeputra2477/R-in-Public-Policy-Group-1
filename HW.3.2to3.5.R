library(nycflights13)
library(tidyverse)
library(ggplot2)
view(flights)

# Problem 3.2.5.1

flights %>%
    filter(
        dest %in% c("IAH", "HOU"),
        carrier %in% c("UA", "AA", "DL"),
        month %in% c(7, 8, 9),
        arr_delay >= 120,
        (dep_delay <= 0 | (dep_delay >= 60 & (dep_delay - arr_delay) > 30))
    )

# Problem 3.2.5.2

# Longest departure delays

flights %>% 
    arrange(desc(dep_delay)) %>% 
    head(1)

# Earliest departure delays

flights %>% 
    filter(!is.na(dep_time)) %>% 
    arrange(dep_time) %>% 
    head(1)

# 3.2.5.3

flights %>% 
    filter(!is.na(air_time) & air_time > 0) %>% 
    mutate(speed = (distance / air_time * 60)) %>% 
    arrange(desc(speed)) %>% 
    head(1)

# 3.2.5.4 : There was

all_dates <- seq(as.Date("2013-01-01"), as.Date("2013-12-31"), by = "day")

flight_dates <- flights %>%
    mutate(date = as.Date(time_hour)) %>%
    distinct(date) %>%
    pull(date)

missing_dates <- setdiff(all_dates, flight_dates)
missing_dates


# 3.2.5.5

# Farthest distance

flights %>% 
    arrange(desc(distance)) %>% 
    head(1)

# Shortest distance

flights %>% 
    arrange(distance) %>% 
    head(1)

# 3.2.5.6

# The final result in terms of which rows are returned will be the same regardless of whether you use filter or arrange. However, the order matters in terms of performance and efficiency.
# For instance, When we apply filter, we reduce the dataset to only those rows that meet your condition. Then, when we use arrange it only has to sort a much smaller subset of rows. This is especially beneficial when working with large datasets.

# 3.3.5.1

# If a flight departs exactly on time, you???d expect dep_time to be nearly equal to sched_dep_time and dep_delay to be 0.
# If the flight departs later than scheduled, dep_time will be greater than sched_dep_time, and dep_delay will be a positive number indicating the number of minutes of delay.
#If the flight departs earlier than scheduled, dep_time will be less than sched_dep_time, and dep_delay will be negative, reflecting that the flight left ahead of schedule

# 3.3.5.2

flights %>% 
    select(dep_time, dep_delay, arr_time, arr_delay)

flights %>% 
    select_at(vars(dep_time, dep_delay, arr_time, arr_delay))

flights %>% 
    select(one_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))

# 3.3.5.3

# When you list the same variable more than once in a select() call, only one copy of that variable is returned in the resulting data frame. In other words, duplicates are ignored???select() de-duplicates the column names rather than including them multiple times.

# 3.3.5.4

# The any_of() function is a tidyselect helper (provided by the tidyselect package, which dplyr uses) that allows you to specify a character vector of column names and then selects only those columns that exist in your data. If some names in the vector are not present, any_of() simply ignores them instead of throwing an error.

# 3.3.5.5

flights |> select(contains("TIME"))

#it will match any column name containing ???time??? in any case (e.g., dep_time, arr_time, sched_dep_time, time_hour). So, if you expected it to match only columns with ???TIME??? in uppercase, then the result might be a bit surprising. 

# If you want to change the default and force case-sensitive matching, you can set the ignore.case argument to FALSE. For example:

flights |> select(contains("TIME", ignore.case = FALSE))


# 3.3.5.6

flights <- flights %>% 
    rename(air_time_min = air_time) %>% 
    select(air_time_min, everything())

view(flights)

# 3.3.5.7.

# The code fails because when you use select(tailnum), you're reducing the data frame to contain only the tailnum column.

# 3.5.7.1.

avg_delay_by_carrier <- flights %>%
    group_by(carrier) %>%
    summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
    arrange(desc(avg_arr_delay))

avg_delay_by_carrier

# Because carriers typically fly a set of routes (not every carrier flies to every airport), the carrier effect and the airport effect are confounded. In other words, if an airline only serves certain ???bad??? airports, then its average delay reflects both its own performance and the challenges of those airports. To fully separate these influences, you would need to compare the performance of different carriers on the same routes. But if there???s little overlap between the routes flown by different airlines, you cannot easily determine whether the poor delay performance is due to the carrier???s operations or the inherent delays at the destination airports.

# 3.5.7.2.

flights %>% 
    filter(!is.na(dep_delay)) %>%  
    group_by(dest) %>% 
    slice_max(dep_delay, n = 1, with_ties = FALSE) %>% 
    ungroup()

# 3.5.7.3

delays_by_hour <- flights %>% 
    group_by(hour) %>% 
    summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE))

ggplot(delays_by_hour, aes(x = hour, y = avg_dep_delay)) +
    geom_line(color = "blue", size = 1.2) +
    geom_point(color = "blue", size = 2) +
    labs(title = "Average Departure Delay by Hour of Day",
         x = "Hour of Day",
         y = "Average Departure Delay (minutes)") +
    scale_x_continuous(breaks = 0:23) +
    theme_minimal()

# The best time to fly on time is early in the morning (before 7 AM).
# The worst time for delays is late afternoon to evening (5-8 PM).
# Late-night flights see improved performance, likely due to lower congestion.

# 3.5.7.4.

# slice_min(var, n = -k): Removes the k smallest values instead of selecting them.

# 3.5.7.5.

#count() simplifies the process of grouping and summarizing by row count.
#It???s equivalent to doing a group_by() followed by summarise(n = n()).
#The sort = TRUE argument automatically orders the groups by descending frequency, making it easier to identify the most common groups in your data.

# 3.5.7.6.a

df <- tibble(
    x = 1:5,
    y = c("a", "b", "a", "a", "b"),
    z = c("K", "K", "L", "L", "K")
)

df |>
    group_by(y)

# The group_by() function doesn't change the data I see. Rather, it adds grouping metadata to the tibble

# 3.5.7.6.b

df |>
    arrange(y)

#arrange(y) sorts the rows so that all observations with y = "a" come first, followed by those with y = "b", which in our data results in the table shown above.
#group_by(y) would not change the row order. It simply tells dplyr to treat rows with the same y value as a group for subsequent operations.

# 3.5.7.6.c

df |>
    group_by(y) |>
    summarize(mean_x = mean(x))

# The pipeline groups the data by the variable y and then calculates the average of x for each group, returning a summary table with one row per group.

# 3.5.7.6.d

df |>
    group_by(y, z) |>
    summarize(mean_x = mean(x))

#The pipeline groups df by both y and z and then computes the mean of x for each group. After summarizing, due to the default .groups argument, the grouping on z is dropped, leaving the output grouped by y.

# 3.5.7.6.e

df |>
    group_by(y, z) |>
    summarize(mean_x = mean(x), .groups = "drop")

# The pipeline groups df by both y and z, calculates the mean of x for each group, and then drops all grouping metadata, leaving you with an ungrouped tibble.
# In part (d) the output retained grouping (grouped by y), while here, using .groups = "drop", the output is completely ungrouped.

# 3.5.7.6.f

df |>
    group_by(y, z) |>
    summarize(mean_x = mean(x))

df |>
    group_by(y, z) |>
    mutate(mean_x = mean(x))

# summarize returns one row per group. In this case, 3 rows???each representing a unique (y, z) combination.
# On the contrary, mutate retains the original row count (5 rows) and simply adds a new column with the group summary repeated on every row of that group.