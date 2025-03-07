
library(haven)
load_savfile <- read_spss("roses.sav")
saveascsv <- write.csv(load_savfile, file = "roses.csv", row.names = FALSE)
load_csvfile <-read.csv("roses.csv")
roses <- as.data.frame((load_csvfile))



library(dplyr)
library(stringi)

roses1 <- roses %>%
  select(Q18_1)

roses1 <- as.data.frame(lapply(roses1, tolower))


zawody1 <- c("informatyk", "lekarz", "psycholog", "weterynarz", "architek", "mechanik", "programist", "pi�karz",
             "naukow", "prawnik", "fotograf", "kuchar", "grafik", "t�umacz", "elektryk", "nauczyciel", "kosmety", "projektant",
             "stra�ak", "stewardess", "aktor", "dietety", "polic", "fryzjer", "kierowc", "�o�nie", "rolnik",
             "sportow", "piosenka", "cukiernik", "chirurg", "stolar", "muzyk", "sprzedawca", "dziennika", "pisar", "biolog", 
             "makija�yst", "tance", "archeolog", "fizjoterapeut", "astronaut", "prezydent", "trener", "opiekun", "wiza�", "szef",
             "farmaceut", "przewodnik", "ratownik", "chemik", "pilot", "kosmetolog", "in�ynier", "artyst", "astrofizyk",
             "detektyw", "okulista", "bokser", "szachis", "polityk", "kardiolog", "logistyk", "tapicer", "mechatronik",
             "przedszkola", "stomatolog", "dentyst", "ogrodni", "murar", "�lusar", "bank")

zawody2 <- c("informatyk", "lekarz", "psycholog", "weterynarz", "architekt", "mechanik", "programista", "pi�karz",
             "naukowiec", "prawnik", "fotograf", "kucharz", "grafik", "t�umacz", "elektryk", "nauczyciel", "makija�ysta", "projektant",
             "stra�ak", "stewardessa", "aktor", "dietetyk", "policjant", "fryzjer", "kierowca", "�o�nierz", "rolnik",
             "sportowiec", "piosenkarz", "cukiernik", "chirurg", "stolarz", "muzyk", "sprzedawca", "dziennikarz", "pisarz", "biolog", 
             "makija�ysta", "tancerz", "archeolog", "fizjoterapeuta", "astronauta", "prezydent", "trener", "opiekun", "wiza�ysta", "szef",
             "farmaceuta", "przewodnik", "ratownik", "chemik", "pilot", "kosmetolog", "in�ynier", "artysta", "astrofizyk", 
             "detektyw", "okulista", "bokser", "szachista", "polityk", "kardiolog", "logistyk", "tapicer", "mechatronik",
             "przedszkolanka", "dentysta", "dentysta", "ogrodnik", "murarz", "�lusarz", "bankier")


hmm <- rep(NA, length(roses1$Q18_1))


for (i in 1:length(zawody1)){
  for (j in which(!is.na(hmm) & stri_detect_fixed(roses1$Q18_1, zawody1[i]))){
    hmm[j] <- paste(hmm[j], zawody2[i], sep = ", ")
  }
  
  hmm[stri_detect_fixed(roses1$Q18_1, zawody1[i]) & is.na(hmm)] <- zawody2[i]
}



#dodatkowa kolumna na �adnie napisane zawodt
roses$hmm <- hmm

#Patrz� w jakich miejscach komputer nie umia� przypisa� zawodu
rameczka <- roses %>% 
  select(Q18_1 | hmm) %>% 
  filter(is.na(hmm) == TRUE) %>% 
  filter(Q18_1 != "") %>% 
  filter(stri_detect_fixed(Q18_1, "nie") == FALSE) %>% 
  filter(stri_detect_fixed(Q18_1, "Nie") == FALSE) %>% 
  filter(stri_detect_fixed(Q18_1, "NIE") == FALSE) 




