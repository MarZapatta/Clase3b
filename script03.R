#### limpiamos memoria ####
rm(list = ls())
getwd()
# setear directorio de trabajo
#setwd()
dir()

#### cargar la data ####
library(ggplot2)
library(car)
library(help=car)
library(help=carData)
data("Salaries")
str(Salaries)

summary(Salaries)


#Grafico 1
ggplot(Salaries,aes(x=salary))

ggplot(Salaries, aes(x=salary, y= ..density..)) +
  geom_histogram(colour = 'grey60' , fill = 'cornsilk') +
  geom_density(colour = NA , fill="blue" , alpha = 0.1) +
  geom_line(stat="density", colour="red")


#Los intervalos de clase
Hs <- hist(Salaries$salary)
Hs$breaks[2] - Hs$breaks[1] #longitud del intervalo de clase
Hs$counts

Hs2 <- hist(Salaries$salary, breaks=seq(40000,240000,15*1000))

#Hs2$breaks
bwidth = Hs2$breaks[2]-Hs2$breaks[1]
ggplot(Salaries, aes(x = salary , y = ..density..))+
  geom_histogram(binwidth = bwidth,colour = 'grey60' , fill = 'cornsilk')+
  geom_density(colour = NA , fill = "blue" , alpha = 0.1) +
  geom_line(stat = "density" , colour= "red")+
  xlim(45000, 250000)


















