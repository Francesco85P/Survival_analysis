library(tidyverse)

DEAD_FLIES <- read_csv("FULL_TABLE.csv")
IDENTIFIERS <- read_csv("IDENTIFIERS.csv")

DEAD_FLIES <- DEAD_FLIES |> 
  mutate(VIAL = as_factor(VIAL))

TIME<-numeric()
CENSUS <- numeric()
VIAL <-vector()


for (i in 1:nrow(DEAD_FLIES)){
  ROW <- DEAD_FLIES[i,]
  VIAL<-append(VIAL, rep(ROW$VIAL, ROW$START))

  TIME <-append(TIME,rep(3,ROW$D1 + ROW$E1))
  CENSUS <-append(CENSUS, c(rep(1, ROW$D1),rep(0, ROW$E1)))

  TIME <-append(TIME,rep(6,ROW$D2 + ROW$E2))
  CENSUS <-append(CENSUS, c(rep(1, ROW$D2),rep(0, ROW$E2)))

  TIME <-append(TIME,rep(9,ROW$D3 + ROW$E3))
  CENSUS <-append(CENSUS, c(rep(1, ROW$D3),rep(0, ROW$E3)))

  TIME <-append(TIME,rep(12,ROW$D4 + ROW$E4))
  CENSUS <-append(CENSUS, c(rep(1, ROW$D4),rep(0, ROW$E4)))

  TIME <-append(TIME,rep(15,ROW$D5 + ROW$E5))
  CENSUS <-append(CENSUS, c(rep(1, ROW$D5),rep(0, ROW$E5)))
  
  TIME <-append(TIME,rep(18,ROW$D6 + ROW$E6))
  CENSUS <-append(CENSUS, c(rep(1, ROW$D6),rep(0, ROW$E6)))

  TIME <-append(TIME,rep(21, ROW$START - sum(ROW[3:14])))
  CENSUS<-append(CENSUS,c(rep(1, ROW$D7),rep(0,  ROW$START - sum(ROW[3:15]))))
  }

MORTALITY_TABLE <- tibble("FLY" = seq(1,length(VIAL)), VIAL,TIME,CENSUS)

SURVIVAL_TABLE <- MORTALITY_TABLE |> 
  left_join(IDENTIFIERS)

write_csv(SURVIVAL_TABLE, "SURVIVAL_TABLE.csv")
