# 2018-05-02

# Today we are going to go over some steps for how to create 
	# graphics using the ggplot2 package
# The package is based on the grammar of graphics, 
	# and attempts to set up attractive and easy defaults 
	# while still allowing flexibility to customize graphics
# Like plotting with base R, the more things you want to change 
	# the more code you will need to learn

# There is a ton of information on graphing with ggplot2 online

# In particular, for a lot of the basics see:
	# http://www.cookbook-r.com/Graphs/ 
# For examples and descriptions of every function available 
	# see the ggplot2 help page:
	# http://ggplot2.tidyverse.org/reference/
# Folks answer questions about ggplot2 pretty much 
	# every day online. See and search in:
	# http://stackoverflow.com/questions/tagged/ggplot2
# Active development of ggplot2 is done on its GitHub repository
	# This is where to report or check for bugs (under "Issues")
	# https://github.com/tidyverse/ggplot2
# See ggplot2 extensions in other packages
	# http://www.ggplot2-exts.org/gallery/

# In the first part of the workshop, we'll learn some of the basic syntax
	# by making some simple exploratory plots on a built-in dataset
# We won't spend time "prettifying" these plots

# In the second part of the workshop, we will switch our focus to creating graphics 
	# meant to display information that could be included
	# in a presentation or manuscript,
	# which will allow us to explore a small portion of the many
	# options available to customize plots

# First, load the package ggplot2 ----

# The current version of ggplot2 is 2.2.1
	# If you don't have the current version, 
		# you will need to install it prior to loading

# To install:
	# Either type install.packages("ggplot2") in your Console pane
	# Or in RStudio go to the Packages pane, 
		# click Install, type ggplot2 and press enter
	# Installation code should not be included as part of
		# your script, as you don't need to install every time
		# you use a package

# Once ggplot2 has been installed, load it via library()
library(ggplot2)

# Part 1 ----
# Basic graphics

# In the first part of the workshop we will be creating graphics
	# with a dataset already loaded in R, called "mtcars"

# The help page tells us a bit about the dataset
?mtcars

head(mtcars)
str(mtcars)

# We will be working with the continuous variables mpg, wt, and disp,
	# and categorical variables cyl and am 
		# R doesn't recognize these as categorical
 		# since they have numeric categories

# Plots with qplot() ----

# We are primarily going to be working with 
	# the function ggplot() directly
# There is a wrapper for ggplot() to make easy exploratory graphics
	# called qplot() - the "q" stands for "quick"

# Using qplot() can be convenient for quick exploratory graphics
	# but becomes less convenient when making a more complex graphic
# Today we will start with a couple examples using qplot()
	# and then we are going to jump
	# to using ggplot() directly

# Let's start with a basic scatterplot with qplot()
# A scatterplot is the default plot type in qplot()
qplot(x = wt, y = mpg, data = mtcars)
# A few things to notice here:
    # We refer to the dataset we are working with the data argument;
        # that's a key part of the ggplot2 package
    # We define the variables in the dataset
        # that represent the x and y positions
	# The default background in ggplot2 is grey with white grid lines
	
	
# If we want a different kind of plot,
    # like a boxplot of mpg for each cylinder type 
	# instead of the default scatterplot, 
	# we ask for it using the "geom" argument
# The x axis for boxplots is categorical,
    # and we can't forget to define the "cyl" variable 
	# as categorical using factor()
qplot(x = factor(cyl), y = mpg, data = mtcars, geom = "boxplot")
	# The different "geoms" are how we get different kinds of plots in ggplot2 
		# such as points, lines, histograms, etc.

# Using ggplot() directly ----

# We'll start by making the same two graphics that we just made with qplot()
	# to get an initial feel for how ggplot() works
# We'll be defining the dataset and axis variables in ggplot()

# We get a blank plot if we just define
	# the dataset and axes with no other layers
ggplot(data = mtcars, aes(x = wt, y = mpg) )

# We add the desired geoms as "layers" using
	# the plus sign
# It looks like this:
ggplot(data = mtcars, aes(x = wt, y = mpg) ) +
	geom_point()
# The x and y position are defined within aes()
	# "aes" stands for "aesthetics"
	# which we will be talking a lot more about today
# The plus sign is how we add more layers to the plot
# You can put this all on one line 
	# but it's standard to organize ggplot code by putting layers 
   	# on new lines with indentations for readability

# Now the boxplots
ggplot(data = mtcars, aes(x = factor(cyl), y = mpg) ) +
	geom_boxplot()

# So that doesn't seem that hard

# Mapping aesthetics ----
# Let's start making things a little more complex by adding
	# more variables to the graphic as *aesthetics*
# "aesthetics" are not only the x and y position, 
	# but also things like color, fill, and shapes or other
	# attributes that affect the way observations are displayed
# While ggplot2 doesn't support 3D, 
	# using additional variables as aesthetics
	# is one way to display more than two dimensions