#uzupe�niam r�cznie
roses$hmm[roses$Q18_1 == " Fryzierka"] <- "fryzjer"
roses$hmm[roses$Q18_1 == "Copywriterem"] <- "copywriter"
roses$hmm[roses$Q18_1 == "zatrudniona w zawodzie, gdzie potrzebna jest umiej�tno�� rysowania na r�nych urz�dzeniach i normalnie na p��tnie, kartkach"] <- "artysta"
roses$hmm[roses$Q18_1 == "co� zwi�zane z ko�mi"] <- "koniara"
roses$hmm[roses$Q18_1 == "chcia�abym otworzy� w�asny sklep, bzines"] <- "szef, sprzedawca"
roses$hmm[roses$Q18_1 == "chcialbym za�orzyc firme paleciarsk� albo ogulnobudowlan�"] <- "szef, budowlaniec"
roses$hmm[roses$Q18_1 == "Budowlanka"] <- "budowlaniec"
roses$hmm[roses$Q18_1 == "Konstruktor"] <- "budowlaniec, in�ynier"
roses$hmm[roses$Q18_1 == "Pracowa� w biurze"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "pawel jumper"] <- "pawe� jumper"
roses$hmm[roses$Q18_1 == "Infortmatykiem"] <- "informatyk"
roses$hmm[roses$Q18_1 == "Badacz kosmosu"] <- "astrofizyk"
roses$hmm[roses$Q18_1 == "Chcia�bym by� niani�"] <- "opiekun"
roses$hmm[roses$Q18_1 == "Technik Pojazd�w Samochodowych"] <- "mechanik"
roses$hmm[roses$Q18_1 == "osob� zajmuj�c� si� komputerami"] <- "informatyk"
roses$hmm[roses$Q18_1 == "Krawcow�"] <- "rzemie�lnik"
roses$hmm[roses$Q18_1 == "biznesmen"] <- "szef"
roses$hmm[roses$Q18_1 == "Ja chcia�bym by� zawodnikiem zjazdowym."] <- "sportowiec"
roses$hmm[roses$Q18_1 == "Patomorfolog/plastyk"] <- "lekarz, artysta"
roses$hmm[roses$Q18_1 == "Robotnika"] <- "robotnik"
roses$hmm[roses$Q18_1 == "Laborantem"] <- "chemik"
roses$hmm[roses$Q18_1 == "Chcia�bym Mie� firm� Budowlan�"] <- "szef, budowlaniec"
roses$hmm[roses$Q18_1 == "je�dzi� zawodowo na eowerze"] <- "sportowiec"
roses$hmm[roses$Q18_1 == "operatorem koparko-�adowarki"] <- "budowlaniec"
roses$hmm[roses$Q18_1 == "trendwatcher"] <- "socjolog"
roses$hmm[roses$Q18_1 == "Menagerem lub kierownikem jakiej� firmy"] <- "szef"
roses$hmm[roses$Q18_1 == "co� zwi�zane z biurem"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "odkrywca technologii"] <- "in�ynier"
roses$hmm[roses$Q18_1 == "sprzedawc� ubra�"] <- "sprzedawca"
roses$hmm[roses$Q18_1 == "ginekolog"] <- "lekarz"
roses$hmm[roses$Q18_1 == "podologiem"] <- "lekarz"
roses$hmm[roses$Q18_1 == "technikiem"] <- "in�ynier"
roses$hmm[roses$Q18_1 == "kelnerem/sprzedawc�"] <- "kelner, sprzedawca"
roses$hmm[roses$Q18_1 == "spedytorem"] <- "logistyk"
roses$hmm[roses$Q18_1 == "dekoratorem wn�trz"] <- "artysta"
roses$hmm[roses$Q18_1 == "florystka"] <- "biolog"
roses$hmm[roses$Q18_1 == "Badaczem banan�w"] <- "biolog"
roses$hmm[roses$Q18_1 == "Chcia�abym mie� prac� zwi�zan� z j�zykami obcymi."] <- "t�umacz"
roses$hmm[roses$Q18_1 == "Poicjantka"] <- "policjant"
roses$hmm[roses$Q18_1 == "popularnym radc� prawnym"] <- "prawnik"
roses$hmm[roses$Q18_1 == "Weterynaria"] <- "weterynarz"
roses$hmm[roses$Q18_1 == "Rolnictwo"] <- "rolnik"
roses$hmm[roses$Q18_1 == "M�j zaw�d musia�by by� powi�zany z matematyk� i rysowaniem."] <- "architekt"
roses$hmm[roses$Q18_1 == "Maryna�em"] <- "marynarz"
roses$hmm[roses$Q18_1 == "prezesem firmy"] <- "szef"
roses$hmm[roses$Q18_1 == "pracowa� na maszynach numerycznych"] <- "informatyk"
roses$hmm[roses$Q18_1 == "okulist�"] <- "lekarz"
roses$hmm[roses$Q18_1 == "bizneswoman"] <- "szef"
roses$hmm[roses$Q18_1 == "pracowa� w jaki� wi�kszych korporacjach"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "osob� kt�ra jest w styczno�ci z natur�"] <- "biolog"
roses$hmm[roses$Q18_1 == "weteryniarzem"] <- "weterynarz"
roses$hmm[roses$Q18_1 == "strazak"] <- "stra�ak"
roses$hmm[roses$Q18_1 == "poliglot�"] <- "t�umacz"
roses$hmm[roses$Q18_1 == "jeszcze do ko�ca nie wiem kim ale co� zwi�zanego ze sportem"] <- "sportowiec"
roses$hmm[roses$Q18_1 == "animatorem"] <- "animator"
roses$hmm[roses$Q18_1 == "Instruktor jazdy konnej"] <- "koniara"
roses$hmm[roses$Q18_1 == "Groomer"] <- "fryzjer"
roses$hmm[roses$Q18_1 == "tlumacz"] <- "t�umacz"
roses$hmm[roses$Q18_1 == "Sterownikiem robot�w"] <- "in�ynier"
roses$hmm[roses$Q18_1 == "Zawodniczk� siatk�wki i zajmowa� si� dzietetyk� lub pracowa� na wydziale kryminologicznym"] <- "sportowiec, dietetyk, detektyw"
roses$hmm[roses$Q18_1 == "w�a�ciciel firmy g��wnie z samochodami"] <- "szef"
roses$hmm[roses$Q18_1 == "�ledczym"] <- "detektyw"
roses$hmm[roses$Q18_1 == "Fryzierem"] <- "fryzjer"
roses$hmm[roses$Q18_1 == "Rzemie�lnik"] <- "rzemie�lnik"
roses$hmm[roses$Q18_1 == "Technik logostyk"] <- "logistyk"
roses$hmm[roses$Q18_1 == "kafelkarz"] <- "budowlaniec"
roses$hmm[roses$Q18_1 == "Perkusista metalowy"] <- "muzyk"
roses$hmm[roses$Q18_1 == "marynarzem"] <- "marynarz"
roses$hmm[roses$Q18_1 == "E-sport"] <- "sportowiec"
roses$hmm[roses$Q18_1 == "od dzieci�stwa marz� o staniu na scenie"] <- "aktor"
roses$hmm[roses$Q18_1 == "chcia�abym wykonywa� zaw�d przeczkolank�"] <- "przedszkolanka"
roses$hmm[roses$Q18_1 == "by� austrona�t�"] <- "astronauta"
roses$hmm[roses$Q18_1 == "S�dzia pi�karski"] <- "s�dzia"
roses$hmm[roses$Q18_1 == "psychiatra/patolog s�dowy/prokurator"] <- "psycholog, prawnik"
roses$hmm[roses$Q18_1 == "Tokarz"] <- "rzemie�lnik"
roses$hmm[roses$Q18_1 == "genetykiem"] <- "biolog"
roses$hmm[roses$Q18_1 == "fryzjrk�"] <- "fryzjer"
roses$hmm[roses$Q18_1 == "architrkt"] <- "architekt"
roses$hmm[roses$Q18_1 == "Pilkarz"] <- "pi�karz"
roses$hmm[roses$Q18_1 == "asystentk� w biurze"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "Weterzynarzem"] <- "weterynarz"
roses$hmm[roses$Q18_1 == "Pracownikiem w biurze"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "Le�niczym"] <- "le�niczy"
roses$hmm[roses$Q18_1 == "Wychowawc� grupy przedszkolnej"] <- "przedszkolanka"
roses$hmm[roses$Q18_1 == "Raperem"] <- "piosenkarz"
roses$hmm[roses$Q18_1 == "cz�onkiem astrofizycznej grupy badawczej lub w jaki� inny spos�b by� zwi�zan� z badaniem wrzech�wiata"] <- "astrofizyk"
roses$hmm[roses$Q18_1 == "miechanik samochodowy"] <- "mechanik"
roses$hmm[roses$Q18_1 == "Pracowa� w hotelu"] <- "hotelarz"
roses$hmm[roses$Q18_1 == "Wuefista"] <- "nauczyciel"
roses$hmm[roses$Q18_1 == "Ochroniarzem SOP"] <- "policjant"
roses$hmm[roses$Q18_1 == "Instruktork� ta�ca lub po prostu ta�cerk�"] <- "tancerz"
roses$hmm[roses$Q18_1 == "Rolnictwo/G�rnik"] <- "rolnik, g�rnik"
roses$hmm[roses$Q18_1 == "Budowlaniec"] <- "budowlaniec"
roses$hmm[roses$Q18_1 == "Raper i tyke"] <- "piosenkarz"
roses$hmm[roses$Q18_1 == "zoolog"] <- "biolog"
roses$hmm[roses$Q18_1 == "Malarka"] <- "malarz"
roses$hmm[roses$Q18_1 == "zwi�zany z technologi� lub nauk�"] <- "in�ynier"
roses$hmm[roses$Q18_1 == "Automatyk"] <- "in�ynier"
roses$hmm[roses$Q18_1 == "Chcia�abym mie� swoj� firm� lub by� jakim� managerem dobrej firmy/hotelu"] <- "szef, hotelarz"
roses$hmm[roses$Q18_1 == "Deweloperem"] <- "deweloper"
roses$hmm[roses$Q18_1 == "ekonomista"] <- "ekonomista"
roses$hmm[roses$Q18_1 == "Cyberbezpiecze�stwo"] <- "programista"
roses$hmm[roses$Q18_1 == "leka�em"] <- "lekarz"
roses$hmm[roses$Q18_1 == "Zosta� w�a�cicielem firmy wykorzystuj�cej nowe technologie."] <- "szef"
roses$hmm[roses$Q18_1 == "fizyk j�drowy/subatomowy"] <- "fizyk"
roses$hmm[roses$Q18_1 == "Instruktorka jazdy konnej"] <- "koniara"
roses$hmm[roses$Q18_1 == "W�a�ciciel du�ej firmy zajmuj�cej si� e-commerce"] <- "szef"
roses$hmm[roses$Q18_1 == "Ekonomik/ksi�gowa"] <- "ekonomista, ksi�gowy"
roses$hmm[roses$Q18_1 == "by� Rybakiem"] <- "rybak"
roses$hmm[roses$Q18_1 == "Fryzier"] <- "fryzjer"
roses$hmm[roses$Q18_1 == "geodetom"] <- "geodeta"
roses$hmm[roses$Q18_1 == "Hydraulika"] <- "hydraulik"
roses$hmm[roses$Q18_1 == "Grabiarzem"] <- "grabarz"
roses$hmm[roses$Q18_1 == "W przysz�o�ci chcia�abym zosta� dermatologiem."] <- "lekarz"
roses$hmm[roses$Q18_1 == "Lektorka"] <- "lektor"
roses$hmm[roses$Q18_1 == "Masa�"] <- "masa�ysta"
roses$hmm[roses$Q18_1 == "wojskowy"] <- "�o�nierz"
roses$hmm[roses$Q18_1 == "Psi Behawiorysta"] <- "treser"
roses$hmm[roses$Q18_1 == "weteryna�em"] <- "weterynarz"
roses$hmm[roses$Q18_1 == "rysowa� komiksy"] <- "grafik"
roses$hmm[roses$Q18_1 == "malarz"] <- "malarz"
roses$hmm[roses$Q18_1 == "medycyna estetyczna"] <- "lekarz, makija�ysta"
roses$hmm[roses$Q18_1 == "Nie wiem kim dok�adnie, ale kim� zwi�zanym z histori�"] <- "historyk"
roses$hmm[roses$Q18_1 == "Pracowa� w hodowli zwierz�t np.egzotycznych"] <- "biolog"
roses$hmm[roses$Q18_1 == "dropshipping"] <- "logistyk"
roses$hmm[roses$Q18_1 == "prowadzi� agroturystyk�"] <- "przewodnik, hotelarz"
roses$hmm[roses$Q18_1 == "Antyterroryst�"] <- "policjant"
roses$hmm[roses$Q18_1 == "kierownik budowy"] <- "szef, budowlaniec"
roses$hmm[roses$Q18_1 == "prawnkiem"] <- "prawnik"
roses$hmm[roses$Q18_1 == "gra� w najlepszym klubie w polsce jakim jest stal mielec"] <- "pi�karz"
roses$hmm[roses$Q18_1 == "co� zwi�zanego z chemi�"] <- "chemik"
roses$hmm[roses$Q18_1 == "Animatorka"] <- "animator"
roses$hmm[roses$Q18_1 == "co� z gastronomi�"] <- "kucharz"
roses$hmm[roses$Q18_1 == "mlotocyklist�"] <- "sportowiec"
roses$hmm[roses$Q18_1 == "Kim� kto jest zwi�zany z j�zykiem angielskim"] <- "t�umacz"
roses$hmm[roses$Q18_1 == "Anglistk�"] <- "nauczyciel"
roses$hmm[roses$Q18_1 == "Raper i producent muzyczny"] <- "piosenkarz"
roses$hmm[roses$Q18_1 == "Ortodontk�"] <- "dentysta"
roses$hmm[roses$Q18_1 == "Stra� po�arna"] <- "stra�ak"
roses$hmm[roses$Q18_1 == "stra�nik le�ny"] <- "le�niczy"
roses$hmm[roses$Q18_1 == "wynalasca"] <- "in�ynier"
roses$hmm[roses$Q18_1 == "Okulist�"] <- "lekarz"
roses$hmm[roses$Q18_1 == "Pracownikiem firmy"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "komornik"] <- "komornik"
roses$hmm[roses$Q18_1 == "pracownikiem salonu Audi lub innej marki samochod�w kt�ra mi si� podoba"] <- "sprzedawca"
roses$hmm[roses$Q18_1 == "Kryminologiem i kryminalistykiem"] <- "detektyw"
roses$hmm[roses$Q18_1 == "Koszykarzem"] <- "sportowiec"
roses$hmm[roses$Q18_1 == "Komik"] <- "komik"
roses$hmm[roses$Q18_1 == "Kim� kto ma co� wsp�lnego ze sportem"] <- "sportowiec"
roses$hmm[roses$Q18_1 == "Recepcjonistk�"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "ekspedientka"] <- "sprzedawca"
roses$hmm[roses$Q18_1 == "Gastronomem"] <- "kucharz"
roses$hmm[roses$Q18_1 == "Kontrolerem ruchu lotniczego"] <- "logistyk"
roses$hmm[roses$Q18_1 == "Medykiem"] <- "lekarz"
roses$hmm[roses$Q18_1 == "Chemiczk�"] <- "chemik"
roses$hmm[roses$Q18_1 == "�ledczym lub kryminologiem"] <- "detektyw"
roses$hmm[roses$Q18_1 == "diagnost� samochodowy,"] <- "mechanik"
roses$hmm[roses$Q18_1 == "elektro monter"] <- "elektryk"
roses$hmm[roses$Q18_1 == "Scenarzystk� lub psycholoszk�"] <- "pisarz, psycholog"
roses$hmm[roses$Q18_1 == "chcia�abym by� deweloperem"] <- "deweloper"
roses$hmm[roses$Q18_1 == "hydraulik"] <- "hydraulik"
roses$hmm[roses$Q18_1 == "Pi�kark�"] <- "pi�karz"
roses$hmm[roses$Q18_1 == "saperem lub snajperem"] <- "�o�nierz"
roses$hmm[roses$Q18_1 == "Adwokat"] <- "prawnik"
roses$hmm[roses$Q18_1 == "dzia�acz na rzecz ochrony  �rodowiska"] <- "ekolog"
roses$hmm[roses$Q18_1 == "Sekretar�"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "geolog"] <- "geolog"
roses$hmm[roses$Q18_1 == "ksi�gow�"] <- "ksi�gowy"
roses$hmm[roses$Q18_1 == "testerem gier komputerowych"] <- "tester"
roses$hmm[roses$Q18_1 == "niania"] <- "opiekun"
roses$hmm[roses$Q18_1 == "Pedagaog"] <- "nauczyciel"
roses$hmm[roses$Q18_1 == "solista/dyrygent"] <- "muzyk"
roses$hmm[roses$Q18_1 == "badaczem kosmosu"] <- "astrofizyk"
roses$hmm[roses$Q18_1 == "strzelcem wyborowym si� specjalnych"] <- "�o�nierz"
roses$hmm[roses$Q18_1 == "Oficerem"] <- "�o�nierz"
roses$hmm[roses$Q18_1 == "Ksi�gow�"] <- "ksi�gowy"
roses$hmm[roses$Q18_1 == "floryst�"] <- "biolog"
roses$hmm[roses$Q18_1 == "Polonista/ Humanista"] <- "nauczyciel"
roses$hmm[roses$Q18_1 == "hotelark�"] <- "hotelarz"
roses$hmm[roses$Q18_1 == "Astronem"] <- "astrofizyk"
roses$hmm[roses$Q18_1 == "Raperem"] <- "piosenkarz"
roses$hmm[roses$Q18_1 == "menad�er lub w rejestracji"] <- "szef"
roses$hmm[roses$Q18_1 == "Nie wiem jeszcze, ale zastanawiam si� nad prawem."] <- "prawnik"
roses$hmm[roses$Q18_1 == "Specjalista do spraw transportu"] <- "logistyk"
roses$hmm[roses$Q18_1 == "g�ownie militaria konstruktor pojazd�w"] <- "in�ynier"
roses$hmm[roses$Q18_1 == "Mangaka, Animator"] <- "grafik, animator"
roses$hmm[roses$Q18_1 == "kierownikiem apteki"] <- "szef, farmaceuta"
roses$hmm[roses$Q18_1 == "tw�rc� gier komputerowych"] <- "programista"
roses$hmm[roses$Q18_1 == "Tatua�ysta"] <- "makija�ysta"
roses$hmm[roses$Q18_1 == "Kosmona�ta"] <- "astronauta"
roses$hmm[roses$Q18_1 == "Chcialabym pracowac w wojsku"] <- "�o�nierz"
roses$hmm[roses$Q18_1 == "Rysownik/Malarz"] <- "malarz"
roses$hmm[roses$Q18_1 == "wojskowym."] <- "�o�nierz"
roses$hmm[roses$Q18_1 == "Spawacz"] <- "spawacz"
roses$hmm[roses$Q18_1 == "Najlepiej kim� po technikum ekonomistycznym"] <- "ekonomista"
roses$hmm[roses$Q18_1 == "Psychiatra"] <- "psycholog"
roses$hmm[roses$Q18_1 == "Biznes woman"] <- "szef"
roses$hmm[roses$Q18_1 == "Infomatykiem"] <- "informatyk"
roses$hmm[roses$Q18_1 == "stra�nikiem granicznym"] <- "policjant"
roses$hmm[roses$Q18_1 == "Projektowa� reklamy"] <- "grafik"
roses$hmm[roses$Q18_1 == "Spawa�"] <- "spawacz"
roses$hmm[roses$Q18_1 == "ksi�gowym"] <- "ksi�gowy"
roses$hmm[roses$Q18_1 == "W korporacji"] <- "pracownik biurowy"
roses$hmm[roses$Q18_1 == "Fizykiem"] <- "fizyk"
roses$hmm[roses$Q18_1 == "astronomem."] <- "astrofizyk"


