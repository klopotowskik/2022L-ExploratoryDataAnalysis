library(dplyr)
df <- read.csv("house_data.csv")


# 1. Jaka jest �rednia cena nieruchomo�ci po�o�onych nad wod�, kt�rych jako� wyko�czenia jest r�wna lub wi�ksza od mediany jako�ci wyko�czenia?
df %>% 
  mutate(mediancond = median(condition)) %>% 
  filter(condition >= mediancond & waterfront == 1) %>%
  summarise(mean(price))
  

# Odp:1662564


# 2. Czy nieruchomo�ci o 2 pi�trach maj� wi�ksz� (w oparciu o warto�ci mediany) liczb� �azienek ni� nieruchomo�ci o 3 pi�trach?

df %>% 
  filter(floors == 2 | floors == 3) %>% 
  group_by(floors) %>% 
  summarise(median(bathrooms))

# Odp:Nieruchomosci o 2 pietrach nie maja wiekszej liczby lazienek niz nieruchomosci o 3 pietrach (jest taka sama).


# 3. O ile procent wi�cej jest nieruchomo�ci le�cych na p�nocy zach�d ni�  nieruchomo�ci le��cych na po�udniowy wsch�d?

df %>% 
  mutate(midlat = (max(lat)+min(lat))/2, midlong = ((max(long)+min(long))/2)) %>% 
  mutate(pos = case_when(lat > midlat & long<midlong ~ 'NW',
                         lat < midlat & long>midlong ~ 'SE',
                         TRUE ~ 'Other')) %>% 
  filter(pos == 'NW' | pos == 'SE') %>% 
  group_by(pos) %>% 
  summarise(n())
  
15677/85*100-100

# Odp:18343.53%


# 4. Jak zmienia�a si� (mediana) liczba �azienek dla nieruchomo�ci wybudownych w latach 90 XX wieku wzgl�dem nieruchmo�ci wybudowanych roku 2000?

df %>% 
  filter(yr_built>=1990 & yr_built<=2000) %>% 
  group_by(yr_built) %>% 
  summarise(median(bathrooms))
         

# Odp:Mediana liczby lazienek nie zmieniala sie.


# 5. Jak wygl�da warto�� kwartyla 0.25 oraz 0.75 jako�ci wyko�czenia nieruchomo�ci po�o�onych na p�nocy bior�c pod uwag� czy ma ona widok na wod� czy nie ma?

df %>% 
  mutate(midlat = (max(lat)+min(lat))/2) %>% 
  mutate(is_north = case_when(lat>midlat ~'N',
                               TRUE ~ 'S')) %>% 
  filter(is_north == 'N') %>% 
  group_by(waterfront) %>% 
  summarise(q025 = quantile(grade,0.25), q075 = quantile(grade,0.75))

# Odp:Z widokiem na wode: Q0.25 = 8, Q0.75 = 10, bez widoku na wode: Q0.25 = 7, Q0.75 = 8.


# 6. Pod kt�rym kodem pocztowy jest po�o�onych najwi�cej nieruchomo�ci i jaki jest rozst�p miedzykwartylowy dla ceny nieruchomo�ci po�o�onych pod tym adresem?

df %>% 
  group_by(zipcode) %>% 
  summarise(price,n = n()) %>% 
  filter(n==602) %>% 
  summarise(quantile(price,0.75)-quantile(price,0.25))

# Odp:Pod kodem pocztowym 98103, rozstep miedzykwartylowy cen polozonych tam nieruchomosci wynosi 262875.


# 7. Ile procent nieruchomo�ci ma wy�sz� �redni� powierzchni� 15 najbli�szych s�siad�w wzgl�dem swojej powierzchni?

df %>% 
  filter(sqft_living < sqft_living15) %>% 
  summarise(n = n()/nrow(df)*100)

# Odp:42.59473% nieruchomosci ma wyzsza srednia powierzchnie 15 najblizszych sasiadow wzgledem swojej powierzchni.


# 8. Jak� liczb� pokoi maj� nieruchomo�ci, kt�rych cena jest wi�ksza ni� trzeci kwartyl oraz mia�y remont w ostatnich 10 latach (pamietaj�c �e nie wiemy kiedy by�y zbierane dne) oraz zosta�y zbudowane po 1970?

df %>% 
  filter(price>quantile(price,0.75) & yr_renovated>=2012 & yr_built>1970)

# Odp:3 z tych nieruchomosci maja 3 pokoje, 1 ma 4 pokoje i 1 ma 5 pokoi.

# 9. Patrz�c na definicj� warto�ci odstaj�cych wed�ug Tukeya (wykres boxplot) wska� ile jest warto�ci odstaj�cych wzgl�dem powierzchni nieruchomo�ci(dolna i g�rna granica warto�ci odstajacej).

df %>% 
  filter(sqft_living < (quantile(sqft_living,0.25)- 1.5*(quantile(sqft_living,0.75)-quantile(sqft_living,0.25))) | sqft_living > (quantile(sqft_living,0.75)+1.5*(quantile(sqft_living,0.75)-quantile(sqft_living,0.25)))) %>% 
  summarise(n = n())
  
# Odp:Jest 572 wartosci odstajacych wzgledem powierzchni nieruchomosci.


# 10. W�r�d nieruchomo�ci wska� jaka jest najwi�ksz� cena za metr kwadratowy bior�c pod uwag� tylko powierzchni� mieszkaln�.

df %>% 
  mutate(m2 = sqft_living/10.764) %>% 
  mutate(ppm2 = price/m2) %>% 
  summarise(max(ppm2))

# Odp:Najwieksza cena za metr kwadratowy to 8720.335