# Assigning a variable to an aesthetic is often
	# referred to as "aesthetic mapping"
# Aesthetic mapping *always* happens inside aes()

# Let's color the points in our scatterplot 
	# by the number of cylinders
# I'm going to stop writing out the data argument in ggplot()
	# because it is always the first argument in the ggplot() function
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl) ) ) +
	geom_point()
# One convenience in ggplot2 is that we get legends automatically
	# when we map variables to aesthetics

# Today we'll mostly work with aesthetics with categorical variables,
	# but you can certainly use some aesthetics with continuous variables
		# (this is what you do to make heat maps or bubble plots)
# For example, we can map the "size" aesthetic to the
	# continuous variable engine displacement ("disp") 
   	# to get a bubble scatterplot
ggplot(mtcars, aes(x = wt, y = mpg, size = disp) ) +
	geom_point()

# Adding more layers ----
# We can put more layers on a graphic by simply adding more geoms
	# Let's add points on top of the boxplots, 
	# Mapping colors to be different for the different cylinder categories
ggplot(mtcars, aes(x = factor(cyl), y = mpg, color = factor(cyl) ) ) +
	geom_boxplot() +
	geom_point()

# Both the boxplots and the points get colored by "cyl"
    # because we mapped color the "cyl" *globally*
    # by putting it in the ggplot() layer
# *Global* settings effect all layers

# The "color" aesthetic on boxplots and histograms and such
	# will color only the outlines
# The "fill" aesthetic is for changing the color of the inside 
	# of the boxplots/bars etc.

# Setting aesthetics to constants ----
# We can add arguments to individual geoms, not just inside ggplot()
# Let's modify the last plot by coloring the points purple 
# We will still map number of cylinders to boxplot color

# Adding the color argument to geom_point() overrides
	# the original aesthetic mapping for that layer
ggplot(mtcars, aes(x = factor(cyl), y = mpg, color = factor(cyl) ) ) +
	geom_boxplot() +
	geom_point(color = "purple")

# Notice the color argument in `geom_point` is *not* inside aes(),
	# and the points do not appear in the legend
# This is because we set the point color to a constant rather
    # than mapping the point color to a variable

# Understanding when to include an aesthetic in aes()
	# and when not to can be confusing when you first start with ggplot2
# Generally, if you are *mapping* an aesthetic to a variable 
	# do it within aes()
# If you are *setting* an aesthetic to a constant, do it outside of aes()
# You only get automatic legends when mapping inside aes()

# Mapping multiple aesthetics in geoms ----
# We can map aesthetics to variables separately for each geom
	# rather than setting them globally in ggplot()
# For example, maybe we want to map the fill color of the boxplots 
	# as number of cylinders
	# but color the points by the transmission type
# Note the use of aes() within the layers as well as ggplot()
    # x and y are mapped globally for all layers
    # but fill is mapped only for the boxplots and
    # color only for the points
ggplot(mtcars, aes(x = factor(cyl), y = mpg) ) +
	geom_boxplot( aes(fill = factor(cyl) ) ) +
	geom_point( aes(color = factor(am) ) )
# When we map more aesthetics to variables, we add more legends

# Edit the dataset to change the graphic ----
# This is a good time to discuss how the dataset and the graphic 
	# go hand-in-hand in the ggplot2 framework
# Notice the labels for "am" in the legend are not useful and
	# we've been writing out factor() every time we use
	# these categorical variables
	# because they are quantitative in the dataset

# We can control these things by changing the dataset
# If we make these changes in the dataset from the start
	# we also avoid later work making changes to the legends and such
# There are many, many times that the question of 
	# "How do I change xxx in ggplot2?"
	# has the answer "Preprocess your dataset."

# Let's make these changes now
mtcars$numcyl = factor(mtcars$cyl)
mtcars$am = factor(mtcars$am, labels = c("Auto", "Manual") )

str(mtcars)

# Now we can recreate the graphic using our new variables
ggplot(mtcars, aes(x = numcyl, y = mpg) ) +
	geom_boxplot( aes(fill = numcyl) ) +
	geom_point( aes(color = am) )

# Changing the colors for the fill and color in graphics ----

# We won't be working with colors in the second part of the workshop
	# so I wanted to take a minute to show how to change fill/color values
# This involves using the appropriate "scale" function, 
	# in this case for fill or color,
	# and changing the values for the colors
# See http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/ for
	# some good information about colors and some useful color palettes

# When we change the colors using scale_() functions, 
	# both the graphic and legend will change
# We will define new color or fill using the "values" argument
# New values are assigned in the order of the levels of the mapping variable
    # So in this example the cyl order is 4, 6, 8
    # and the am order is Auto, Manual
	
# See the "limits" argument for more info on 
	# changing the order of the factor levels 
    # and how the legend is displayed