#dok�adam kategorie pod zawody (umys�owy, fizyczny, nauka, rozrywka)
zawody <- c("informatyk", "lekarz", "psycholog", "weterynarz", "architekt", "mechanik", "programista", "pi�karz", "naukowiec", "prawnik",
            "fotograf", "kucharz", "grafik", "t�umacz", "elektryk", "nauczyciel", "kosmetyczka", "projektant", "stra�ak", "stewardessa",
            "aktor", "dietetyk", "policjant", "fryzjer", "kierowca", "�o�nierz", "rolnik", "sportowiec", "piosenkarz", "cukiernik",
            "chirurg", "stolarz", "muzyk", "sprzedawca", "dziennikarz", "pisarz", "biolog", "makija�ysta", "tancerz", "archeolog",
            "fizjoterapeuta", "astronauta", "prezydent", "trener", "opiekun", "wiza�ysta", "szef", "farmaceuta", "przewodnik", "ratownik",
            "chemik", "pilot", "masa�ysta", "kosmetolog", "in�ynier", "artysta", "astrofizyk", "detektyw", "okulista", "bokser", "szachista", "polityk",
            "kardiolog", "logistyk", "tapicer", "mechatronik", "przedszkolank", "dentysta", "ogrodnik", "murarz", "�lusarz", "bankier",
            "copywriter", "koniara", "budowlaniec", "pracownik biurowy", "pawe� jumper", "rzemie�lnik", "robotnik", "marynarz", "socjolog", 
            "animator", "s�dzia", "fizyk", "le�niczy", "hotelarz", "malarz", "deweloper", "ekonomista", "rybak", "geodeta", "hydraulik",
            "grabarz", "lektor", "treser", "historyk", "komornik", "komik", "ekolog", "geolog", "ksi�gowy", "tester", "spawacz")
