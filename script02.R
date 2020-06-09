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
  
#### primeros pasos con ggplot2 ####
# creacion del grafico: agregar la data y configuramos las variables
ggplot(data = Salaries, aes(x=yrs.service , y= salary ))

# Creemos un diagrama de dispersion 
p <-  ggplot(data = Salaries, aes(x=yrs.service , y= salary ))
class(p)

p + geom_point()
View(Salaries)

#modifiquemos nuestro objeto p (lienzo vacio)

p <-  ggplot(data = Salaries, aes(x=yrs.service , y= salary , fill= sex))

# grafico 1

p + geom_point(shape=25 , size=2.4)

# grafico 2 #se cambio la forma para diferenciar a los pares ordenados

p + geom_point(aes(shape=sex , col=sex), size=3)

#grafico 3 #Subiendo la leyenda

p + geom_point(aes(shape=sex , col=sex), size=3) + 
  scale_shape_manual(values = c(4,21)) +
  scale_color_manual(values = c("red","#5C7A54"))+
  #theme(legend.position = "left")
  #theme(legend.position = "top")
  #theme(legend.position = "bottom")
  theme(legend.position = c(0.95,0.9))

#Datanovia ggplot shaple tips 
#https://www.datanovia.com/en/blog/ggplot-point-shapes-best-tips/
#para saber que figuras elegir
#htmlcolorcodes.com/es/ para los codigos de color

help(ggsave)
ggsave(filename = "Grafico3.png" , width = 16, height = 9 , units = "cm")

#grafico 4

p + geom_point(aes(shape=sex , col=sex), size=3) + 
  scale_shape_manual(values = c(4,21)) +
  scale_color_manual(values = c("red","#5C7A54"))+
  theme(legend.position = "right") +
  #theme(legend.background = element_rect(fill="#A2AFC9"))
  theme(legend.background = element_rect(fill="#A2AFC9",
                                         colour="darkblue",
                                         linetype = "dashed"))

# legend.background es para modificar el fondo de la leyenda
#modificar temas "ggplot2 tidyverse.org/reference/theme.html"
#https://ggplot2.tidyverse.org/reference/theme.html
#https://www.datanovia.com/en/blog/line-types-in-r-the-ultimate-guide-for-r-base-plot-and-ggplot/


#grafico 5
Graph5 <- p + geom_point(aes(shape=sex , col=sex), size=3) + 
  scale_shape_manual(values = c(4,21)) +
  scale_color_manual(values = c("red","#5C7A54"))+
  theme(legend.position = "right") +
  theme(legend.background = element_rect(fill="#A2AFC9"))+
  scale_y_continuous(labels=scales::scientific)                                      
 
#grafico 6

Graph5 + geom_smooth()
ggsave(filename = "grafico6_GeomSmmoth.png")

#grafico7
Graph5 + geom_smooth(method = "lm",formula = y ~ poly(x,3))
#polinomio de grado 3
#grafico 8
Graph5 + geom_smooth(method = "lm",formula = y ~ poly(x,3))+
  facet_grid(~sex)
#facet_grid para separar las graficas en una misma
#geom_smooth no se obtiene ecuacion


#grafico 9
p1 <- ggplot(data = Salaries, aes(x=yrs.service, y=salary, colour=rank))
p1 +geom_point()
p1 +geom_point()+
  geom_smooth(aes(group = rank) , method = "lm" , color="black", size=0.5)+
  facet_grid(~sex)

#grafico 10

p1 <- ggplot(data = Salaries, aes(x=yrs.service, y=salary, fill=rank))
p1 +geom_point(shape=21)+
  geom_smooth(method ="lm",
              color="black",
              size=0.5,
              se = FALSE)+
  facet_grid(~sex)
#rank relleno

library(gridExtra)

#GRafico 11
Plt1 <- ggplot(Salaries, aes(x = rank)) + geom_bar() 
Plt2 <- ggplot(Salaries, aes(x = sex)) + geom_bar()
Plt3 <- ggplot(Salaries, aes(x = yrs.service, y= salary)) + geom_point()

grid.arrange(Plt1,Plt2,Plt3 ,ncol=3)










