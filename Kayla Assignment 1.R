# 1.2.5
# 6. What does the na.rm argument do in geom_point()? What is the default value of the argument? Create a scatterplot where you successfully use this argument set to TRUE.
# The na.rm argument determines whether missing values (NA) should be removed before plotting.
# The default value of the argument is FALSE, which means that missing values in the penguins dataset are not removed. Instead, a warning message is issued, and rows with missing values are ignored in the plot.
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) + geom_point(na.rm = TRUE)
# 7. Add the following caption to the plot you made in the previous exercise: “Data come from the palmerpenguins package.” Hint: Take a look at the documentation for labs().
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) + geom_point(na.rm = TRUE) + labs(caption = "Data come from the palmerpenguins package") 
# 8. Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to? And should it be mapped at the global level or at the geom level?
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) + geom_point(mapping = aes(color = bill_depth_mm)) + geom_smooth(method = "loess")
# The bill_depth_mm should be mapped to color.
# It should be mapped at the geom level, only for the point geom not for the smooth geom, because the points are colored but the smooth line is single color.
# 9. Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)) + geom_point() + geom_smooth(se = FALSE)
# We predict that the output will be a scatterplot of body_mass_g vs. flipper_length_mm with points in three different colors to represent penguins from different islands. And there are also three smooth lines for each island in different colors. The plot created by the code indeed match the prediction.
# 10. Will these two graphs look different? Why/why not?
ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) + geom_point() + geom_smooth()
ggplot() + geom_point(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) + geom_smooth(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g))
# These two graphs will look the same, because in the first plot the aesthetic mappings are at the global level and assigned to each geoms (point and smooth line), and in the second plot both geoms have the same aesthetic mappings at the local level.