length(zawody)
kategorie <- c("umys�owy", "umys�owy", "umys�owy", "umys�owy", "umys�owy", "fizyczny", "umys�owy", "rozrywka", "nauka", "umys�owy", "nauka",
               "rozrywka", "umys�owy", "umys�owy", "umys�owy", "umys�owy", "rozrywka", "rozrywka", "fizyczny", "fizyczny", "rozrywka",
               "umys�owy", "fizyczny", "rozrywka", "fizyczny", "fizyczny", "fizyczny", "rozrywka", "rozrywka", "rozrywka", "umys�owy",
               "fizyczny", "rozrywka", "umys�owy", "umys�owy", "rozrywka", "nauka", "rozrywka", "rozrywka", "nauka", "umys�owy",
               "umys�owy", "umys�owy", "rozrywka", "fizyczny", "rozrywka", "umys�owy", "umys�owy", "fizyczny", "fizyczny", "nauka",
               "umys�owy", "rozrywka", "umys�owy", "rozrywka", "nauka", "umys�owy", "umys�owy", "rozrywka", "rozrywka", "umys�owy",
               "umys�owy","umys�owy", "fizyczny", "umys�owy", "fizyczny", "umys�owy", "fizyczny", "fizyczny", "fizyczny", "umys�owy",
               "umys�owy", "rozrywka", "fizyczny", "umys�owy", "rozrywka", "fizyczny", "fizyczny", "fizyczny", "nauka", "rozrywka",
               "rozrywka", "nauka", "fizyczny", "rozrywka", "rozrywka", "umys�owy", "nauka", "fizyczny", "umys�owy", "fizyczny", "fizyczny",
               "rozrywka", "rozrywka", "rozrywka", "nauka", "umys�owy", "rozrywka", "nauka", "nauka", "umys�owy", "rozrywka", "fizyczny")
