library(tidyverse)

CONTAMINATION<-read_csv("EXPINFECTION2.csv")
CONTAMINATION <- CONTAMINATION |> 
  mutate(VIAL = as_factor(VIAL))

DEAD_FLIES <- read_csv("DEADFLIES2.csv")
DEAD_FLIES <- DEAD_FLIES |> 
  mutate(VIAL = as_factor(VIAL))

FULL_TABLE <-DEAD_FLIES |> 
  left_join(CONTAMINATION |> select (VIAL, K1,K2,K3,K4,K5,K6,K7))

CONTAMINATED<-FULL_TABLE |> 
  rowwise() |> 
  filter(sum(across(K1:K7)) ==1)



  
for (i in 1:nrow(FULL_TABLE)){
  ROW <- FULL_TABLE[i,]

  if(ROW$K1 == 1){
    ROW$E1 =  ROW$START - ROW$D1
  }

  if(ROW$K2 == 1 ){
    ROW$E2 =  ROW$START - sum(ROW[3:5])
  }

  if(ROW$K3 == 1 ){
   ROW$E3 =  ROW$START - sum(ROW[3:7])
   }

  if(ROW$K4 == 1 ){
    ROW$E4 =  ROW$START - sum(ROW[3:9])
    }

  if(ROW$K5 == 1 ){
  ROW$E5 =  ROW$START - sum(ROW[3:11])
  }

  if(ROW$K6 == 1 ){
    ROW$E6 =  ROW$START - sum(ROW[3:13])
  }
  FULL_TABLE[i,] = ROW
  }



FULL_TABLE <- FULL_TABLE |> 
  select(!c(K1:K7))

write_csv(FULL_TABLE, "FULL_TABLE.csv")

  

  


