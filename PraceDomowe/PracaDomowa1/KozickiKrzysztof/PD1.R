library(dplyr)

df <- read.csv("house_data.csv")
View(df)


# 1. Jaka jest �rednia cena nieruchomo�ci po�o�onych nad wod�, kt�rych jako� wyko�czenia jest r�wna lub wi�ksza od mediany jako�ci wyko�czenia?
df %>% 
  summarise(mediana = median(condition))
#mediana wynosi 3

df %>% 
  filter(waterfront == 1) %>% 
  filter(condition >= 3) %>% 
  summarise(srednia = mean(price))

# Odp:1662564


# 2. Czy nieruchomo�ci o 2 pi�trach maj� wi�ksz� (w oparciu o warto�ci mediany) liczb� �azienek ni� nieruchomo�ci o 3 pi�trach?
df %>% 
  group_by(floors) %>% 
  summarise(mediana = median(bathrooms))

# Odp:Oba maj� median� �azienek r�wn� 2,5


# 3. O ile procent wi�cej jest nieruchomo�ci le�cych na p�nocy zach�d ni�  nieruchomo�ci le��cych na po�udniowy wsch�d?
#policz� od �redniej warto�ci d�ugo�ci i szeroko�ci geograficznej
df %>% 
  summarise(szerokosc = mean(lat))
#�rednia szeroko�� geograficzna to 47.56005

df %>% 
  summarise(dlugosc = mean(long))
#�rednia d�ugo�� geograficzna to -122.2139

df %>% 
  filter(lat > 47.56005) %>% 
  filter(long < -122.2139) %>% 
  summarise(ilosc = n())
#na p�nocnym zachodzie jest 6871 nieruchomo�ci
df %>% 
  filter(lat < 47.56005) %>% 
  filter(long > -122.2139) %>% 
  summarise(ilosc = n())
#a na po�udniowym wschodzie 5299
100*(6871-5299)/5299

# Odp:O 29.66597% wi�cej


# 4. Jak zmienia�a si� (mediana) liczba �azienek dla nieruchomo�ci wybudownych w latach 90 XX wieku wzgl�dem nieruchmo�ci wybudowanych roku 2000?
df %>% 
  mutate(dekada = yr_built %/% 10) %>% 
  group_by(dekada) %>% 
  summarize(mediana = median(bathrooms)) %>% 
  tail()

# Odp:Nie zmienia�a si�, zar�wno w latach 90 jak i w latach 00, a nawet w latach 10 wynosi�a 2,5


# 5. Jak wygl�da warto�� kwartyla 0.25 oraz 0.75 jako�ci wyko�czenia nieruchomo�ci po�o�onych na p�nocy bior�c pod uwag� czy ma ona widok na wod� czy nie ma?
df %>% 
  filter(lat > 47.56005) %>% 
  filter(waterfront == 1) %>% 
  summarize(Q = quantile(condition))
#w przypadku nadwodnym jest to 3 i 4

df %>% 
  filter(lat > 47.56005) %>% 
  filter(waterfront == 0) %>% 
  summarize(Q = quantile(condition))
#w przypadku bezwodnym bezwodnym r�wnie� 3 i 4

# Odp:Niezale�nie od obecno�ci wody, dolny kwantyl ma warto�� 3, za� g�rny 4


# 6. Pod kt�rym kodem pocztowy jest po�o�onych najwi�cej nieruchomo�ci i jaki jest rozst�p miedzykwartylowy dla ceny nieruchomo�ci po�o�onych pod tym adresem?
df %>% 
  group_by(zipcode) %>% 
  summarise(ilosc = n()) %>% 
  arrange(-ilosc)
#ten kod to 98103
df %>% 
  filter(zipcode == 98103) %>% 
  summarise(Q = quantile(price))

695000-432125


# Odp:Najpopularniejszy kod pocztowy to 98103, a rozst�p mi�dzykwartylowy ceny tamtejszych nieruchomo�ci to 262875


# 7. Ile procent nieruchomo�ci ma wy�sz� �redni� powierzchni� 15 najbli�szych s�siad�w wzgl�dem swojej powierzchni?
df %>% 
  summarise(ilosc = n())
#jest 21613 nieruchomo�ci

df %>% 
  filter(sqft_living < sqft_living15) %>% 
  summarise(ilosc = n())
#9206 jest mniejszych od �redniej swoich s�siad�w
9206*100/21613

# Odp:42.59473% nieruchomo�ci ma mniejsz� �r powierzchni� ni� 15 najbli�szych s�siad�w


# 8. Jak� liczb� pokoi maj� nieruchomo�ci, kt�rych cena jest wi�ksza ni� trzeci kwartyl oraz mia�y remont w ostatnich 10 latach (pamietaj�c �e nie wiemy kiedy by�y zbierane dne) oraz zosta�y zbudowane po 1970?
df %>% 
  summarise(Q = quantile(price))
#trzeci kwartyl ceny to 645000
df %>% 
  arrange(-yr_renovated) %>% 
  select(yr_renovated) %>% 
  head()

df %>% 
  arrange(-yr_built) %>% 
  select(yr_built) %>% 
  head()

#ostatnie dane s� z 2015, wi�c za��my, �e remont wci�gu ostatnich 10 lat znaczy od 2005 wzwy�

df %>% 
  filter(yr_built > 1970) %>% 
  filter(yr_renovated > 2005) %>% 
  filter(price > 645000) %>% 
  summarise(srednia = mean(bedrooms))

# Odp: Oko�o 3,9 wynosi �rednia liczba sypialni


# 9. Patrz�c na definicj� warto�ci odstaj�cych wed�ug Tukeya (wykres boxplot) wska� ile jest warto�ci odstaj�cych wzgl�dem powierzchni nieruchomo�ci(dolna i g�rna granica warto�ci odstajacej).
df %>% 
  summarise(Q = quantile(sqft_living))
2550-1427
#dolny kwartyl to 1427, a dolny to 2550. Rozst�p mi�dzy kwartylowy to 1123.
2550+1.5*1123
2550+3*1123
1427-1.5*1123
1427-3*1123

#g�rne obserwacje odstaj�ce to te z zakresu (4234.5, 5919), a dolne to te z zakresu(-1942, -257.5), jednak jako, �e ujemna powierzchnia nie ma senu, mo�na �atwo stwierdzi�, �e dolnych obserwacji odstaj�cych nie ma
df %>% 
  filter(sqft_living > 4234.5) %>% 
  filter(sqft_living < 5919) %>% 
  summarise(ilosc = n())

# Odp: s� 498 obserwacje odstaj�ce g�rne i nie ma obserwacji odstaj�cych dolnych


# 10. W�r�d nieruchomo�ci wska� jaka jest najwi�ksz� cena za metr kwadratowy bior�c pod uwag� tylko powierzchni� mieszkaln�.
df %>% 
  mutate(metry = sqft_living*0.09290304) %>% 
  mutate(czm = price/metry) %>% 
  arrange(-czm) %>% 
  head()

# Odp:8720,26 $