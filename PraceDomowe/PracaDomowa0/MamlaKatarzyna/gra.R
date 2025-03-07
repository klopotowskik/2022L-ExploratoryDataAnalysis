library(proton)
proton()
data("employees")
employees[employees$surname== "Insecure", c('login')]
proton(action = "login", login="johnins")
top1000passwords
length(top1000passwords)
top1000passwords[2]
for(i in 1:1000){
  proton(action = "login", login="johnins", password=top1000passwords[i])
  
}
data("logs")
head(logs)
logs[logs$login =="johnins",c("host")]

proton(action = "server", host="194.29.178.56")


#########################################
###    WSTĘP DO EKSPLORACJI DANYCH    ###
###         LABORATORIUM 1            ###
#########################################

# 0) Prowadzący.
## Anna Kozak, Katarzyna Woźnica
## Kontakt: MS Teams

# 1) Materiały do zajęć.
## Repozytorium na GitHub
## https://github.com/MI2-Education/2022L-ExploratoryDataAnalysis


# 2) Jak działa GitHub?
## Jak zgłosić pracę domową/projekt? (fork, pull request)


# 3) Przypomnienie podstaw R.

data(mtcars)
head(mtcars)
head(mtcars,10)
tail(mtcars)
?mtcars

dim(mtcars)
str(mtcars)

## Jak wybieramy wiersze (obserwacje) oraz kolumny (zmienne)?
mtcars[2:3,4:5]
mtcars[,1:4]

## Pierwszy wiersz, pierwsza kolumna?

mtcars[1,1]

## 10 pierszych wierszy, 2 i 3 kolumna?
mtcars[1:10,2:3]


## Wszytskie wiersze i kolumny w kolejności "am", "wt", "mpg"?

mtcars[,c("am","wt","mpg")]


## Jak wybierać jedną kolumnę?
mtcars[["mtg"]]
mtcars$mpg

## Pytania

## 1. Wymiar ramki danych
dim(mtcars)
## 2. Jakie są typy zmiennych?
str(mtcars)
## 3. Ile jest unikalnych wartości zmiennej "cyl" i jakie to są wartości?
unique(mtcars$cyl)
length(unique(mtcars$cyl))
## 4. Jaka jest średnia wartość zmiennej "drat" dla samochodów o wartości zmiennej "cyl" równej 4?
mean(mtcars[mtcars$cyl==4,c("drat")])
median(mtcars[mtcars$cyl==4,c("drat")])
## Prosty wykres
plot(mtcars$mpg,mtcars$hp)

## Zależność "mpg" i "hp" - scatter plot



## Zmienna "cyl" - barplot
barplot(mtcars$cyl)
barplot(table(mtcars$cyl))


# 4) Gra proton, należy stworzyć plik R z kodami do rozwiązania gry (do 20 minut).
install.packages("proton")
library(proton)
proton()


# 5) Umieszczamy na repozytorium rozwiązanie.