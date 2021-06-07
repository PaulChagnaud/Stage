# Installation des packages
install.packages("tidyverse")
library(tidyverse)
install.packages("stringr")
library(stringr)
install.packages("dplyr", dependencies = TRUE)
library(dplyr)
install.packages("doBy")
library(doBy)

# Importaton des données 
bdd <- read.csv("/Users/paulchagnaud/Desktop/bdd courante.csv", header = TRUE, sep = ",")
summary(bdd)
count(bdd) # nous comptabilisons 556684 observations dans cette base de données 

# Restriction à l'année 1789
bdd1789 <- filter(bdd, bdd$year==1789)
count(bdd1789) # Nous comptabilisons 30640 observations contre 556684 au départ

# Comptabilisation du nombre d'observations conforment au résumé
bdd1789resume <- filter(bdd1789, source_type=="Résumé")
count(bdd1789resume) # Nous comptabilisons 1810 observations conforment au résumé sur 30640

# Comptabilisation du nombre d'observation 
bdd1789resumefr <- filter(bdd1789resume, partner_grouping == "France")
count(bdd1789resumefr)

bdd1789resumefr <- subset(bdd1789resume, partner_grouping == "France" )
count(bdd1789resumefr)

attach(bdd1789resumefr)
summaryBy(value ~ export_import + Résumé , FUN =c(mean, sum), data = bdd1789resumefr)



resume <- ifelse(source_type=="Résumé", 1,0){
  
}

tabulate(resume)

# Nouveau test 

colonnecountry <-as.vector(dataprojet$country)
listcountry<- as.vector(unique(colonnecountry))

lalala <- as.vector(rep(0,length(bdd1789)))
compteur <-0

for (i in 1:length(bdd1789)){
  compteur <-0
  for (j in 1:length(bdd1789)){
    if (bdd1789$source_type[i] == "Résumé"){
      compteur <-compteur+1
    }
  }
  lalala[i] <- compteur
}
print(lalala)