length(kategorie)

kategoria <- rep(NA, length(roses$hmm))


for (i in 1:length(zawody)){
  for (j in which(!is.na(kategoria) & stri_detect_fixed(roses$hmm, zawody[i]))){
    kategoria[j] <- paste(kategoria[j], kategorie[i], sep = ", ")
  }
  
  kategoria[stri_detect_fixed(roses$hmm, zawody[i]) & is.na(kategoria)] <- kategorie[i]
}



#dodatkowa kolumna na kategorie
roses$kategoria <- kategoria




roses$Q18_1 <- tolower(roses$Q18_1)
roses$hmm[stri_detect_fixed(roses$Q18_1, "nie") & is.na(roses$hmm) & roses$Q18_1 != "uczniem" & roses$Q18_1 != "jebanie disa"] <- "nie wiem"

rameczka <- roses %>% 
  select(Q18_1 | hmm) %>% 
  filter(is.na(hmm) == TRUE) %>% 
  filter(Q18_1 != "") 

roses$hmm[(stri_detect_fixed(roses$Q18_1, "zastanawiam") |  roses$Q18_1 == "nwm" | roses$Q18_1 == "jeszcze nw")& is.na(roses$hmm)] <- "nie wiem"





write.csv(roses, file = "roses_1.csv")

