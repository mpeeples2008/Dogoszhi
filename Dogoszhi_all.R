library(tidyverse)
library(forcats)
library(ggplot2)


load('network.RData')

mancos <- 0.4

### Read in data files
types <- read.csv('types.csv',header=T)
site_attr <- read.csv('sites.csv',header=T)
dat <- typeapp

### filter input to only include painted ceramics with specific type designations
dat <- dat %>%
  left_join(types, by=c('SWSN_Type' = 'SWSN_Type')) %>%
  filter(Include!=0)

source('Dogoszhi_900.R')
source('Dogoszhi_950.R')
source('Dogoszhi_1000.R')
source('Dogoszhi_1050.R')
source('Dogoszhi_1100.R')
source('Dogoszhi_1150.R')

all_ceramics <- Ceramics_900 %>%
  full_join(Ceramics_950) %>%
  full_join(Ceramics_1000) %>%
  full_join(Ceramics_1050) %>%
  full_join(Ceramics_1100) %>%
  full_join(Ceramics_1150)

full <- all_ceramics %>%
  left_join(site_attr, by = c('Site' = 'SWSN_Site'))