/*
Created		20/09/2019
Modified		21/09/2019
Project		
Model		
Company		
Author		
Version		
Database		Oracle 10g 
*/


-- Create Types section


-- Create Tables section


Create table "fat_caged" (
	"admitidosdesligados" Varchar2 (30),
	"anodeclarado" Varchar2 (30),
	"cbo2002ocupa" Integer NOT NULL ,
	"cnae20subclas" Integer NOT NULL ,
	"competnciadeclarada" Varchar2 (30) NOT NULL ,
	"grauinstruo" Integer NOT NULL ,
	"ibgesubsetor" Varchar2 (30),
	"faixa" Varchar2 (30) NOT NULL ,
	"indice" Varchar2 (30) NOT NULL ,
	"municipio" Integer NOT NULL ,
	"salriomensal" Number,
	"sexo" Varchar2 (30) NOT NULL ,
	"uf" Varchar2 (30),
 Constraint "pk_fat_caged" primary key ("cbo2002ocupa","cnae20subclas","competnciadeclarada","grauinstruo","faixa","indice","municipio","sexo") 
) 
/

Create table "fat_rais_estabelecimento" (
	"ano" Varchar2 (30) NOT NULL ,
	"cnae20subclasse" Integer NOT NULL ,
	"cnae20classe" Varchar2 (30),
	"ibgesubsetor" Varchar2 (30),
	"municipio" Integer NOT NULL ,
	"qtdvinculosclt" Integer,
	"qtdvinculosativos" Integer,
	"uf" Varchar2 (30),
 Constraint "pk_fat_rais_estabelecimento" primary key ("ano","cnae20subclasse","municipio") 
) 
/

Create table "fat_comercio_exterior" (
	"cod_mun6d" Integer NOT NULL ,
	"data" Varchar2 (30) NOT NULL ,
	"produto" Varchar2 (30),
	"mes" Varchar2 (30),
	"pais" Varchar2 (30),
	"uf" Varchar2 (30),
	"codigo_sh4" Varchar2 (30),
	"descricao_sh4" Varchar2 (30),
	"bloco_eco_valor" Varchar2 (30),
	"tipo" Varchar2 (30),
 Constraint "pk_fat_comercio_exterior" primary key ("cod_mun6d","data") 
) 
/

Create table "fat_rais_vinculo" (
	"ano" Varchar2 (30),
	"cboocupacao2002" Integer NOT NULL ,
	"cnae20classe" Varchar2 (30),
	"cnae20subclasse" Integer NOT NULL ,
	"escolaridadeapos2005" Integer NOT NULL ,
	"indice" Varchar2 (30) NOT NULL ,
	"faixa" Varchar2 (30) NOT NULL ,
	"municipio" Varchar2 (30),
	"ibgesubsetor" Varchar2 (30),
	" sexotrabalhador" Varchar2 (30) NOT NULL ,
	"vlremunmedianom" Varchar2 (30),
 Constraint "pk_fat_rais_vinculo" primary key ("cboocupacao2002","cnae20subclasse","escolaridadeapos2005","indice","faixa"," sexotrabalhador") 
) 
/

Create table "dim_municipio" (
	"cod_mun6d" Integer NOT NULL ,
	"cod_uf" Integer,
	"cod_municipio_5d" Integer,
	"cod_mun" Integer,
	"cod_micro" Integer,
	"cod_meso" Integer,
	"uf" Varchar2 (2),
	"Mesorregiao" Varchar2 (30),
	"Microrregiao" Varchar2 (30),
	"sigla_ac" Varchar2 (30),
	"assoc_municipio" Varchar2 (100),
	"municipio" Varchar2 (30),
	"municipio_sac" Varchar2 (30),
	"municipio_pbi" Varchar2 (30),
	"vice_presidencia" Varchar2 (30),
	"altitude" Number,
	"latitude" Number,
	"longitude" Number,
 Constraint "pk_dim_municipio" primary key ("cod_mun6d") 
) 
/

Create table "dim_cnae" (
	"cod_subc" Integer NOT NULL ,
	"cod_sec" Integer,
	"cod_div" Integer,
	"cod_grupo" Integer,
	"cod_classe" Integer,
	"cod_subcsp" Integer,
	"gr_setor" Varchar2 (30),
	"secao" Varchar2 (30),
	"divisao" Varchar2 (30),
	"grupo" Varchar2 (30),
	"classe" Varchar2 (30),
	"subclasse" Varchar2 (30),
	"rotas" Varchar2 (30),
	"rotas_portal" Varchar2 (30),
 Constraint "pk_dim_cnae" primary key ("cod_subc") 
) 
/

