dat1=read.csv("data-raw/Drac_Chabottes_2018_unfiltered.txt", row.names=1,sep=";")
dat2=read.csv("data-raw/Durance_Brillanne_2017_unfiltered.txt", row.names=1, sep=";")
dat1 = dat1 %>%
    filter(TYPO_VEGE != "mature" & NAME != "Riparian")
dat2 = dat2 %>%
    filter(TYPO_VEGE != "mature" & NAME != "Riparian")
write.table(dat1,"data-raw/Drac_Chabottes_2018.txt", row.names=TRUE, sep=";",dec=".")
write.table(dat2,"data-raw/Durance_Brillanne_2017.txt", row.names=TRUE,sep=";", dec=".")
