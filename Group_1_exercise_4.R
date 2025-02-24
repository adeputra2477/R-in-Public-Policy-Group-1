# 4.6 exercises: restyle according the guidelines

## First pipeline:
flights %>%
  filter(dest == "IAH") %>%
  group_by(year, month, day) %>%
  summarize(
    n = n(),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(n > 10)

## Second pipeline:
flights %>%
  filter(
    carrier == "UA",
    dest %in% c("IAH", "HOU"),
    sched_dep_time > 0900,
    sched_arr_time < 2000
  ) %>%
  group_by(flight) %>%
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    cancelled = sum(is.na(arr_delay)),
    n = n()
  ) %>%
  filter(n > 10)


# Exercise 5.2.1:

## 1. The sample tables represent panel data which consist of a unique combination of a country and year, with associated values for the number of TB cases and population.
 ##Table 1:
  ### a. Observations (rows) represent countries and years of observed data, with associated values for the number of TB cases and population.
  ### b. Columns comprise countries and years of observation, the number of documented TB cases, the and population of the country.

 ##Table 2:
  ### a. Observations (rows) represent countries and years of observed data, with associated types of data (either 'cases' of TB or 'population of the country) and values for the number of TB cases and population.
  ### b. Columns comprise countries and years of observation, the number of documented TB cases, the and population of the country.

 ##Table 3:
  ### a. Observations (rows) represent countries and years of observed data, with rate of the TB case per population.
  ### b. Columns comprise countries and years of observation, the number of ate of the TB case per population.

## 2. Sketch out the process you’d use to calculate the rate for table2 and table3.
 ##Table 2:
  ### step 1: Extract rows where type == "cases" to get the number of cases for each country-year combination.
  ### step 2: Extract rows where type == "population" to get the population for each country-year combination.
  ### step 3: Join these two subsets by country and year.
  ### step 4: Calculate the rate by dividing cases by population, and multiply by 10,000.
  ### step 5: Store the calculated rate in a new column.

 ##Table 3:
  ### step 1: Seperate the 'rate' column into two new columns, where one is for cases and the other one is for population.
  ### step 2: Convert these new columns from string into numeric values.
  ### step 3: Calculate the rate by dividing cases by population, and multiply by 10,000.
  ### step 5: Store the calculated rate in a new column.


# Exercise 7.2.4

## 1 Function to read a file where fields were separated with "|": df <- read.delim("my_data.csv), sep = "|")

## 2 The common arguments include: 
  ### 'col_names' which is logical vector specifying column names,
  ### 'col_types' -> specifies column types,
  ### 'na' -> defines additional strings to interpret as missing values,
  ### 'trims_ws' -> whether to trim whitespace from character fields,
  ### n_max' -> maximum number of rows to read.

## 3 The most important arguments to 'read_fwf()'
  ### 'col_positions' which determines where columns begin and end in fixed-width files,
  ### 'skip' which determines number of lines to skip before reading data.

## 4 The argument 'quote':
  ### read_csv("x,y\n1,'a,b'", quote = "'")

## 5 Finding error:

read_csv("a,b\n1,2,3\n4,5,6") ### parsing issues. The table has 2 columns, but rows have three values.

read_csv("a,b,c\n1,2\n1,2,3,4") ### parsing issues. The table has 3 column, but subsequent rows have inconsistent numbers of values (2 and 4).

read_csv("a,b\n\"1") ### parsing issue with the quote " sign. There is one open quote sign in the code.

read_csv("a,b\n1,2\na,b") ### parsing issue. The third row redefines column 'a' and 'b' instead of providing data.

read_csv("a;b\n1;3") ### parsing issue with the delimiter, since the default delimiter for 'read_csv" argument is ','. we can solve the problem by using 'read_delim' argument.

## 6 Practice referring to non-syntactic names

  ### the data frame:
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

  ### extracting the variable called 1.
annoying$`1`

  ### Plotting a scatterplot of 1 vs. 2.
ggplot(annoying, aes(x = `1`, y = `2`)) +
  geom_point()

  ### Creating a new column called 3, which is 2 divided by 1.
annoying <- annoying |> 
  mutate(`3` = `2` / `1`)

  ### Renaming the columns to one, two, and three.
annoying <- annoying |> 
  rename(one = `1`, two = `2`, three = `3`)