# You can assign new colors by name or by hexadecimal values
ggplot(mtcars, aes(x = numcyl, y = mpg) ) +
	geom_boxplot( aes(fill = numcyl) ) +
	geom_point( aes(color = am) ) +
	scale_fill_manual(values = c("light green", "sky blue", "pink") ) +
	scale_color_manual(values = c("#009E73", "#E69F00") )
	
	# Note that if you only map a variable to fill and you use
		# scale_color_manual(), nothing will happen
	# The lesson here is to use the correct scale for each aesthetic

# Dot plot ----
# Instead of using the points geom for a categorical x variabale
	# we could use a dotplot geom
# Dot plots are more or less
	# a kind of histogram made out of dots
# This allows us to see all the points at once 
	# if they have the same/close-to-the-same value, 
	# as points with the same value are plotted next to each other 
	# instead of on top of each other
# Here is a dot plot along the y axis,
	# which is like making a histogram turned on its side
# We will set the dot fill color to purple
	# so we set the aesthetic to a constant outside of aes()
ggplot(mtcars, aes(x = numcyl, y = mpg) ) +
	geom_boxplot( aes(color = numcyl) ) +
	geom_dotplot(fill = "purple", binaxis = "y")

# Histograms and density plots ----
# And speaking of histograms, 
	# we haven't made a histogram or density plot yet
# These are common exploratory graphics
# With histogram/density plots you
	# only set a continuous variable for the x axis 
	# as the y axis is counts or densities that ggplot2 
	# calculates from the dataset for you
ggplot(mtcars, aes(x = mpg) ) +
	geom_histogram()

ggplot(mtcars, aes(x = mpg) ) +
	geom_density()

# How about a histogram with a density overlay?
ggplot(mtcars, aes(x = mpg) ) +
	geom_histogram() + 
	geom_density()
# That doesn't look right because the histogram is on the count scale
	# and the density is on the density scale 

# We can change this by setting the y axis 
	# to one of the special variables 
	# these geoms create, called ..count.. and ..density..
# Here is the density on the count scale
	# We are mapping ..count.. to the y axis, 
	# so we do this within aes() for the density geom
ggplot(mtcars, aes(x = mpg) ) +
	geom_histogram() + 
	geom_density( aes(y = ..count..) )

# Map fill color to transmission type globally,
    # which fills both the histogram and the density overlay
ggplot(mtcars, aes(x = mpg, fill = am) ) +
	geom_histogram() + 
	geom_density( aes(y = ..count..) )

# Notice that layer order can matter
ggplot(mtcars, aes(x = mpg, fill = am) ) +
	geom_density( aes(y = ..count..) ) +
	geom_histogram()

# This graphic might be more useful if we make the 
	# fill color of the density curves more transparent
	# by setting "alpha" to less than 1 (can be between 0-transparent to 1-opaque)
# alpha is an aesthetic; here we set alpha to a constant, so it is done outside of aes()
ggplot(mtcars, aes(x = mpg, fill = am) ) +
	geom_histogram() + 
	geom_density( aes(y = ..count..), alpha = .5)

# Bar graphs ---

# Bar graphs are closely related to histograms, but involve
	# counts of categorical variables so will
	# always have a discrete x axis instead of a continuous x axis
ggplot(mtcars, aes(x = numcyl) ) +
	geom_bar()

# If you want to make a bar graph using a variable
	# from a dataset instead of counts see geom_col()

# There are a just a few more basics to cover before
	# moving away from basic exploratory graphics 
	# into creating higher-quality graphics

# Facets ----
# Now we'll explore what is called "faceting" in ggplot2, 
	# where instead of mapping aesthetics to variables 
	# we graph different levels of a categorical variable 
    # in separate plots/panels 

# We'll make separate scatterplots for each 
	# level of number of cylinders
# Here I'm showing you faceting with facet_wrap()
	# There is another function called facet_grid() 
	# that is another option for faceting
# Both of these functions have many options that we will
	# barely touch on today
ggplot(mtcars, aes(x = wt, y = mpg) ) +
	geom_point() +
	facet_wrap(~numcyl)

# Notice that each facet has the same x and y limits by default
# We can allow either (or both) of these to differ for each facet
	# by using the "scales" argument with "free", "free_y" or "free_x
ggplot(mtcars, aes(x = wt, y = mpg) ) +
	geom_point() +
	facet_wrap(~numcyl, scales = "free_x")

# Adding layers of summary statistics ----
# ggplot2 also has some built-in functions that allow
	# us to add basic summary stats to a graphic

# For example, we can add the mean weight as red squares
	# on top of the boxplot/dotplot graphic using stat_summary()
# To make a mean of our "y" variable, we use the "fun.y" argument
ggplot(mtcars, aes(x = numcyl, y = mpg) ) +
	geom_boxplot( aes(color = numcyl) ) +
	geom_dotplot(fill = "purple", binaxis = "y") +
	stat_summary(fun.y = mean, geom = "point", size = 5, 
			   shape = 22, fill = "red")
