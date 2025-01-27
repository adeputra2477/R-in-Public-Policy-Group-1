library(palmerpenguins)
library(ggthemes)
library(tidyverse)

# Question 1.5.5.1

# For categorical varibles, we have manufacturer, model, trans, drv, fl, class. Also, we only have one numerical variable, which is displ
# I use sapply(mpg, class) function running mpg, which shows features of each variable in mpg 
?mpg
sapply(mpg, class)

# Question 1.5.5.2

# Below is the scatterplot of hwy vs displ
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point() +
    labs(title = "Highway MPG vs. Engine Displacement")

# Below is the scatterplot added with color
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(color = cyl)) +
    labs(title = "Color Mapped to cyl (Number of Cylinders)")

# Below is the scatterplot added with size
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(size = cyl)) +
    labs(title = "Size Mapped to cyl (Number of Cylinders)")

# Below is the scatterplot added with size + color
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(color = cyl, size = cyl)) +
    labs(title = "Color and Size Mapped to cyl")

# Below is the scatterplot added with shape
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(shape = cyl)) +
    labs(title = "Mapping cyl to both color and size")

# For size & color, since another variable cyl is numeric, shape & size & color can be applied. It shows continuous changes of the variable. However, the final plot, the shpae can't be applied since continuous variable can't be mapped to it.

# Question 1.5.5.3

# Below is the scatterplot where cty is mapped to linewidth
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_line(aes(linewidth = cty)) +
    labs(title = "Mapping cty to linewidth in line plot")

# At the graph, we can see changes of cty, city miles per galon, by displ.

# Question 1.5.5.4

# Below is the scatterplot where cty is mapped to multiple aesthetics
ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes(color = cty, size = cty, shape = factor(cty))) +
    labs(title = "Mapping cty to color, size, and shape")

# At the graph, each aesthetic represent the same variable's values in different ways.

# Question 1.5.5.5

# I recall the data by the command below.
glimpse(penguins)

# This is the scatterplot with species as color
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point() +
    labs(title = "Bill Depth vs. Bill Length Colored by Species",
         x = "Bill Length (mm)",
         y = "Bill Depth (mm)") +
    theme_minimal()

# The provided scatterplot visualizes the relationship between bill length (x-axis) and bill depth (y-axis) for three penguin species (Adelie, Chinstrap, and Gentoo)
# After coloring, we can vividly see species are clustering.

# This is the scatterplot faceted by species
ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
    geom_point(aes(color = species)) +
    facet_wrap(~species) +
    labs(title = "Bill Depth vs. Bill Length by Species",
         x = "Bill Length (mm)",
         y = "Bill Depth (mm)") +
    theme_minimal()

#The faceted visualization provides a clearer view of the distribution of bill lengths and depths for each species without interference from other groups.

# Question 1.5.5.6

# The code creates separate legends because each aesthetic is treated independently and the colored species line only midifies the color legend label. To combine the two legends into a single one, we should ensure both aesthetics share the same legend title. Below is the one example of modification.
ggplot(
    data = penguins,
    mapping = aes(
        x = bill_length_mm, y = bill_depth_mm, 
        color = species, shape = species
    )
) +
    geom_point() +
    labs(color = "Species", shape = "Species")