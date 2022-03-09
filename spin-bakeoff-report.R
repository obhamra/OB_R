#' This is a special R script which can be used to generate a report. You can
#' write normal text in roxygen comments which are a hash with '
#'


library(tidyverse)
library(here)
library(glue)

#' Import data

filepath <- glue::glue("data/ratings-{params$series}.csv")
ratings <- read_csv(here::here(filepath)) %>% 
  mutate(episode = as.factor(episode))

#' Type hash and ' then enter
#' And it repeats
#' Doesn't do this with normal #
#' 
#' 
#' Manipulate data
viewers <- ratings %>% 
  select(series:viewers_28day) %>% 
  pivot_longer(starts_with("viewers"), 
    names_to = "days", 
    names_prefix = "viewers_", 
    values_to = "viewers"
  ) 

#' Plot
ggplot(viewers, aes(episode, 
                    viewers, 
                    colour = days, 
                    group = days)) + 
  geom_point() + 
  geom_line() + 
  labs(
    x = "Episode", 
    y = "Viewers (millions)"
  ) +
  expand_limits(y = 0) 