# We also set three aesthetics to constants, size, shape, and fill
	# I used shape = 22, which is a square
	# The cookbook for R lists some of the basic shapes for us,
		# http://www.cookbook-r.com/Graphs/Shapes_and_line_types/

# I don't have a good algorithm for
	# changing point sizes as above; it takes 
	# trial and error for me most of the time

# Regression lines ----
# We can add regression lines and confidence envelopes
	# to graphics using geom_smooth() or stat_smooth()
	# The default line type is a smoothed loess line, so we have to set
	# the method here to lm for linear regression lines
	# We also get confidence intervals by default, which may
		# or may not be appropriate
ggplot(mtcars, aes(x = wt, y = mpg) ) +
	geom_point() + 
	geom_smooth(method = "lm")

# We can fit a regression line separately by group by 
	# adding aesthetic mapping
# We can get rid of confidence envelopes by using se = FALSE
	# as confidence envelopes aren't really appropriate 
	# during exploratory work
ggplot(mtcars, aes(x = wt, y = mpg, color = numcyl) ) +
	geom_point() + 
	geom_smooth(method = "lm", se = FALSE)


# Part 2 ----
# Polishing graphics

# Let's change gears now
	# and start thinking about polishing our graphics 
	# to make a final product with ggplot2
# A high-quality graphic takes much more time that exploratory graphics, 
	# as you will spend time fine-tuning the appearance of the graphic
	# for inclusion in, e.g., a manuscript or presentation

# For the first (of 2) high quality graphic, 
	# we'll be working with a dataset called 
	# "egg length and width by species.csv"
	
# Make sure this dataset is in your working directory, and read it into R

eggs = read.csv("egg length and width by species.csv")
head(eggs)
# Take a look at the structure of "eggs" in the Environment pane

# These data were analyzed using two two-sample t-tests 
	# on length and width between species
# Making graphics of the results of two-sample t-tests is rarely
	# useful, so we'll make a graphic displaying the observed data
# See the final graphic I provided called "Workshop final graphic 1.pdf"
	# This is what we are working towards

# You can see we want to make a graphic that shows the 
	# data for egg lengths and egg widths
	# by species in separate panels
	# This should make you think about faceting
# However, the dataset isn't set up correctly for this, 
	# as length and width are currently in two separate columns;
	# i.e., there isn't a variable to facet on
# How will we make the graphic we want?
# This is a question that comes up a lot on the ggplot2 help forums
	# and the answer is pretty much always the same
# We need to reshape the dataset to take 
	# full advantage of ggplot2

# In this case, we have a wide dataset and want a long dataset
	# which is easy to change with gather() in package tidyr
	# or melt() from package reshape2
# This will create a column of measurement type with two levels,
	# length and width,
	# and a column with the quantitative measurements

# Load package tidyr first
library(tidyr)

# I am not going to talk about this code much, as it has more
	# to do with data manipulation than graphing
# The main point is that we want two columns combined into one column,
# We define the name of the new grouping column using "key",
	# and the name of the new quantitative column using "value"
# Then we simply type the names of the columns we want to combine

# This type of reshaping involves taking data in a *wide* format
	# and putting it into a *long* format
eggs2 = gather(eggs, key = type, value = measurement,
			length, width, factor_key = TRUE)
head(eggs2)
# Take a look at the structure in the Environment pane

# I'm going to change the style of how I present 
	# the creation of these graphics 
	# so you can see what happens to the graphic
	# as we add each new layer
# I will name the initial graphic "g1", which will only have
	# the x and y axes defined and a boxplot geom
# I will then add layers to "g1", 
	# renaming it as I go until we hit the final graphic

# You will see this coding style in some of the help documents,
	# although I use it only for teaching purposes
# At the end, we will put all the code together so you can
	# see what it looks like all together rather than one line at a time

# Here are the initial boxplots
# The extra pair of parantheses prints the graphic to the plotting window
( g1 = ggplot(eggs2, aes(x = species, y = measurement) ) +
 	geom_boxplot() )

# We want a separate panel for each type of measurement 
	# (width and length), so let's add faceting
g1 + facet_wrap(~type)

# Not suprisingly, width and length measurements 
	# cover a different range of values
# Let's allow the scale of the y axis to be 
	# different for each panel
	# so the distributions of the two different variables is clearer
( g1 = g1 + facet_wrap(~type, scales = "free_y") )

# I really want to give a good picture of what these data look like, 
	# which means I want to show the actual data points in the plot
# I'm going to add the raw data values as a dot plot
g1 + geom_dotplot(binaxis = "y", stackdir = "center")

# I think the black color for the dots is too dark
	# so we'll change the dots to some shade of grey
# Color choice usually takes a certain amount of trial and error
# I don't show you all the different
	# colors I tried before finding one I liked
	# but I mostly worked with a series of greys (grey24-grey74)
