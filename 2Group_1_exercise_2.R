# 1. Why does this code not work?

my_variable <- 10
my_varıable

# answer: The sentence contains an 'i' that was mistakenly entered as 'ı'.

# 2. Tweak each of the following R commands so that they run correctly:

libary(todyverse)

# answer
library(tidyverse)

ggplot(dTA = mpg) + 
  geom_point(maping = aes(x = displ y = hwy)) +
  geom_smooth(method = "lm)
  
# answer  
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(method = "lm")
  
  
# 3. Press Option + Shift + K / Alt + Shift + K. What happens? How can you get to the same place using the menus?

# answer: we can check keyboard shortcut reference

# 4.Let’s revisit an exercise from the Section 1.6. Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?

my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "mpg-plot.png", plot = my_bar_plot)

# answer: The plot saved as mpg-plot.png is my_bar_plot. In the ggsave() function, the 'plot' argument explicitly specifies which plot to save.
