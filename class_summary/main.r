# Let’s say that you want to explore any correlations between 

# physical characteristics and species for Star Wars characters. 

options(repos = c(CRAN = "http://cran.rstudio.com"))
install.packages("ggplot2")
# Write statements to load the tidyverse and datasets packages.

library("tidyverse")    
library("ggplot2")
library("datasets")



# Create a tibble from the starwars data set and view it.

swchars <- as_tibble(starwars)

swchars



# Write a statement to inspect the structure of the tibble.

# Note that while the first 11 columns display as you would expect, 

# the lists contained in last 3 columns are displayed in their entirety. 

# You can prevent the contents of these lists from displaying by setting 

# the parameter max.level = 2 to limit the number of levels for nested lists.

swchars %>% str(strict.width = "cut", max.level = 2)



# Write a statement to check for duplicate rows. As it happens, you will see 

# that there aren’t any duplicates in this data set, but it’s good to confirm.

swchars %>% ggplot2(filter(duplicated(swchars)))



# Since the goal for this analysis uses physical characteristics, drop the 

# columns for birth_year, homeworld, films, vehicles, and starships.

# Then, view the tibble. n

swchars <- swchars %>% 

  select(-birth_year, -homeworld, -films, -vehicles, -starships)

swchars



# Rename the columns to use title case, then, view the tibble.

# To rename, use the rename_with() function with the str_to_title() function.

swchars <- swchars %>% rename_with(str_to_title)

swchars



# Rename the columns that contain underscores so they use title case without any underscores. 

# In other words, rename columns such as Eye_color to EyeColor. 

# To do that, use the rename() function. Then, view the tibble.

swchars <- swchars %>% rename(HairColor = Hair_color, SkinColor = Skin_color, EyeColor = Eye_color)

swchars