( g1 = g1 + geom_dotplot(binaxis = "y", stackdir = "center", 
				    color = "grey64", fill = "grey64") )

# Now I'll add the mean measurement of each group as a diamond, 
	# but in a darker color grey
( g1 = g1 + stat_summary(fun.y = mean, geom = "point", 
				    shape = 18, size = 5, color = "grey24") )

# So far this is all a review things we've already done today
# Let's start working on the appearance of the graph a little bit more
# When we change the overall appearance, 
	# such as the color of the panel background
	# or the gridlines, we are changing what ggplot2 calls "themes"

# First, for printing we would not generally want a grey background, 
    # although it is nice for presentations that have colors
# We can change the background manually, 
	# but there are a few pre-built themes in ggplot2
	# that I often start with
# The one I use the most is called theme black and white (theme_bw)
# You might be interested in theme_minimal() or theme_classic(), as well
( g1 = g1 + theme_bw() )

# There are many themes out there, including a whole
    # package called ggthemes

# I think the gridlines on the y axis are visually useful for boxplots,
	# but the gridlines along the x axis seem like overkill
# Let's remove the x axis gridlines
# This is the kind of thing we can change within theme()
# The help page for theme() lists all the things we can change
?theme 

# The gridlines we want to remove are the "major" gridlines
# To remove items in theme() involves setting items to element_blank()
g1 + theme(panel.grid.major.x = element_blank() )

# Changing the appearance of the facet strips
	# is also done within theme(),
	# including changing the background color and
	# changing the appearance and position of the strip text
# Here we remove the background color of the strips all together
	# and move the text to the far left of the strip and
	# change the text size through element_text()
# See the help page for element_text() for more info
( g1 = g1 + theme(panel.grid.major.x = element_blank(),
                  strip.background = element_blank(),
                  strip.text = element_text(hjust = 0,
                                            face = "bold", size = 12) ) )

# At this point I realized I had made an error
# While I can change a lot of things about the appearance of 
	# the facet labels (such as size, font, etc.),
	# simple changes to the label names require
	# a certain amount of effort using the "labeller" argument

# I should have changed the names in the original dataset 
# One of the reason I didn't need to change the tick labels
	# on the x axis is because I had edited 
	# the species names in the original dataset to make them look nicer

# Changing the names in the dataset is easy
levels(eggs2$type)
# We can change the names by assigning new levels
levels(eggs2$type) = c("Egg length", "Egg width")
levels(eggs2$type)

# So do we have to go back and restart the whole graphic?
# Sure, we could, and it wouldn't actually take that much effort,
	# especially outside of a workshop 
	# where we aren't going through this one layer at a time
# However, we can take advantage of the function %+% for this,
	# which updates the data.frame used to make the graphic

# This is especially handy if you want to make a series of graphics
	# that all look the same but are created with a different datasets
# Here we'll recreate the dataset so far using the newly-edited "eggs2"
( g1 = g1 %+% eggs2 )

# The label on the x axis seems redundant, so I'm going to remove it
	# by setting it to NULL
# Let's capitalize and add units to the y axis, as well
( g1 = g1 + labs(x = NULL,
                 y = "Measurement (mm)") )

# This could have been where I stopped, but to make a really complete final graphic
	# I decided I wanted to add some summary stats directly to the graphic
# I will put the mean and standard deviation for each group 
	# as text in each pane
# I like graphics that combine text information with graphics
	# and I wanted to give an example of how to think through this
	# as well as the kind of effort this will take in terms of coding

# The first step I need to do is to calculate the summary stats by group
# I do this with group_by() and summarise() from the dplyr package, 
	# naming the data.frame "sumdat"
library(dplyr)

# Don't forget to round to a reasonable number of digits
( sumdat = eggs2 %>% 
 	group_by(type, species) %>%
 	summarise(Mean = round(mean(measurement), 1),
 	          SD = round(sd(measurement), 1) ) )

# As you can see in the final plot, 
	# I decided to add text under each boxplot
# This means the x position of the text will still
	# be defined by "species" and the facets by "type",
	# but I need a reasonable value to define the position
	# of the text along the y-axis
# I decided on the minimum value of each facet minus .5,
	# which took some trial and error on my part
# The main advice I have when trying to do this
	# is to think about the range of the axis as your starting point
	# and don't be afraid of trying a few things - 
	# you can always change the plot back
# Here I calculate the y position for each facet by "type"
	# using dplyr functions again
( loc = eggs2 %>% 
 	group_by(type) %>%
 	summarise(yloc = min(measurement) - .5) )

# To get the y position variable "yloc" into the summary dataset
	# we can simply use inner_join() from dplyr
( sumdat = inner_join(sumdat, loc) )

