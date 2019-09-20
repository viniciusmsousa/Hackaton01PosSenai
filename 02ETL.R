# Setup -------------------------------------------------------------------
library(tidyverse)
library(vroom)
library(lubridate)


# Caged -------------------------------------------------------------------

caged1 <- vroom("dados/Caged/Caged 2018 - 01-04.csv") %>% 
  as_tibble()
caged2 <- vroom("dados/Caged/Caged 2018 - 05-08.csv") %>% 
  as_tibble()
caged3 <- vroom("dados/Caged/Caged 2018 - 09-12.csv") %>% 
  as_tibble()

caged <- bind_rows(caged1,caged2,caged3)
rm(caged1,caged2,caged3)
gc()

caged %>% 
  select(admitidosdesligados,competnciadeclarada,municpio,anodeclarado,
         cnae20subclas,cbo2002ocupa,grauinstruo,ibgesubsetor,idade,salriomensal,
         sexo,uf) %>% 
  mutate(
    admitidosdesligados = if_else(admitidosdesligados == "01","Admissao","Desligamento"),
    competnciadeclarada = ymd(paste0(competnciadeclarada,"01")),
  ) -> cagedTratado

vroom_write(x = cagedTratado,
            path = "dados/cagedFato.csv")


teste <- vroom("dados/cagedFato.csv")


# Rais --------------------------------------------------------------------


# Estabelecimento
raisEstabelecimento <- vroom("dados/RAIS/fat_RAIS_Estabelecimentos.csv") %>% 
  as_tibble()

raisEstabelecimento %>% 
  select(municipio,cnae20classe,cnae20subclasse,qtdvínculosclt,qtdvínculosativos,uf,ibgesubsetor) %>% 
  mutate_at(vars(contains("qtd")),function(x){as.double(x)}) -> raisEstabelecimentoTratado

vroom_write(x = raisEstabelecimentoTratado,
            path = "dados/raisEstabelecimento.csv")

# Vinculo
raisVinculo <- vroom("dados/RAIS/fat_RAIS_Vinculo.csv") %>% 
  as_tibble()

raisVinculo %>% 
  select(cboocupação2002,cnae20classe,cnae20subclasse,escolaridadeapos2005,faixaetária,
         )

