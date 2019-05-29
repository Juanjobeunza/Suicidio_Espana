#################################
#                               #
#         Suicidios INE         #
#                               #
#################################

# Análisis de tendencia temporal de suicidios en España y posible impacto de 13 razones


# Limpieza Global Environment
rm(list = ls())

# Activación librerías necesarias
library("tidyverse")
library("pxR")              #- para trabajar con datos PC-Axis

# Info sobre bajar PC-Axis directamente del INE a R
# https://www.uv.es/vcoll/importar-exportar.html
# No instalo package "personal.pjp" pq no funciona con mi versión de R. Imagino que no lo han actualizado ni lo harán.

# Links PC-Axis con info del INE (Mortalidad por causa de muerte - sucidios)
# https://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2017/l0/05006.px?nocab=1
# http://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2016/l0/05006.px?nocab=1
# http://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2015/l0/05006.px?nocab=1
# http://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2014/l0/05006.px?nocab=1
# http://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2013/l0/05006.px?nocab=1
# http://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2014/l0/05006.px?nocab=1




################ Año 2017  ################################################
file_name <- "https://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2017/l0/05006.px?nocab=1"
sui17 <- read.px(file_name) %>% as.data.frame() %>% as.tbl()
str(sui17)         # Ok.
colnames(sui17) <- c("edad17", "sexo17", "mes17", "value17")

# str(sui17)
# View(sui17)

# table(sui17$edad17)
# table(sui17$sexo17)
# table(sui17$mes17)
# hist(sui17$value17)

# table(sui17$edad17, sui17$sexo17)

# Filtrar adolescentes solo
sui17 <- filter(sui17, edad17=="Menores de 15 años" | edad17=="De 15 a 29 años")

# Spread los meses para serie temporal (por si lo necesito)
# sui17_t <- spread(sui17, mes17, value17)

# Eliminar grupo todos los meses
sui17 <- filter(sui17, mes17!="Todos los meses")


# Gráfico secuencia temporal (http://www.sthda.com/english/wiki/ggplot2-line-plot-quick-start-guide-r-software-and-data-visualization)
ggplot(data = sui17, aes(x=mes17, y=value17, group=interaction(sexo17,edad17))) + 
         geom_line(aes(color=interaction(sexo17, edad17))) +
         geom_point(aes(shape=interaction(sexo17, edad17)))

# Gráfico separando (facets) por edad (tienen rangos muy distintos)
p1 <- ggplot(data = sui17, aes(x=mes17, y=value17, group=interaction(sexo17,edad17))) + 
  geom_line(aes(color=interaction(sexo17))) +
  geom_point(aes(shape=interaction(sexo17)))
p1 + facet_grid(. ~ edad17)


############### Años 2014-2016 #########################

file_name <- "http://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2014/l0/05006.px?nocab=1"
sui14 <- read.px(file_name) %>% as.data.frame() %>% as.tbl()
str(sui14)         # Ok.
colnames(sui14) <- c("edad14", "sexo14", "mes14", "value14")
sui14 <- filter(sui14, edad14=="Menores de 15 años" | edad14=="De 15 a 29 años")
sui14 <- filter(sui14, mes14!="Todos los meses")

file_name <- "http://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2013/l0/05006.px?nocab=1"
sui15 <- read.px(file_name) %>% as.data.frame() %>% as.tbl()
str(sui15)         # Ok.
colnames(sui15) <- c("edad15", "sexo15", "mes15", "value15")
sui15 <- filter(sui15, edad15=="Menores de 15 años" | edad15=="De 15 a 29 años")
sui15 <- filter(sui15, mes15!="Todos los meses")

file_name <- "http://www.ine.es/jaxi/files/_px/es/px/t15/p417/a2016/l0/05006.px?nocab=1"
sui16 <- read.px(file_name) %>% as.data.frame() %>% as.tbl()
str(sui16)         # Ok.
colnames(sui16) <- c("edad16", "sexo16", "mes16", "value16")
sui16 <- filter(sui16, edad16=="Menores de 15 años" | edad16=="De 15 a 29 años")
sui16 <- filter(sui16, mes16!="Todos los meses")