# Let's create the labels to add to the graph
# I wanted the mean and sd on separate lines (one on top of another)
	# "\n" indicates a line break in R, so I add that in the paste0() function
	# along with everying else I want in the labels (values and units)
# The paste0() function pastes values together with no separator

# This is done using mutate(), also from dplyr
sumdat = mutate(sumdat, 
			  label = paste0("Mean = ", Mean, " mm", "\n", "SD = ", SD," mm") )

# The resulting column looks like this
sumdat$label

# This is the first time we will be working with a different dataset
	# for a geom layer (in this case, geom_text() )
# We just define the new dataset 
	# using the "data" argument within the geom
# Unlike in the ggplot() function, we need to write out "data ="
	# in a geom when defining the dataset

# Adding a dataset to a geom will override 
	# the overall dataset for this layer only -
	# it does not affect any other previous or subsequent layers
# We'll need to define the y position for the text in aes()
	# because it's different than the rest of the graphic
# geom_text() requires us to set the labels argument within aes(),
	# as well.  The help pages always indicate if
	# there is a required aesthetic
g1 + geom_text(data = sumdat, aes(label = label, y = yloc) )

# That doesn't work very well to start, 
	# but after adjusting the lineheight, 
	# vertical justification, and text size
	# things are looking a little better in the current plotting window
( g1 = g1 + geom_text(data = sumdat, aes(label = label, y = yloc),
                      lineheight = .9, vjust = .3, size = 4) )

# This is what I used as my final graphic,
	# and this is what the code looks like all together
# Notice we can still name the graphic object
( g1 = ggplot(eggs2, aes(x = species, y = measurement) ) +
		geom_boxplot() +
		facet_wrap(~type, scales = "free_y") +
		geom_dotplot(binaxis = "y", stackdir = "center",
		             color = "grey64", fill = "grey64") +
		stat_summary(fun.y = mean, geom = "point", shape = 18,
		             size = 5, color = "grey24") +
		theme_bw() +
		theme(panel.grid.major.x = element_blank(),
		      strip.background = element_blank(),
		      strip.text = element_text(hjust = 0, face = "bold", size = 12) ) +
		labs(x = NULL,
		     y = "Measurement (mm)") +
		geom_text(data = sumdat, aes(label = label, y = yloc),
		          lineheight = .9, vjust = .3, size = 4) )

# I can use ggsave to save this graphic
# By default, the last graphic plotted is saved
# I can also save a graphic by name, which I'll also show you

# Finding the ideal size of the graphic 
	# takes some trial and error for me,
	# although some manuscripts require very specific sizes, 
	# which would make this easier

# The default plot from ggsave will look 
	# like what is in the plotting window in RStudio
	# so if you save things to a different size 
	# you might find you don't like how things look
# You cannot set the size of the plotting window in 
    # RStudio at this time

# One option is to use the RStudio Export drop down menu 
	# and preview different sizes
# Otherwise you can save a plot and take a look at it
# Here are some examples of ggsave() with some different arguments
ggsave("final plot 1.pdf", width = 7, height = 7) # setting width and height (default inches)
ggsave("final plot 1.png", plot = g1) # using default size

# At this point I decided I didn't like the size of the dots
	# and I thought the tick labels on the x-axis should be bigger
# I edited the plot code with a new dotsize for that geom
	# and changed the axis tick labels in theme() using
	# axis.text.x with element_text()
( g1 = ggplot(eggs2, aes(x = species, y = measurement) ) +
		geom_boxplot() +
		facet_wrap(~type, scales = "free_y") +
		geom_dotplot(binaxis = "y", stackdir = "center",
		             color = "grey64", fill = "grey64", dotsize = .5) +
		stat_summary(fun.y = mean, geom = "point", shape = 18,
		             size = 5, color = "grey24") +
		theme_bw() +
		theme(panel.grid.major.x = element_blank(),
		      strip.background = element_blank(),
		      strip.text = element_text(hjust = 0, face = "bold", size = 12),
		      axis.text.x = element_text(size = 12) ) +
        labs(x = NULL,
             y = "Measurement (mm)") +
		geom_text(data = sumdat, aes(label = label, y = yloc),
		          lineheight = .9, vjust = .3, size = 4) )

# Notice you can change the dpi for png, jpeg, etc.
# The final size is 9 by 8 inches
ggsave("final plot 1.pdf", plot = g1, width = 9, height = 8)
ggsave("final plot 1.png", dpi = 600, width = 9, height = 8)


# We have one final graphic to make ----

# Plotting results from comparisons of all groups with the control

# For this graphic, I saved the results of the
	# estimated differences in means and CI around those differences
	# for 5 groups vs the control group 
	# from a two-factor linear model

# Let's read those results in
res = read.csv("all vs control results.csv")
res
# Take a look at the structure

# I added two columns to this dataset before I saved this so I knew
	# which comparison (combination of two factors vs control) each row represented
# The control had a plantdate of Jan2 with bare root stock

