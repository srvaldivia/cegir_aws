
# packages ----------------------------------------------------------------

library(tidyverse)
library(sf)
library(odbc)
library(RPostgres)
library(rpostgis)
library(RPostgreSQL)
library(DBI)
library(rnaturalearth)

ne_world <- rnaturalearth::ne_countries(scale = 50, returnclass = "sf")

ne_world <- ne_world |> filter(str_detect(sovereignt, "Chile"))

# credentials -------------------------------------------------------------

dsn_database <- "test"
dsn_hostname <- "test-postgis.ci5no5vfnzlj.us-east-2.rds.amazonaws.com"
dsn_port <- 5432
dsn_uid <- "gis_admin"
dsn_pwd <- "nz5PNL3RJCsYDkf"




# Option 1 ----------------------------------------------------------------
# https://solutions.posit.co/connections/db/databases/postgresql/
# https://github.com/r-dbi/RPostgres
# esta funcionó!


library(DBI)
con <- dbConnect(RPostgres::Postgres(),
                 dbname = 'test', 
                 host = 'test-postgis.ci5no5vfnzlj.us-east-2.rds.amazonaws.com',
                 port = 5432,
                 user = 'gis_admin',
                 password = 'nz5PNL3RJCsYDkf')

ne_world

str_sort(dbListTables(con))

dbGetInfo(con)

dbGetQuery(con, "SELECT * FROM geometry_columns")
dbGetQuery(con, "SELECT * FROM county")



st_write(ne_world, dsn = con, layer = "ne_world",
         delete_layer = FALSE, append = FALSE)



chile <- dbGetQuery(con, "SELECT * FROM ne_world")



class(chile)







# https://hevodata.com/learn/rpostgresql/
tryCatch({
  drv <- dbDriver("PostgreSQL")
  print("Connecting to Database…")
  connec <- dbConnect(drv, 
                      dbname = dsn_database,
                      host = dsn_hostname, 
                      port = dsn_port,
                      user = dsn_uid, 
                      password = dsn_pwd)
  print("Database Connected!")
},
error=function(cond) {
  print("Unable to connect to Database.")
})






dsn_database <- "test"
dsn_hostname <- "test-postgis.ci5no5vfnzlj.us-east-2.rds.amazonaws.com"
dsn_port <- 5432
dsn_uid <- "gis_admin"
dsn_pwd <- "nz5PNL3RJCsYDkf"


con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "[your driver's name]",
                      Server   = "[your server's path]",
                      Database = "[your database's name]",
                      UID      = rstudioapi::askForPassword("Database user"),
                      PWD      = rstudioapi::askForPassword("Database password"),
                      Port     = 5432)

con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "PostgreSQL",
                      Server   = "test-postgis.ci5no5vfnzlj.us-east-2.rds.amazonaws.com",
                      Database = "test",
                      UID      = "gis_admin",
                      PWD      = "nz5PNL3RJCsYDkf",
                      Port     = 5432)



# https://solutions.posit.co/connections/db/databases/postgresql/
# https://github.com/r-dbi/RPostgres
# esta funcionó!
con <- dbConnect(RPostgres::Postgres(),
                 dbname = 'test', 
                 host = 'test-postgis.ci5no5vfnzlj.us-east-2.rds.amazonaws.com', # i.e. 'ec2-54-83-201-96.compute-1.amazonaws.com'
                 port = 5432,
                 user = 'gis_admin',
                 password = 'nz5PNL3RJCsYDkf')



