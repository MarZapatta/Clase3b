#### Datos y librerias ####
rm(list = ls())
setwd("E:/Escritorio/Clase3")
getwd()
library(dplyr)

# Desarrollado por Hadley Wikham(Rstudio)
#dyplyr: gramatica para manipulacion de datos

#### cargar data: storms , pollution , tb #####
storms <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/storms.csv")
#Velocidades maximas de viento para de 6 huracanes 
#https://www.nhc.noaa.gov/

pollution <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/pollution.csv")

#Nivel promedio de la contaminacion del aire por particulas : NY Londre y bejin
# https://www.who.int/phe/health_topics/outdoorair/databases/cities/en/

tb <- read.csv("https://raw.githubusercontent.com/robintux/Datasets4StackOverFlowQuestions/master/tb.csv")
#numero de casos de tb 95-2013

#### algunas funciones de dplyr ####
class(storms)
dim(storms)[1]
dim(storms)[2]
head(storms, n = 2)
tail(storms, n = 3)
colnames(storms)  #para saber el nombre de las columnas
names(storms)
str(storms)

# es notorio que la variable $date debe ser una que represente
# a la linea del tiempo
class(storms$date)
storms$date <- as.Date(storms$date)
# Para cambiar el formato de la variable, la pasamos de chr a Date.

#### Funcion select ####
#Permite seleccionar la columna que es la 2da dimension de un data frame
#Seleccionar las variables "storm y pressure"
help("select")
(select(storms, storm,pressure))
#Seleccionamos las variables de forma matricial
select(storms, colnames(storms)[1], colnames(storms)[3])
#verificamos que el resultado es un objeto de tipo data frame
class(select(storms, storm,pressure))
colnames(storms)
class((select(storms, storm,pressure)))

#utilizamos sintaxis matricial
storms[,c(1,3)]
#filas las quiero todas por eso dejo vacio
#columnas solo quiero la 1 y 3

#Para excluir una columna utilzamos el operado (unario): -
select(storms,-storm)
#con notacion matricial
storms[,-1]
storms[,-c(1,3)]

#podemos utilizar la notacion : para seleccionar un rango de columnas
select(storms, wind:date)

#utilizando los operadores : y - de forma conjunta podemos hacer mas cosas
select(storms, -(storm:wind))

#dplyr nos permitira seleccionar columnas que esten con un patron ()
select(storms, starts_with("w"))


#seleccion las columnas cuyo nombre termina con la letra e
select(storms, ends_with("e"))

#slecciona todas las columnas
select(storms,everything())

#selecciona columnas cuyo nombre contiene un string
select(storms, contains("essure"))

#algunas funciones de select son bastante utiless
# -
# :
# contains()
#star_with()
#ends_with()
#everything()
help("contains")
help("starts_with")

#### filter ####
# la funcion filter nos permite filtrar filas segun una condicion
filter(storms, wind > 50)
filter(storms, wind >= 50 , storm %in% c("Alberto" , "Alex", "Allison"))

#el sgte ejm se filtra aquellas filas con wind>=50 y pressure <1010
filter(storms, wind >=50 & pressure<1010)

#### arrange ####
# la funcion arrange() se utiliza para ordenar las filas de una data frame
# de acuerdo a una o varias columnas
# por defecto arrange ordena las filas en orden ascendete
#para ordenar las filas por la variable wind de forma ascendete:
arrange(storms, wind)

# de forma descendete
arrange(storms, desc(wind))

#### rename ####
names(storms)
rename(storms, tormenta = storm, viento=wind, presion=pressure , fecha = date)

#### mutate ####
#con la funcion mutate podemos computar calcular transformaciones de variables
# de un data frame. a menudo tendremos la necesidad de crear nuevas variables
#que se calculan a partir de variables existente , murate() proporciona
#una interface para realizar este tipo de operaciones
# deseo calcular una variable ratio que sea definida como el cociente
# entre presion(pressure) y viento (wind)
StormsNuevo <- mutate(storms, ratio= pressure/wind)

#mutate nos permite encadenar varias expresiones
mutate(storms, ratio = pressure/wind , inverse = ratio^-1)

StormsNuevo$wind
mean(StormsNuevo$wind)

##### summarise #####
summary(StormsNuevo)
#funciona de forma analoga a la funcion mutate, excepto que en lugar de añadir nuevas
#columnas crea un nuevo dataframe
# por ejemplo , para calcular la mediana y la varianza de la variable amount del 
#data frame pollution

summarise(pollution, mediana = median(amount) , variance = var(amount))
class(summarise(pollution , mediana = median(amount) , variance = var ( amount)))
p2 <-summarise(pollution, mediana = median(amount) , variance = var(amount))

#### operador pipe #####
# el uso es bastante y basicamente sirve para concatenar expresiones
#de la gramatica dplyr
pollution %>% summarise(mediana2 = median(amount), varianza = var(amount))

# Funciones que trabajan conjuntamente con summarise
# base: min, max, median, mean, sum, var, sd
#dplyr: first, last, n,n_distinct , nth
class(pollution)
class(pollution %>% summarise(mediana2 = median(amount), varianza = var(amount))
)

#### group_by #####
pollution
group_by(pollution, city)
class(group_by(pollution, city))

Info <- pollution %>% group_by(city) %>%
  summarise(media=mean(amount) , sum = sum (amount) , n = n ())
class(Info)

#sumamarise crea un nuevo df
# n=n() es para saber cuantos elementos de las variables hay