# The default factor levels in R are alphanumeric, 
	# so Feb25 is listed first
# We'll want plantdate in order by date in my graphic,
	# so let's relevel the factor 
# We'll make the labels look a little nicer while we're at it
res$plantdate = factor(res$plantdate, 
				   levels = c("Jan2", "Jan28", "Feb25"),
				   labels = c("January 2", "January 28", "February 25") )

# Take a look at the plot we are working towards,
	# called "Workshop final graphic 2"
# This is a fairly complex example because 
	# there is only one stocktype for Jan2 but two for the other dates
# Much of the time you will be in a simpler situation, 
	# which means you will have less tweaks to do

# Let's start by plotting the estimated differences in means as points
# I will name this graphic "g2"
	# and proceed in the same way as with "g1"

( g2 = ggplot(res, aes(x = plantdate, y = Diffmeans) ) +
        geom_point() )

# Now we can add error bars to represent 
	# the confidence intervals using geom_errorbar()
# We are required to provide the "ends" of the error bars
	# in geom_errorbar by providing "ymax" and "ymin" positions in aes()
# This is easy to do because we have 
	# the upper and lower limits of the CI in the dataset
( g2 = ggplot(res, aes(x = plantdate, y = Diffmeans) ) +
        geom_point() +
        geom_errorbar( aes(ymin = Lower.CI, ymax = Upper.CI) ) )

# That's not exactly what we want because 
	# the two stock types at one date are on top of each other

# We'll want to "dodge" whenever a geom overlaps in x space 
	# using the position argument with position_dodge()
# To do this, we have to define stocktype as the overlapping "group"
	# and decide how much to dodge the points 
	# (this may take some trial and error, although .75 or  .9 are common)
# We can only dodge horizontally, and we can set the width of the dodge
    # (how much space between groups)
( g2 = ggplot(res, aes(x = plantdate, y = Diffmeans, group = stocktype) ) +
 	geom_point(position = position_dodge(width = .75) ) +
 	geom_errorbar( aes(ymin = Lower.CI, ymax = Upper.CI),
 	               position = position_dodge(width = .75) ) )

# That's better, but still not very pretty
# There is a problem with the width of the error bars
# This is where the single result on Jan 2 complicates things, 
# There is only 1 group level instead of 2,
	# which causes the width of the error bar 
	# to be twice as wide as the others
# I can set widths in geom_errobar outside the aes() 
	# by defining widths for each comparison, 
	# with the first set as half the width of others
# In a simpler situation I would set a single width for every error bar
( g2 = ggplot(res, aes(x = plantdate, y = Diffmeans, group = stocktype) ) +
 	geom_point(position = position_dodge(width = .75) ) +
 	geom_errorbar( aes(ymin = Lower.CI, ymax = Upper.CI),
 	               position = position_dodge(width = .75),
 	               width = c(.2, .4, .4, .4, .4) ) )

# That looks much better
# But look what happens when we try set the geom_errorbar aesthetic 
	# linetype to "stocktype"
# (I believe this has been fixed in the development version
    # of ggplot2, so versions after 2.2.1
    # can likely avoid this step)
( g2 = ggplot(res, aes(x = plantdate, y = Diffmeans, group = stocktype) ) +
        geom_point(position = position_dodge(width = .75) ) +
        geom_errorbar( aes(ymin = Lower.CI, ymax = Upper.CI,
                           linetype = stocktype),
                       position = position_dodge(width = .75),
                       width = c(.2, .4, .4, .4, .4) ) )

# The error message is somewhat useful here, 
	# because it tells me that something is wrong with the aesthetics
	# and in particular with width
# We are in the quite unusual situation where 
	# we actually need to set the widths inside aes()
	# instead of outside 
( g2 = ggplot(res, aes(x = plantdate, y = Diffmeans, group = stocktype) ) +
        geom_point(position = position_dodge(width = .75) ) +
        geom_errorbar( aes(ymin = Lower.CI, ymax = Upper.CI,
                           linetype = stocktype,
                           width = c(.2, .4, .4, .4, .4) ),
                       position = position_dodge(width = .75) ) )

# Now we have the initial graphic to build on
	# so let's do some work on the panel and axis appearance
# First, let's change the theme to theme_bw
	# and make the axis labels look nicer
( g2 = g2 + theme_bw() + 
		labs(x = "Planting Date",
		     y = "Difference in Growth (cm)") )

# It can be informative to show the area that indicates
	# a practically unimportant difference
# Any difference in mean growth over/under +/-.25 cm 
	# when compared to the control is practically important to growers

# We could draw horizontal lines at +/- .25 using geom_hline()
# Instead we're going to draw a see-through grey rectangle 
	# over the area between -.25 and .25 
	# to indicate the "Zone of no difference"
# In geom_rect() we are required to define 
	# the boundaries of the rectangle with xmax, xmin, ymax, ymin