Create table "dim_cbo" (
	"cod_familia" Integer,
	"cod_grande_grupo" Integer,
	"cod_ocupacao" Integer NOT NULL ,
	"cod_subgrupo" Integer,
	"cod_subgrupo_principal" Integer,
	"familia" Varchar2 (30),
	"gr_grupo" Varchar2 (30),
	"ocupacao" Varchar2 (30),
	"subgrupo_princ" Varchar2 (30),
	"subgrupo" Varchar2 (30),
 Constraint "pk_dim_cbo" primary key ("cod_ocupacao") 
) 
/

Create table "dim_data" (
	"ano" Integer NOT NULL ,
	"data" Varchar2 (30) NOT NULL ,
	"nome_mes" Varchar2 (30),
	"mes_ano" Varchar2 (30),
 Constraint "pk_dim_data" primary key ("data") 
) 
/

Create table "dim_idade" (
	"faixa" Varchar2 (30) NOT NULL ,
	"indice" Varchar2 (30) NOT NULL ,
 Constraint "pk_dim_idade" primary key ("faixa","indice") 
) 
/

Create table "dim_grau_instrucao" (
	"id" Integer NOT NULL ,
	"grau_instrucao" Varchar2 (30),
 Constraint "pk_dim_grau_instrucao" primary key ("id") 
) 
/

Create table "dim_genero" (
	"indice_genero" Varchar2 (30) NOT NULL ,
	"genero" Varchar2 (30),
 Constraint "pk_dim_genero" primary key ("indice_genero") 
) 
/


-- Create Indexes section


-- Create Foreign keys section

Alter table "fat_comercio_exterior" add Constraint "pfk_cod_mun6d_fat_comercio_ext" foreign key ("cod_mun6d") references "dim_municipio" ("cod_mun6d") 
/

Alter table "fat_caged" add Constraint "pfk_cod_mun6d_fat_caged" foreign key ("municipio") references "dim_municipio" ("cod_mun6d") 
/

Alter table "fat_rais_estabelecimento" add Constraint "pfk_cod_mum6d" foreign key ("municipio") references "dim_municipio" ("cod_mun6d") 
/

Alter table "fat_caged" add Constraint "pfk_cod_subc_fat_caged" foreign key ("cnae20subclas") references "dim_cnae" ("cod_subc") 
/

Alter table "fat_rais_estabelecimento" add Constraint "pfk_cod_subc_fat_rais_estab" foreign key ("cnae20subclasse") references "dim_cnae" ("cod_subc") 
/

Alter table "fat_rais_vinculo" add Constraint "pfk_cod_subc_fat_rais_vinculo" foreign key ("cnae20subclasse") references "dim_cnae" ("cod_subc") 
/

Alter table "fat_caged" add Constraint "pfk_cod_ocupacao_fat_caged" foreign key ("cbo2002ocupa") references "dim_cbo" ("cod_ocupacao") 
/

Alter table "fat_rais_vinculo" add Constraint "pkf_cod_ocupacao_fat_rais_vinc" foreign key ("cboocupacao2002") references "dim_cbo" ("cod_ocupacao") 
/

Alter table "fat_caged" add Constraint "pfk_data_fat_caged" foreign key ("competnciadeclarada") references "dim_data" ("data") 
/

Alter table "fat_comercio_exterior" add Constraint "pfk_cod_subc_fat_comercio_exte" foreign key ("data") references "dim_data" ("data") 
/

Alter table "fat_rais_estabelecimento" add Constraint "pfk_data_fat_rais_estab" foreign key ("ano") references "dim_data" ("data") 
/

Alter table "fat_caged" add Constraint "pfk_faixa_fat_caged" foreign key ("faixa","indice") references "dim_idade" ("faixa","indice") 
/

Alter table "fat_rais_vinculo" add Constraint "pfk_indice_fat_rais_vinculo" foreign key ("faixa","indice") references "dim_idade" ("faixa","indice") 
/

Alter table "fat_caged" add Constraint "pfk_id_fat_caged" foreign key ("grauinstruo") references "dim_grau_instrucao" ("id") 
/

Alter table "fat_rais_vinculo" add Constraint "pfk_id_fat_rais_vinculo" foreign key ("escolaridadeapos2005") references "dim_grau_instrucao" ("id") 
/

Alter table "fat_rais_vinculo" add Constraint "pfk_indice_genero_fat_rais_vin" foreign key (" sexotrabalhador") references "dim_genero" ("indice_genero") 
/

Alter table "fat_caged" add Constraint "pfk_indice_fat_caged" foreign key ("sexo") references "dim_genero" ("indice_genero") 
/


-- Create Object Tables section


-- Create XMLType Tables section


-- Create Functions section


-- Create Sequences section


-- Create Packages section


-- Create Synonyms section


-- Create Table comments section


-- Create Attribute comments section


