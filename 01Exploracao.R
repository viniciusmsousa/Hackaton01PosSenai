
# Setup -------------------------------------------------------------------

library(tidyverse)
library(data.table)
library(readxl)
library(vroom)

# Exploracao inicial  -----------------------------------------------------

# Fluxo de demissões e e contratações
caged <- vroom("dados/Caged/Caged 2018 - 01-04.csv") %>% 
  as_tibble()
colnames(caged)

# Comércio exterior
comexstart <- read_xlsx("dados/Comex Stat/Exportação SC - 2018 - 01-04.xlsx") %>% 
  as_tibble()


# dimensões
cbo <- read_xlsx("dados/Dimensões/dim_CBO.xlsx") %>% 
  as_tibble()

cnae <- read_xlsx("dados/Dimensões/dim_CNAE.xlsx") %>% 
  as_tibble()

municipio <- read_xlsx("dados/Dimensões/dim_Municipio.xlsx") %>% 
  as_tibble()

# Rais
raisEstabelecimento <- vroom("dados/RAIS/fat_RAIS_Estabelecimentos.csv") %>% 
  as_tibble()

raisVinculo <- fread("dados/RAIS/fat_RAIS_Vinculo.csv") %>% 
  as_tibble()





# Previsao de empregos ----------------------------------------------------
library(lubridate)

caged1 <- vroom("dados/Caged/Caged 2018 - 01-04.csv") %>% 
  as_tibble()
caged2 <- vroom("dados/Caged/Caged 2018 - 05-08.csv") %>% 
  as_tibble()
caged3 <- vroom("dados/Caged/Caged 2018 - 09-12.csv") %>% 
  as_tibble()

caged <- bind_rows(caged1,caged2,caged3)
rm(caged1,caged2,caged3)
gc()

caged[1:100,] %>% 
  select(admitidosdesligados,competnciadeclarada,municpio,anodeclarado,
         cnae20subclas,cbo2002ocupa,grauinstruo,ibgesubsetor,idade,salriomensal,
         sexo,uf) %>% 
  mutate(
    admitidosdesligados = if_else(admitidosdesligados == "01","Admissao","Desligamento"),
    competnciadeclarada = ymd(paste0(competnciadeclarada,"01")),
  ) -> cagedTratado

vroom_write(x = cagedTratado,
            path = "dados/cagedFato.csv")