# We'll use Inf/-Inf for the x axis to make the rectange
    # all the way across the plot
( g2 = g2 + geom_rect(xmin = -Inf, xmax = Inf, ymin = -.25, ymax = .25,
                      fill = "grey54", alpha = .05) )

# If .25 is a practical difference, we may want more
	# "breaks" or tick marks on the y axis so we can see the .25 clearly
# We do this with the appropriate scale function, scale_y_continuous
# If we were changing the x axis we would use scale_x_discrete
	# because x is a categorical variable in this plot
( g2 = g2 + scale_y_continuous(breaks = seq(-1.5, .5, by = .25) ) )

# I could have built this entire graphic with planting date on the y axis
	# and growth on the x axis in 
	# conjunction with geom_errorbarh() (horizontal error bars)
	# but I wanted to show you how coord_flip works
# Let's flip the axes here
( g2 = g2 + coord_flip() )

# Now I can do some of the final appearance changes

# I don't like the default dotted linetype 
	# and the names of the stock categories should be clearer
# We can change how aesthetics appear on the graphic 
	# through the "scale" functions
# Essentially every aesthetic has a scale function 
	# (we used fill and color scales earlier)
# In this case, we'll use scale_linetype_manual() 
	# to change the linetypes
	# and linetype names as they appear in the legend
# It doesn't seem like we need the legend title
# We can suppress the title (or rename it) 
	# in scale_linetype_manual(), as well

g2 + scale_linetype_manual(values = c("solid", "twodash"),
                           name = element_blank(),
                           labels = c("Bare root", "Container") )

# It would also be nice to have the lines in the legend
	# match the order they appear in the graph (dashed first)
# We can do that by reversing the order with the guide argument
	# and guide_legend() function
# There are a ton of things we can control in guide_legend(), much like with theme()
( g2 = g2 + scale_linetype_manual(values = c("solid", "twodash"),
                                  name = element_blank(),
                                  labels = c("Bare root", "Container"),
                                  guide = guide_legend(reverse = TRUE) ) )

# We have plenty of space to put the legend within the graphic
# This is something we can adjust in theme()
# Consider adding tables of summary stats 
	# in a graphic with this much white space
	# which you could with ggplot2 combined with package gridExtra

# I also want the legend laid out horizontally instead of vertically
# The legend position coordinates are essentially 
	# between 0 and 1 in both x and y 
	# within the plotting area
# This is yet another time where you might need trial and error to get 
	# a perfect placement
# While we're using theme, let's get rid of all the gridlines
	# although we might consider leaving the ones on the (current) x axis (y axis before flipping)
( g2 = g2 + theme(legend.position = c(.2, .1),
                  legend.direction = "horizontal",
                  panel.grid = element_blank() ) )

# Last, let's add a label to indicate that the grey rectangle 
	# is the "zone of no difference"
# annotate() is the function to use when adding a single label like this 
	# instead of geom_text() to add many labels from a dataset
# Placement is a hard decision here
	# I decided to put it near the bottom of the rectangle on the left
# Remember that we flipped the coordinates, so x is y and y is x!
( g2 = g2 + annotate(geom = "text", x = .5, y = 0,
                     label = "Zone of no difference", size = 3) )

# Here's what the ggplot code looks like if we built it all together
( g2 = ggplot(res, aes(x = plantdate, y = Diffmeans, group = stocktype) ) +
        geom_point(position = position_dodge(width = .75) ) +
		geom_errorbar( aes(ymax = Upper.CI, ymin = Lower.CI,
		                   linetype = stocktype,
		                   width = c(.2, .4, .4, .4, .4) ),
		               position = position_dodge(width = .75) ) +
		theme_bw() +
        labs(x = "Planting Date",
             y = "Difference in Growth (cm)") +
		geom_rect(xmin = -Inf, xmax = Inf, ymin = -.25, ymax = .25,
		          fill = "grey54", alpha = .05) +
		scale_y_continuous(breaks = seq(-1.5, .5, by = .25) ) +
		coord_flip() +
		scale_linetype_manual(values = c("solid", "twodash"),
		                      name = element_blank(),
		                      labels = c("Bare root", "Container"),
		                      guide = guide_legend(reverse = TRUE) ) +
		theme(legend.position = c(.2, .1),
		      legend.direction = "horizontal",
		      panel.grid = element_blank() ) +
		annotate(geom = "text", x = .5, y = 0,
		         label = "Zone of no difference", size = 3) )

# This now matches the final graphic, and we could save it as before
ggsave("final plot 2.pdf", width = 8, height = 7)

# end of workshop ----







ggsave("Workshop final graphic 1.pdf", width = 9, height = 8, plot = g1)
ggsave("Workshop final graphic 2.pdf", width = 8, height = 7, plot = g2)

ggsave("Workshop_final_graphic_1.png", width = 9, height = 8, plot = g1, dpi = 600)
