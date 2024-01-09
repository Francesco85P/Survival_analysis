library(tidyverse)

Exp2 <-read_csv("SURVIVAL_TABLE_2.csv")
Exp3 <- read_csv("SURVIVAL_TABLE_3.csv")

Exp2 <-Exp2 |> 
  select(!GROUP) |> 
  mutate(VIAL = paste0("EXp2_",VIAL)) |> 
  mutate(EXPERIMENT ="EXP2")
  
Exp3<-Exp3 |> 
  mutate(VIAL = paste0("EXp3_",VIAL)) |> 
  mutate(EXPERIMENT ="EXP3")

Joint_Table <- bind_rows(Exp2, Exp3)

write_csv(Joint_Table, "Joint_table.csv")
