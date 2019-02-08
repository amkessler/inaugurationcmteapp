library(tidyverse)
library(lubridate)
library(janitor)
library(glue)
library(plotly)
library(DT)
library(googlesheets)
library(kableExtra)
library(leaflet)
# library(ggmap)
library(RColorBrewer)
library(htmlwidgets)
library(htmltools)
library(tigris)
options(tigris_class = "sf")


### DATA LOADING AND PREP

# import data from Google Sheet 

# gs_ls()

#register google sheet
inauguration_contribs <- gs_key("1qCG3BxuX42SNMW8u8tQ9HxkkZF-mFffnzTK6PaFxHGQ")


#read in all the data in the inaug tab
contribs <- inauguration_contribs %>% 
  gs_read(ws = "inaugural contributors") %>% 
  clean_names() 

head(contribs)
names(contribs)

#set formatting of certain columns
contribs <- contribs %>% 
  mutate(
    individual_or_organization = as.factor(individual_or_organization),
    city = as.factor(city),
    state = as.factor(state),
    ind_contrib_category = as.factor(ind_contrib_category)
  )

#parse number columns
contribs$inaug_2017_total <- parse_number(contribs$inaug_2017_total)
contribs$trump_campaign_2016 <- parse_number(contribs$trump_campaign_2016)
contribs$other_2016_presidential_campaigns <- parse_number(contribs$other_2016_presidential_campaigns)
contribs$total_contribs_1989_to_2017 <- parse_number(contribs$total_contribs_1989_to_2017)
contribs$repubs_conservatives_1989_to_2017 <- parse_number(contribs$repubs_conservatives_1989_to_2017)
contribs$dems_liberals_1989_to_2017 <- parse_number(contribs$dems_liberals_1989_to_2017)

saveRDS(contribs, "contribs_saved.rds")