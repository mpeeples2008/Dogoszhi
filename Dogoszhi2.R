library(tidyverse)

### Read in data files
types <- read.csv('types.csv',header=T)
site_attr <- read.csv('sites.csv',header=T)
dat <- read.csv('Apportioning.csv',header=T,row.names=1)

### filter input to only include painted ceramics with specific type designations
dat <- dat %>%
  left_join(types, by=c('Type' = 'SWSN_Type')) %>%
  filter(Include!=0)

### Summarize total painted ceramic type count by Site for the 1050-1100 interval
Ceramics_1050 <- dat %>%
  group_by(Site) %>%
  summarize(Painted_1050 = sum(P1050,P1075)) 

### Summarize Dogoszhi style painted ceramic types count by Site for the 1050-1100 interval
Dogoszhi_1050 <- dat %>%
  filter(Dogoszhi == 1) %>%
  group_by(Site) %>%
  summarize(Dogoszhi_1050 = sum(P1050,P1075))

### Summarize Black Mesa style painted ceramic types count by Site for the 1050-1100 interval
BlackMesa_1050 <- dat %>%
  filter(Black.Mesa == 1) %>%
  group_by(Site) %>%
  summarize(BlackMesa_1050 = sum(P1050,P1075))

### Summarize Mancos Black-on-white count by Site for the 1050-1100 interval
Mancos_1050 <- dat %>%
  filter(Type == 'Mancos Black-on-white') %>%
  group_by(Site) %>%
  summarize(Mancos_1050 = sum(P1050,P1075))

### Join results into a single object and filter for sites with greater than or equal to 20 sherds
Ceramics_1050 <- Ceramics_1050 %>%
  left_join(Dogoszhi_1050) %>%
  replace_na(list(Dogoszhi_1050 = 0))
Ceramics_1050 <- Ceramics_1050 %>%
  left_join(BlackMesa_1050) %>%
  replace_na(list(BlackMesa_1050 = 0))
Ceramics_1050 <- Ceramics_1050 %>%
  left_join(Mancos_1050) %>%
  replace_na(list(Mancos_1050 = 0)) %>%
  filter(Painted_1050 >= 0)


### Add variables with Proportions
Ceramics_1050 <- Ceramics_1050 %>% 
  mutate(DogoProp_1050 = Dogoszhi_1050/Painted_1050) %>%
  mutate(BMProp_1050 = BlackMesa_1050/Painted_1050) %>%
  mutate(DogoRed_1050 = (Dogoszhi_1050-(Mancos_1050*0.5))/Painted_1050) # reduce Dogoszhi by proportion of Mancos Black-on-white

Ceramics_1050 <- Ceramics_1050 %>%
  left_join(site_attr, by=c('Site' = 'SWSN_Site'))

Ceramics_1050 %>% 
  filter(CSN_macro_group %in% c('Central San Juan Basin','Chaco Canyon','Chuska Slope','Lobo Mesa/Red Mesa Valley','Defiance Plateau',
                                'Cibola','Middle San Juan','Rio Puerco of the West','San Juan Foothills','Silver Creek','Southeast Utah')) %>%
  ggplot(aes(y=DogoRed_1050,x=CSN_macro_group)) +
  geom_boxplot()



Ceramics_1050 %>% 
  filter(Size_Class >0) %>%
  ggplot(aes(y=DogoRed_1050,x=as.factor(Size_Class))) +
  geom_boxplot()
