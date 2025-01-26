# 1.6.1 Exercises

## Q1 Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?

ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")

### Answer: The second plot, ggplot(mpg, aes(x = cty, y = hwy)) + geom_point()), will be saved as mpg-plot.png because the 'ggsave' function always saves the last active or most recently created plot.

## Q2 What do you need to change in the code above to save the plot as a PDF instead of a PNG? How could you find out what types of image files would work in ggsave()?

ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.pdf")

### so, the only thing that we need to do is replace the '.png' in the initial code and change it into '.pdf'.

