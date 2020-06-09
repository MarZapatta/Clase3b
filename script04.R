#### Limpiamos memoria ####
rm(list = ls())
# setear directorio de trabajo
setwd("E:/Escritorio/RUNI/Clase3/")
getwd()
dir()

#### cargamos la data ####
Oro <- read.csv("GOLDAMGBD228NLBM.csv")


#### Preprocesar la data ####
Oro$DATE
Oro$GOLDAMGBD228NLBM
colnames(Oro)
colnames(Oro) <- c("Fecha", "Precio")
class(Oro)
str(Oro)

# MOdifico la clase/tipo de la columna Fecha
Oro$Fecha <- as.Date(Oro$Fecha)
class(Oro$Fecha)

# modifico la clase/tipo de la columna Precio
class(Oro$Precio)
Oro$Precio <- as.double(Oro$Precio)

# cantidad de elementos na 
# Aprovecho que :
# True : 1 
# False : 0
# Calculo la cantidad de elementos TRUE , esto corresponde con la cantidad de 
# elementos de tipo NA
sum(is.na(Oro$Precio))
sum(is.na(Oro$Fecha))


# Notamos que existen 423 dias que no tienen informacion, su tarea
# es encontrar aquellos 423 dias .


Oro2020 <- Oro[Oro$Fecha >= "2020-01-01", ]
Oro2020 <- na.omit(Oro2020)

plot(Oro2020$Precio, type = 'l')

plot(Oro2020$Fecha, Oro2020$Precio, type = 'l')

plot.ts(Oro2020$Fecha, Oro2020$Precio)
