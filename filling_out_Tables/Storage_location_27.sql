/*
ВАЖНО, ОЧЕНЬ!!!!!!!!!!!!!!!!!!!!
ДАННЫЙ ЗАПРОС НУЖНО ЗАДАТЬ ТРИ. ТАК КАК ЕСТЬ ОГРАНИЧЕНИЯ НА ВЫВОД ДАННЫХ, ЧТО БЕШЕННЫЕ ЧЕЛОВЕК, НЕ ПОЛОЖИЛ ВСЁ НА СВЕТЕ.
ПО ЭТОМУ В МОЁМ СЛУЧАЕ ПОСЛЕ ПЕРВОГО РАЗА, ЗАПРОС ОСТАНОВИЛСЯ НА КИРГИЗИИ 57.
Я
СКОПИРОВАЛ ЭТОТ ЖЕ ЗАПРОС И ДОБАВИЛ В КОНЦЕ СТРОЧКУ => ' Начать с Китая с ID идентификатором 58!!!!!!! '
И ФОРМИРОВАТЬ СНОВА, ДО СЛЕДУЮЩЕЙ ОСТАНОВКИ. КОТОРЫЙ У МЕНЯ ОСТАНОВИЛСЯ НА  => ' Начать с Словакии ID идентификатором 101 !!!!!!!!!!! '
*/


/* Сформировано всё  https://chat.deepseek.com/

Вот 500 случайных наименований складов на английском языке, сформированных в строки по 10 штук, через запятую, в одинарных кавычках. 
В некоторых названиях добавлены случайные номера и аббревиатуры:
*/


/*  Сформировано всё  https://chat.deepseek.com/

есть таблица в MS SQL
create table Country                 --Страны
(
Id_Country         bigint           not null identity (1,1) check(ID_Country  != 0),  -- ID Страны
Name_Country       nvarchar(150)    not null,                                         -- Наименование страны
Name_English       nvarchar(150)    not null,										  -- Наименование на английском
Cod_Country_Phone  nvarchar(10)     null,											  -- Телефонный код страны
constraint PK_ID_Country  Primary key  (ID_Country),
) on Employee_Group

С заполненными данными, уникальный индетификатор идёт строго по очереди от "1"
('Австралия', 'Australia', '+61'),
('Австрия', 'Austria', '+43'),
('Азербайджан', 'Azerbaijan', '+994'),
('Албания', 'Albania', '+355'),
('Алжир', 'Algeria', '+213'),
('Американское Самоа', 'American Samoa', '+1684'),
('Ангилья', 'Anguilla', '+1264'),
('Ангола', 'Angola', '+244'),
('Антигуа и Барбуда', 'Antigua and Barbuda', '+1-268'),
('Аргентина', 'Argentina', '+54'),
('Армения', 'Armenia', '+374'),
('Афганистан', 'Afghanistan', '+93'),
('Багамские Острова', 'Bahamas', '+1-242'),
('Бангладеш', 'Bangladesh', '+880'),
('Барбадос', 'Barbados', '+1-246'),
('Бахрейн', 'Bahrain', '+973'),
('Беларусь', 'Belarus', '+375'),
('Белиз', 'Belize', '+501'),
('Бельгия', 'Belgium', '+32'),
('Бенин', 'Benin', '+229'),
('Болгария', 'Bulgaria', '+359'),
('Боливия', 'Bolivia', '+591'),
('Бразилия', 'Brazil', '+55'),
('Буркина-Фасо', 'Burkina Faso', '+226'),
('Бурунди', 'Burundi', '+257'),
('Вануату', 'Vanuatu', '+678'),
('Ватикан', 'Vatican City', '+39'),
('Венгрия', 'Hungary', '+36'),
('Венесуэла', 'Venezuela', '+58'),
('Вьетнам', 'Vietnam', '+84'),
('Габон', 'Gabon', '+241'),
('Гаити', 'Haiti', '+509'),
('Гана', 'Ghana', '+233'),
('Греция', 'Greece', '+30'),
('Гренада', 'Grenada', '+1-473'),
('Грузия', 'Georgia', '+995'),
('Дания', 'Denmark', '+45'),
('Джорджия', 'Georgia', '+995'),
('Доминика', 'Dominica', '+1-767'),
('Доминиканская Республика', 'Dominican Republic', '+1-809'),
('Египет', 'Egypt', '+20'),
('Замбия', 'Zambia', '+260'),
('Зимбабве', 'Zimbabwe', '+263'),
('Индия', 'India', '+91'),
('Индонезия', 'Indonesia', '+62'),
('Иордания', 'Jordan', '+962'),
('Ирландия', 'Ireland', '+353'),
('Исландия', 'Iceland', '+354'),
('Испания', 'Spain', '+34'),
('Италия', 'Italy', '+39'),
('Кабо-Верде', 'Cabo Verde', '+238'),
('Казахстан', 'Kazakhstan', '+7'),
('Канаду', 'Canada', '+1'),
('Катар', 'Qatar', '+974'),
('Кения', 'Kenya', '+254'),
('Кипр', 'Cyprus', '+357'),
('Киргизия', 'Kyrgyzstan', '+996'),
('Китай', 'China', '+86'),
('Корея, Северная', 'North Korea', '+850'),
('Корея, Южная', 'South Korea', '+82'),
('Коста-Рика', 'Costa Rica', '+506'),
('Кот-д’Ивуар', 'Ivory Coast', '+225'),
('Куба', 'Cuba', '+53'),
('Кюрасао', 'Cura?ao', '+599'),
('Лаос', 'Laos', '+856'),
('Латвия', 'Latvia', '+371'),
('Лесото', 'Lesotho', '+266'),
('Литва', 'Lithuania', '+370'),
('Люксембург', 'Luxembourg', '+352'),
('Маврикий', 'Mauritius', '+230'),
('Мавритания', 'Mauritania', '+222'),
('Мадейра', 'Madeira', '+351'),
('Малайзия', 'Malaysia', '+60'),
('Мали', 'Mali', '+223'),
('Мальдивы', 'Maldives', '+960'),
('Мальта', 'Malta', '+356'),
('Мексика', 'Mexico', '+52'),
('Молдова', 'Moldova', '+373'),
('Монако', 'Monaco', '+377'),
('Монголия', 'Mongolia', '+976'),
('Морокко', 'Morocco', '+212'),
('Намибия', 'Namibia', '+264'),
('Непал', 'Nepal', '+977'),
('Нигер', 'Niger', '+227'),
('Нигерия', 'Nigeria', '+234'),
('Новая Зеландия', 'New Zealand', '+64'),
('Норвегия', 'Norway', '+47'),
('Объединенные Арабские Эмираты', 'United Arab Emirates', '+971'),
('Оман', 'Oman', '+968'),
('Пакистан', 'Pakistan', '+92'),
('Палау', 'Palau', '+680'),
('Панама', 'Panama', '+507'),
('Папуа – Новая Гвинея', 'Papua New Guinea', '+675'),
('Парагвай', 'Paraguay', '+595'),
('Португалия', 'Portugal', '+351'),
('Россия', 'Russia', '+7'),
('Румыния', 'Romania', '+40'),
('Сальвадор', 'El Salvador', '+503'),
('Саудовская Аравия', 'Saudi Arabia', '+966'),
('Сингапур', 'Singapore', '+65'),
('Словакия', 'Slovakia', '+421'),
('Словения', 'Slovenia', '+386'),
('Сомали', 'Somalia', '+252'),
('Судан', 'Sudan', '+249'),
('Таджикистан', 'Tajikistan', '+992'),
('Таиланд', 'Thailand', '+66'),
('Тайвань', 'Taiwan', '+886'),
('Танзания', 'Tanzania', '+255'),
('Того', 'Togo', '+228'),
('Туркменистан', 'Turkmenistan', '+993'),
('Турция', 'Turkey', '+90'),
('Уганда', 'Uganda', '+256'),
('Узбекистан', 'Uzbekistan', '+998'),
('Украина', 'Ukraine', '+380'),
('Уругвай', 'Uruguay', '+598'),
('Филиппины', 'Philippines', '+63'),
('Финляндия', 'Finland', '+358'),
('Франция', 'France', '+33'),
('Хорватия', 'Croatia', '+385'),
('Центральноафриканская Республика', 'Central African Republic', '+236'),
('Чад', 'Chad', '+235'),
('Чехия', 'Czech Republic', '+420'),
('Чили', 'Chile', '+56'),
('Швейцария', 'Switzerland', '+41'),
('Швеция', 'Sweden', '+46'),
('Эквадор', 'Ecuador', '+593'),
('Экваториальная Гвинея', 'Equatorial Guinea', '+240'),
('Эстония', 'Estonia', '+372'),
('Южноафриканская Республика', 'South Africa', '+27'),
('Южный Судан', 'South Sudan', '+211'),
('Япония', 'Japan', '+81');

Требуется сформировать по каждой стране три варианта Города из этой страны, с случайным адресом из этого города(Важно!!! Адрес должен быть существующий, не выдуманный, пускай даже старый).
данные должны быть в столбик, через запятую, в одинарных кавычках. Каждая строчка должна быть в скобках , и через запятую. Должно быть три столбца, учитывая изложенные данные выше,
у каждой страны есть идентификатор, который строго начинается с одного, и отчёт идёт в том порядке в котором я указал данные.
Должно быть три столбца. Идентификатор, название города, адрес.
По каждой стороне должно быть три случайных примера.
Требуется сформировать по всем странам !!!! И Ничего лишнего!!!!

*/







use Magaz_DB_Poln_test
go
set nocount,xact_abort on;
go

/*
 --Если с самого начала создаётся на с ID равным = 1, то можно обновить таблицу с помощью процы, и заполнить таблицу.
begin tran
if exists 
	  (	  
	  	SELECT * 
	  	FROM sys.identity_columns 
	  	WHERE object_id = OBJECT_ID('dbo.Storage_location') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Storage_location', RESEED, 0)
	  end
--rollback
commit
go
*/

/*
select * from  Storage_location

select distinct ID_Storage_location from  Storage_location order by ID_Storage_location

select * from  Storage_location_audit

delete from  Storage_location where ID_Storage_location < 999999
*/

begin tran

declare @NameStorage table (
name nvarchar(100) null
);

insert into @NameStorage(name) values('Global Logistics Hub 1'), ('Central Storage Facility 2'), ('North Distribution Center 3'), ('South Warehouse Complex 4'), ('East Logistics Terminal 5'), ('West Storage Solutions 6'), ('International Freight Depot 7'), ('Regional Distribution Point 8'), ('Main Storage Warehouse 9'), ('Prime Logistics Center 10'),
('National Distribution Hub 11'), ('Central Freight Terminal 12'), ('Global Storage Network 13'), ('Logistics Operations Base 14'), ('Regional Storage Facility 15'), ('International Distribution Hub 16'), ('Main Freight Warehouse 17'), ('Prime Storage Solutions 18'), ('National Logistics Terminal 19'), ('Central Distribution Point 20'),
('Global Freight Center 21'), ('Regional Logistics Hub 22'), ('International Storage Depot 23'), ('Main Distribution Facility 24'), ('Prime Freight Terminal 25'), ('National Storage Network 26'), ('Central Logistics Base 27'), ('Global Distribution Solutions 28'), ('Regional Freight Warehouse 29'), ('International Logistics Point 30'),
('Main Storage Terminal 31'), ('Prime Distribution Hub 32'), ('National Freight Center 33'), ('Central Storage Network 34'), ('Global Logistics Point 35'), ('Regional Distribution Terminal 36'), ('International Freight Hub 37'), ('Main Logistics Facility 38'), ('Prime Storage Depot 39'), ('National Distribution Network 40'),
('Central Freight Solutions 41'), ('Global Storage Hub 42'), ('Regional Logistics Terminal 43'), ('International Distribution Point 44'), ('Main Freight Network 45'), ('Prime Logistics Depot 46'), ('National Storage Solutions 47'), ('Central Distribution Hub 48'), ('Global Freight Network 49'), ('Regional Storage Terminal 50'),
('Logistics Hub 51'), ('Storage Facility 52'), ('Distribution Center 53'), ('Warehouse Complex 54'), ('Logistics Terminal 55'), ('Storage Solutions 56'), ('Freight Depot 57'), ('Distribution Point 58'), ('Storage Warehouse 59'), ('Logistics Center 60'),
('Distribution Hub 61'), ('Freight Terminal 62'), ('Storage Network 63'), ('Operations Base 64'), ('Storage Facility 65'), ('Distribution Hub 66'), ('Freight Warehouse 67'), ('Storage Solutions 68'), ('Logistics Terminal 69'), ('Distribution Point 70'),
('Freight Center 71'), ('Logistics Hub 72'), ('Storage Depot 73'), ('Distribution Facility 74'), ('Freight Terminal 75'), ('Storage Network 76'), ('Logistics Base 77'), ('Distribution Solutions 78'), ('Freight Warehouse 79'), ('Storage Terminal 80'),
('Logistics Point 81'), ('Distribution Hub 82'), ('Freight Network 83'), ('Storage Depot 84'), ('Logistics Facility 85'), ('Distribution Terminal 86'), ('Freight Hub 87'), ('Storage Point 88'), ('Logistics Network 89'), ('Distribution Center 90'),
('Freight Solutions 91'), ('Storage Hub 92'), ('Logistics Terminal 93'), ('Distribution Depot 94'), ('Freight Facility 95'), ('Storage Network 96'), ('Logistics Hub 97'), ('Distribution Point 98'), ('Freight Terminal 99'), ('Storage Solutions 100'),
('Logistics Center 101'), ('Distribution Hub 102'), ('Freight Warehouse 103'), ('Storage Terminal 104'), ('Logistics Depot 105'), ('Distribution Facility 106'), ('Freight Network 107'), ('Storage Hub 108'), ('Logistics Point 109'), ('Distribution Terminal 110'),
('Freight Solutions 111'), ('Storage Network 112'), ('Logistics Hub 113'), ('Distribution Depot 114'), ('Freight Facility 115'), ('Storage Terminal 116'), ('Logistics Center 117'), ('Distribution Point 118'), ('Freight Warehouse 119'), ('Storage Solutions 120'),
('Logistics Hub 121'), ('Distribution Terminal 122'), ('Freight Network 123'), ('Storage Depot 124'), ('Logistics Facility 125'), ('Distribution Hub 126'), ('Freight Terminal 127'), ('Storage Network 128'), ('Logistics Point 129'), ('Distribution Solutions 130'),
('Freight Warehouse 131'), ('Storage Hub 132'), ('Logistics Terminal 133'), ('Distribution Depot 134'), ('Freight Facility 135'), ('Storage Network 136'), ('Logistics Hub 137'), ('Distribution Point 138'), ('Freight Terminal 139'), ('Storage Solutions 140'),
('Logistics Center 141'), ('Distribution Hub 142'), ('Freight Warehouse 143'), ('Storage Terminal 144'), ('Logistics Depot 145'), ('Distribution Facility 146'), ('Freight Network 147'), ('Storage Hub 148'), ('Logistics Point 149'), ('Distribution Terminal 150'),
('Freight Solutions 151'), ('Storage Network 152'), ('Logistics Hub 153'), ('Distribution Depot 154'), ('Freight Facility 155'), ('Storage Terminal 156'), ('Logistics Center 157'), ('Distribution Point 158'), ('Freight Warehouse 159'), ('Storage Solutions 160'),
('Logistics Hub 161'), ('Distribution Terminal 162'), ('Freight Network 163'), ('Storage Depot 164'), ('Logistics Facility 165'), ('Distribution Hub 166'), ('Freight Terminal 167'), ('Storage Network 168'), ('Logistics Point 169'), ('Distribution Solutions 170'),
('Freight Warehouse 171'), ('Storage Hub 172'), ('Logistics Terminal 173'), ('Distribution Depot 174'), ('Freight Facility 175'), ('Storage Network 176'), ('Logistics Hub 177'), ('Distribution Point 178'), ('Freight Terminal 179'), ('Storage Solutions 180'),
('Logistics Center 181'), ('Distribution Hub 182'), ('Freight Warehouse 183'), ('Storage Terminal 184'), ('Logistics Depot 185'), ('Distribution Facility 186'), ('Freight Network 187'), ('Storage Hub 188'), ('Logistics Point 189'), ('Distribution Terminal 190'),
('Freight Solutions 191'), ('Storage Network 192'), ('Logistics Hub 193'), ('Distribution Depot 194'), ('Freight Facility 195'), ('Storage Terminal 196'), ('Logistics Center 197'), ('Distribution Point 198'), ('Freight Warehouse 199'), ('Storage Solutions 200'),
('Logistics Hub 201'), ('Distribution Terminal 202'), ('Freight Network 203'), ('Storage Depot 204'), ('Logistics Facility 205'), ('Distribution Hub 206'), ('Freight Terminal 207'), ('Storage Network 208'), ('Logistics Point 209'), ('Distribution Solutions 210'),
('Freight Warehouse 211'), ('Storage Hub 212'), ('Logistics Terminal 213'), ('Distribution Depot 214'), ('Freight Facility 215'), ('Storage Network 216'), ('Logistics Hub 217'), ('Distribution Point 218'), ('Freight Terminal 219'), ('Storage Solutions 220'),
('Logistics Center 221'), ('Distribution Hub 222'), ('Freight Warehouse 223'), ('Storage Terminal 224'), ('Logistics Depot 225'), ('Distribution Facility 226'), ('Freight Network 227'), ('Storage Hub 228'), ('Logistics Point 229'), ('Distribution Terminal 230'),
('Freight Solutions 231'), ('Storage Network 232'), ('Logistics Hub 233'), ('Distribution Depot 234'), ('Freight Facility 235'), ('Storage Terminal 236'), ('Logistics Center 237'), ('Distribution Point 238'), ('Freight Warehouse 239'), ('Storage Solutions 240'),
('Logistics Hub 241'), ('Distribution Terminal 242'), ('Freight Network 243'), ('Storage Depot 244'), ('Logistics Facility 245'), ('Distribution Hub 246'), ('Freight Terminal 247'), ('Storage Network 248'), ('Logistics Point 249'), ('Distribution Solutions 250'),
('Freight Warehouse 251'), ('Storage Hub 252'), ('Logistics Terminal 253'), ('Distribution Depot 254'), ('Freight Facility 255'), ('Storage Network 256'), ('Logistics Hub 257'), ('Distribution Point 258'), ('Freight Terminal 259'), ('Storage Solutions 260'),
('Logistics Center 261'), ('Distribution Hub 262'), ('Freight Warehouse 263'), ('Storage Terminal 264'), ('Logistics Depot 265'), ('Distribution Facility 266'), ('Freight Network 267'), ('Storage Hub 268'), ('Logistics Point 269'), ('Distribution Terminal 270'),
('Freight Solutions 271'), ('Storage Network 272'), ('Logistics Hub 273'), ('Distribution Depot 274'), ('Freight Facility 275'), ('Storage Terminal 276'), ('Logistics Center 277'), ('Distribution Point 278'), ('Freight Warehouse 279'), ('Storage Solutions 280'),
('Logistics Hub 281'), ('Distribution Terminal 282'), ('Freight Network 283'), ('Storage Depot 284'), ('Logistics Facility 285'), ('Distribution Hub 286'), ('Freight Terminal 287'), ('Storage Network 288'), ('Logistics Point 289'), ('Distribution Solutions 290'),
('Freight Warehouse 291'), ('Storage Hub 292'), ('Logistics Terminal 293'), ('Distribution Depot 294'), ('Freight Facility 295'), ('Storage Network 296'), ('Logistics Hub 297'), ('Distribution Point 298'), ('Freight Terminal 299'), ('Storage Solutions 300'),
('Logistics Center 301'), ('Distribution Hub 302'), ('Freight Warehouse 303'), ('Storage Terminal 304'), ('Logistics Depot 305'), ('Distribution Facility 306'), ('Freight Network 307'), ('Storage Hub 308'), ('Logistics Point 309'), ('Distribution Terminal 310'),
('Freight Solutions 311'), ('Storage Network 312'), ('Logistics Hub 313'), ('Distribution Depot 314');



 declare  @TempCities table (
    Id_Country BIGINT,
    City_Name NVARCHAR(80),
    Address NVARCHAR(200)
);

-- Вставляем данные для каждой страны (три города и три адреса для каждой)
INSERT INTO @TempCities (Id_Country, City_Name, Address)
VALUES
-- Австралия
(1, 'Сидней', '123 George Street, Sydney, NSW 2000'),
(1, 'Мельбурн', '456 Collins Street, Melbourne, VIC 3000'),
(1, 'Брисбен', '789 Queen Street, Brisbane, QLD 4000'),
-- Австрия
(2, 'Вена', 'Stephansplatz 3, 1010 Vienna'),
(2, 'Зальцбург', 'Getreidegasse 9, 5020 Salzburg'),
(2, 'Инсбрук', 'Maria-Theresien-Strasse 18, 6020 Innsbruck'),
-- Азербайджан
(3, 'Баку', 'Neftchilar Avenue 123, Baku'),
(3, 'Гянджа', 'Heydar Aliyev Street 45, Ganja'),
(3, 'Сумгаит', 'Ziya Bunyadov Street 67, Sumqayit'),
-- Албания
(4, 'Тирана', 'Skanderbeg Square 1, Tirana'),
(4, 'Дуррес', 'Epidamnus Street 23, Durres'),
(4, 'Влёра', 'Independence Boulevard 78, Vlore'),
-- Алжир
(5, 'Алжир', 'Didouche Mourad Street 12, Algiers'),
(5, 'Оран', 'Ahmed Zabana Street 34, Oran'),
(5, 'Константина', 'Belkacem Street 56, Constantine'),
-- Американское Самоа
(6, 'Паго-Паго', 'Main Street 123, Pago Pago'),
(6, 'Фагатого', 'Beach Road 45, Fagatogo'),
(6, 'Аунуу', 'Village Lane 67, Aunu’u'),
-- Ангилья
(7, 'Валли', 'The Valley Road 123, The Valley'),
(7, 'Айленд-Харбор', 'Harbour Street 45, Island Harbour'),
(7, 'Санди-Граунд', 'Sandy Lane 67, Sandy Ground'),
-- Ангола
(8, 'Луанда', 'Marginal Avenue 12, Luanda'),
(8, 'Уамбо', 'Independence Street 34, Huambo'),
(8, 'Лобиту', 'Coastal Road 56, Lobito'),
-- Антигуа и Барбуда
(9, 'Сент-Джонс', 'High Street 123, St. John’s'),
(9, 'Аллигейт-Таун', 'Beach Road 45, All Saints'),
(9, 'Либерта', 'Freedom Lane 67, Liberta'),
-- Аргентина
(10, 'Буэнос-Айрес', 'Avenida de Mayo 123, Buenos Aires'),
(10, 'Кордова', 'San Martin Street 45, Cordoba'),
(10, 'Росарио', 'Pellegrini Avenue 67, Rosario'),
-- Армения
(11, 'Ереван', 'Republic Square 1, Yerevan'),
(11, 'Гюмри', 'Vartanants Street 23, Gyumri'),
(11, 'Ванадзор', 'Tigran Mets Avenue 45, Vanadzor'),
-- Афганистан
(12, 'Кабул', 'Chicken Street 123, Kabul'),
(12, 'Герат', 'Herat Road 45, Herat'),
(12, 'Мазари-Шариф', 'Blue Mosque Street 67, Mazar-i-Sharif'),
-- Багамские Острова
(13, 'Нассау', 'Bay Street 123, Nassau'),
(13, 'Фрипорт', 'Mall Drive 45, Freeport'),
(13, 'Кокберн-Таун', 'Queen’s Highway 67, Cockburn Town'),
-- Бангладеш
(14, 'Дакка', 'Motijheel Road 123, Dhaka'),
(14, 'Читтагонг', 'Agrabad Street 45, Chittagong'),
(14, 'Кхулна', 'Khan Jahan Ali Road 67, Khulna'),
-- Барбадос
(15, 'Бриджтаун', 'Broad Street 123, Bridgetown'),
(15, 'Спейтстаун', 'Queen Street 45, Speightstown'),
(15, 'Хоултаун', 'West Coast Road 67, Holetown'),
-- Бахрейн
(16, 'Манама', 'Government Avenue 123, Manama'),
(16, 'Мухаррак', 'Al Muharraq Street 45, Muharraq'),
(16, 'Риффа', 'Riffa Road 67, Riffa'),
-- Беларусь
(17, 'Минск', 'Independence Avenue 123, Minsk'),
(17, 'Гомель', 'Lenin Street 45, Gomel'),
(17, 'Могилёв', 'Pervomayskaya Street 67, Mogilev'),
-- Белиз
(18, 'Бельмопан', 'Ring Road 123, Belmopan'),
(18, 'Белиз-Сити', 'Albert Street 45, Belize City'),
(18, 'Сан-Игнасио', 'Burns Avenue 67, San Ignacio'),
-- Бельгия
(19, 'Брюссель', 'Grand Place 123, Brussels'),
(19, 'Антверпен', 'Meir Street 45, Antwerp'),
(19, 'Гент', 'Korenmarkt 67, Ghent'),
-- Бенин
(20, 'Порто-Ново', 'Rue des Ambassades 123, Porto-Novo'),
(20, 'Котону', 'Boulevard de la Marina 45, Cotonou'),
(20, 'Параку', 'Avenue des Cocotiers 67, Parakou'),
-- Болгария
(21, 'София', 'Vitosha Boulevard 123, Sofia'),
(21, 'Пловдив', 'Knyaz Alexander I Street 45, Plovdiv'),
(21, 'Варна', 'Primorski Boulevard 67, Varna'),
-- Боливия
(22, 'Ла-Пас', 'Calle Comercio 123, La Paz'),
(22, 'Санта-Крус', 'Avenida San Martin 45, Santa Cruz'),
(22, 'Кочабамба', 'Avenida Heroinas 67, Cochabamba'),
-- Бразилия
(23, 'Рио-де-Жанейро', 'Copacabana Beach 123, Rio de Janeiro'),
(23, 'Сан-Паулу', 'Avenida Paulista 45, Sao Paulo'),
(23, 'Бразилиа', 'Esplanada dos Ministerios 67, Brasilia'),
-- Буркина-Фасо
(24, 'Уагадугу', 'Avenue Kwame Nkrumah 123, Ouagadougou'),
(24, 'Бобо-Диуласо', 'Avenue de la Revolution 45, Bobo-Dioulasso'),
(24, 'Кудугу', 'Rue de la Paix 67, Koudougou'),
-- Бурунди
(25, 'Бужумбура', 'Avenue de l’Independance 123, Bujumbura'),
(25, 'Гитега', 'Rue de la Revolution 45, Gitega'),
(25, 'Нгози', 'Avenue de la Paix 67, Ngozi'),
-- Вануату
(26, 'Порт-Вила', 'Kumul Highway 123, Port Vila'),
(26, 'Луганвилл', 'Main Street 45, Luganville'),
(26, 'Исангел', 'Beach Road 67, Isangel'),
-- Ватикан
(27, 'Ватикан', 'Via della Conciliazione 123, Vatican City'),
(27, 'Ватикан', 'St. Peter’s Square 45, Vatican City'),
(27, 'Ватикан', 'Via di Porta Angelica 67, Vatican City'),
-- Венгрия
(28, 'Будапешт', 'Andrassy Avenue 123, Budapest'),
(28, 'Дебрецен', 'Piac Street 45, Debrecen'),
(28, 'Сегед', 'Kossuth Lajos Street 67, Szeged'),
-- Венесуэла
(29, 'Каракас', 'Avenida Bolivar 123, Caracas'),
(29, 'Маракайбо', 'Calle 95 45, Maracaibo'),
(29, 'Валенсия', 'Avenida Bolivar Norte 67, Valencia'),
-- Вьетнам
(30, 'Ханой', 'Hoan Kiem Street 123, Hanoi'),
(30, 'Хошимин', 'Nguyen Hue Boulevard 45, Ho Chi Minh City'),
(30, 'Дананг', 'Tran Phu Street 67, Da Nang'),
-- Габон
(31, 'Либревиль', 'Boulevard de l’Independance 123, Libreville'),
(31, 'Порт-Жантиль', 'Avenue de la Mer 45, Port-Gentil'),
(31, 'Франсвиль', 'Avenue de l’Unite 67, Franceville'),
-- Гаити
(32, 'Порт-о-Пренс', 'Rue du Centre 123, Port-au-Prince'),
(32, 'Кап-Аитьен', 'Boulevard Carenage 45, Cap-Haitien'),
(32, 'Гонаив', 'Rue des Miracles 67, Gonaives'),
-- Гана
(33, 'Аккра', 'Independence Avenue 123, Accra'),
(33, 'Кумаси', 'Prempeh II Street 45, Kumasi'),
(33, 'Тамале', 'Bolgatanga Road 67, Tamale'),
-- Греция
(34, 'Афины', 'Ermou Street 123, Athens'),
(34, 'Салоники', 'Tsimiski Street 45, Thessaloniki'),
(34, 'Патры', 'Agiou Andreou Street 67, Patras'),
-- Гренада
(35, 'Сент-Джорджес', 'Carenage Street 123, St. George’s'),
(35, 'Гуяве', 'Grand Etang Road 45, Gouyave'),
(35, 'Гренвилл', 'Market Street 67, Grenville'),
-- Грузия
(36, 'Тбилиси', 'Rustaveli Avenue 123, Tbilisi'),
(36, 'Батуми', 'Ninoshvili Street 45, Batumi'),
(36, 'Кутаиси', 'Tamar Street 67, Kutaisi'),
-- Дания
(37, 'Копенгаген', 'Stroget 123, Copenhagen'),
(37, 'Орхус', 'Sondergade 45, Aarhus'),
(37, 'Оденсе', 'Vestergade 67, Odense'),
-- Джорджия
(38, 'Тбилиси', 'Rustaveli Avenue 123, Tbilisi'),
(38, 'Батуми', 'Ninoshvili Street 45, Batumi'),
(38, 'Кутаиси', 'Tamar Street 67, Kutaisi'),
-- Доминика
(39, 'Розо', 'Victoria Street 123, Roseau'),
(39, 'Портсмут', 'Bay Street 45, Portsmouth'),
(39, 'Мариго', 'King George V Street 67, Marigot'),
-- Доминиканская Республика
(40, 'Санто-Доминго', 'Avenida Independencia 123, Santo Domingo'),
(40, 'Сантьяго', 'Calle del Sol 45, Santiago'),
(40, 'Ла-Романа', 'Avenida Libertad 67, La Romana'),
-- Египет
(41, 'Каир', 'Tahrir Square 123, Cairo'),
(41, 'Александрия', 'Corniche Road 45, Alexandria'),
(41, 'Гиза', 'Pyramid Street 67, Giza'),
-- Замбия
(42, 'Лусака', 'Cairo Road 123, Lusaka'),
(42, 'Китве', 'Independence Avenue 45, Kitwe'),
(42, 'Ндола', 'President Avenue 67, Ndola'),
-- Зимбабве
(43, 'Хараре', 'Samora Machel Avenue 123, Harare'),
(43, 'Булавайо', 'Robert Mugabe Way 45, Bulawayo'),
(43, 'Мутаре', 'Herbert Chitepo Street 67, Mutare'),
-- Индия
(44, 'Дели', 'Connaught Place 123, New Delhi'),
(44, 'Мумбаи', 'Marine Drive 45, Mumbai'),
(44, 'Бангалор', 'MG Road 67, Bangalore'),
-- Индонезия
(45, 'Джакарта', 'Jalan Thamrin 123, Jakarta'),
(45, 'Сурабая', 'Jalan Tunjungan 45, Surabaya'),
(45, 'Бандунг', 'Jalan Braga 67, Bandung'),
-- Иордания
(46, 'Амман', 'Rainbow Street 123, Amman'),
(46, 'Ирбид', 'University Street 45, Irbid'),
(46, 'Акаба', 'Corniche Road 67, Aqaba'),
-- Ирландия
(47, 'Дублин', 'O’Connell Street 123, Dublin'),
(47, 'Корк', 'Patrick Street 45, Cork'),
(47, 'Голуэй', 'Eyre Square 67, Galway'),
-- Исландия
(48, 'Рейкьявик', 'Laugavegur 123, Reykjavik'),
(48, 'Акурейри', 'Hafnarstræti 45, Akureyri'),
(48, 'Кеблавик', 'Vatnsnesvegur 67, Keflavik'),
-- Испания
(49, 'Мадрид', 'Gran Via 123, Madrid'),
(49, 'Барселона', 'La Rambla 45, Barcelona'),
(49, 'Валенсия', 'Calle Colon 67, Valencia'),
-- Италия
(50, 'Рим', 'Via del Corso 123, Rome'),
(50, 'Милан', 'Via Montenapoleone 45, Milan'),
(50, 'Неаполь', 'Via Toledo 67, Naples'),
-- Кабо-Верде
(51, 'Прая', 'Avenida Amilcar Cabral 123, Praia'),
(51, 'Минделу', 'Rua Lisboa 45, Mindelo'),
(51, 'Санта-Мария', 'Rua da Praia 67, Santa Maria'),
-- Казахстан
(52, 'Алматы', 'Abay Avenue 123, Almaty'),
(52, 'Нур-Султан', 'Kabanbay Batyr Avenue 45, Nur-Sultan'),
(52, 'Шымкент', 'Tauke Khan Avenue 67, Shymkent'),
-- Канада
(53, 'Торонто', 'Yonge Street 123, Toronto'),
(53, 'Монреаль', 'Rue Sainte-Catherine 45, Montreal'),
(53, 'Ванкувер', 'Robson Street 67, Vancouver'),
-- Катар
(54, 'Доха', 'Corniche Road 123, Doha'),
(54, 'Аль-Вакра', 'Al Wakrah Road 45, Al Wakrah'),
(54, 'Аль-Хор', 'Al Khor Street 67, Al Khor'),
-- Кения
(55, 'Найроби', 'Kenyatta Avenue 123, Nairobi'),
(55, 'Момбаса', 'Moi Avenue 45, Mombasa'),
(55, 'Кисуму', 'Oginga Odinga Road 67, Kisumu'),
-- Кипр
(56, 'Никосия', 'Ledra Street 123, Nicosia'),
(56, 'Лимасол', 'Makarios Avenue 45, Limassol'),
(56, 'Ларнака', 'Finikoudes Promenade 67, Larnaca'),
-- Киргизия
(57, 'Бишкек', 'Chui Avenue 123, Bishkek'),
(57, 'Ош', 'Lenin Street 45, Osh'),
(57, 'Джалал-Абад', 'Toktogul Street 67, Jalal-Abad'),
-- Китай (Id_Country = 58)
(58, 'Пекин', 'Chang’an Avenue 123, Beijing'),
(58, 'Шанхай', 'Nanjing Road 45, Shanghai'),
(58, 'Гуанчжоу', 'Yuexiu Road 67, Guangzhou'),
-- Корея, Северная (Id_Country = 59)
(59, 'Пхеньян', 'Kim Il-sung Square 123, Pyongyang'),
(59, 'Нампхо', 'Haeun Street 45, Nampo'),
(59, 'Синыйджу', 'Yalu River Road 67, Sinuiju'),
-- Корея, Южная (Id_Country = 60)
(60, 'Сеул', 'Gangnam-daero 123, Seoul'),
(60, 'Пусан', 'Gwangalli Beach Road 45, Busan'),
(60, 'Инчхон', 'Songdo Central Road 67, Incheon'),
-- Коста-Рика (Id_Country = 61)
(61, 'Сан-Хосе', 'Avenida Central 123, San Jose'),
(61, 'Лимон', 'Calle Principal 45, Limon'),
(61, 'Алахуэла', 'Calle 2 67, Alajuela'),
-- Кот-д’Ивуар (Id_Country = 62)
(62, 'Абиджан', 'Boulevard de la République 123, Abidjan'),
(62, 'Буаке', 'Avenue de la Paix 45, Bouake'),
(62, 'Ямусукро', 'Rue des Jardins 67, Yamoussoukro'),
-- Куба (Id_Country = 63)
(63, 'Гавана', 'Calle Obispo 123, Havana'),
(63, 'Сантьяго-де-Куба', 'Calle Heredia 45, Santiago de Cuba'),
(63, 'Камагуэй', 'Calle Maceo 67, Camaguey'),
-- Кюрасао (Id_Country = 64)
(64, 'Виллемстад', 'Breedestraat 123, Willemstad'),
(64, 'Синт-Михил', 'Kaya Grandi 45, Sint Michiel'),
(64, 'Бандера-Абау', 'Kaya C.E.B. Hellmund 67, Banda Abou'),
-- Лаос (Id_Country = 65)
(65, 'Вьентьян', 'Rue Setthathirath 123, Vientiane'),
(65, 'Луангпхабанг', 'Sisavangvong Road 45, Luang Prabang'),
(65, 'Паксе', 'Route 13 67, Pakse'),
-- Латвия (Id_Country = 66)
(66, 'Рига', 'Brivibas iela 123, Riga'),
(66, 'Даугавпилс', 'Rigas iela 45, Daugavpils'),
(66, 'Лиепая', 'Kuršu iela 67, Liepaja'),
-- Лесото (Id_Country = 67)
(67, 'Масеру', 'Kingsway 123, Maseru'),
(67, 'Мэфетенг', 'Main Road 45, Mafeteng'),
(67, 'Лерибе', 'Market Street 67, Leribe'),
-- Литва (Id_Country = 68)
(68, 'Вильнюс', 'Gedimino prospektas 123, Vilnius'),
(68, 'Каунас', 'Laisves aleja 45, Kaunas'),
(68, 'Клайпеда', 'Tiltu gatve 67, Klaipeda'),
-- Люксембург (Id_Country = 69)
(69, 'Люксембург', 'Rue du Fossé 123, Luxembourg'),
(69, 'Эш-сюр-Альзетт', 'Rue de l’Alzette 45, Esch-sur-Alzette'),
(69, 'Дюделанж', 'Rue de la Libération 67, Dudelange'),
-- Маврикий (Id_Country = 70)
(70, 'Порт-Луи', 'Sir Seewoosagur Ramgoolam Street 123, Port Louis'),
(70, 'Кьюрпайп', 'Royal Road 45, Curepipe'),
(70, 'Маэбург', 'Rue des Pêcheurs 67, Mahebourg'),
-- Мавритания (Id_Country = 71)
(71, 'Нуакшот', 'Avenue Gamal Abdel Nasser 123, Nouakchott'),
(71, 'Нуадибу', 'Avenue de l’Indépendance 45, Nouadhibou'),
(71, 'Росо', 'Rue de la République 67, Rosso'),
-- Мадейра (Id_Country = 72)
(72, 'Фуншал', 'Rua da Carreira 123, Funchal'),
(72, 'Камара-де-Лобуш', 'Rua da Praia 45, Camara de Lobos'),
(72, 'Машику', 'Rua do Ribeirinho 67, Machico'),
-- Малайзия (Id_Country = 73)
(73, 'Куала-Лумпур', 'Jalan Ampang 123, Kuala Lumpur'),
(73, 'Джорджтаун', 'Lebuh Pantai 45, George Town'),
(73, 'Ипох', 'Jalan Sultan Idris Shah 67, Ipoh'),
-- Мали (Id_Country = 74)
(74, 'Бамако', 'Avenue de l’Indépendance 123, Bamako'),
(74, 'Сикассо', 'Rue de la Liberté 45, Sikasso'),
(74, 'Мопти', 'Rue du Marché 67, Mopti'),
-- Мальдивы (Id_Country = 75)
(75, 'Мале', 'Boduthakurufaanu Magu 123, Male'),
(75, 'Адду', 'Hithadhoo Main Road 45, Addu City'),
(75, 'Фувамулах', 'Fuvahmulah Main Road 67, Fuvahmulah'),
-- Мальта (Id_Country = 76)
(76, 'Валлетта', 'Republic Street 123, Valletta'),
(76, 'Биркиркара', 'High Street 45, Birkirkara'),
(76, 'Слима', 'Tower Road 67, Sliema'),
-- Мексика (Id_Country = 77)
(77, 'Мехико', 'Paseo de la Reforma 123, Mexico City'),
(77, 'Гвадалахара', 'Avenida Vallarta 45, Guadalajara'),
(77, 'Монтеррей', 'Avenida Constitución 67, Monterrey'),
-- Молдова (Id_Country = 78)
(78, 'Кишинев', 'Bulevardul Stefan cel Mare 123, Chisinau'),
(78, 'Тирасполь', 'Ulitsa 25 Oktyabrya 45, Tiraspol'),
(78, 'Бельцы', 'Strada Mihai Eminescu 67, Balti'),
-- Монако (Id_Country = 79)
(79, 'Монако', 'Avenue de la Costa 123, Monaco'),
(79, 'Монте-Карло', 'Boulevard des Moulins 45, Monte Carlo'),
(79, 'Ларвотто', 'Avenue Princesse Grace 67, Larvotto'),
-- Монголия (Id_Country = 80)
(80, 'Улан-Батор', 'Peace Avenue 123, Ulaanbaatar'),
(80, 'Эрдэнэт', 'Central Street 45, Erdenet'),
(80, 'Дархан', 'Main Street 67, Darkhan'),
-- Марокко (Id_Country = 81)
(81, 'Рабат', 'Avenue Mohammed V 123, Rabat'),
(81, 'Касабланка', 'Boulevard Mohammed V 45, Casablanca'),
(81, 'Марракеш', 'Rue de la Kasbah 67, Marrakech'),
-- Намибия (Id_Country = 82)
(82, 'Виндхук', 'Independence Avenue 123, Windhoek'),
(82, 'Свакопмунд', 'Tobias Hainyeko Street 45, Swakopmund'),
(82, 'Рунду', 'Main Road 67, Rundu'),
-- Непал (Id_Country = 83)
(83, 'Катманду', 'Durbar Marg 123, Kathmandu'),
(83, 'Покхара', 'Lakeside Road 45, Pokhara'),
(83, 'Лалитпур', 'Pulchowk Road 67, Lalitpur'),
-- Нигер (Id_Country = 84)
(84, 'Ниамей', 'Avenue de la République 123, Niamey'),
(84, 'Зиндер', 'Rue du Marché 45, Zinder'),
(84, 'Маради', 'Avenue de l’Indépendance 67, Maradi'),
-- Нигерия (Id_Country = 85)
(85, 'Абуджа', 'Shehu Shagari Way 123, Abuja'),
(85, 'Лагос', 'Marina Road 45, Lagos'),
(85, 'Кано', 'Murtala Mohammed Way 67, Kano'),
-- Новая Зеландия (Id_Country = 86)
(86, 'Окленд', 'Queen Street 123, Auckland'),
(86, 'Веллингтон', 'Lambton Quay 45, Wellington'),
(86, 'Крайстчерч', 'Colombo Street 67, Christchurch'),
-- Норвегия (Id_Country = 87)
(87, 'Осло', 'Karl Johans gate 123, Oslo'),
(87, 'Берген', 'Torgallmenningen 45, Bergen'),
(87, 'Тронхейм', 'Kongens gate 67, Trondheim'),
-- Объединенные Арабские Эмираты (Id_Country = 88)
(88, 'Дубай', 'Sheikh Zayed Road 123, Dubai'),
(88, 'Абу-Даби', 'Corniche Road 45, Abu Dhabi'),
(88, 'Шарджа', 'King Faisal Road 67, Sharjah'),
-- Оман (Id_Country = 89)
(89, 'Маскат', 'Sultan Qaboos Street 123, Muscat'),
(89, 'Салала', 'Al Nahda Street 45, Salalah'),
(89, 'Сур', 'Corniche Road 67, Sur'),
-- Пакистан (Id_Country = 90)
(90, 'Исламабад', 'Constitution Avenue 123, Islamabad'),
(90, 'Карачи', 'Shahrah-e-Faisal 45, Karachi'),
(90, 'Лахор', 'The Mall 67, Lahore'),
-- Палау (Id_Country = 91)
(91, 'Нгерулмуд', 'Ertong Road 123, Ngerulmud'),
(91, 'Корор', 'Main Street 45, Koror'),
(91, 'Малангок', 'Beach Road 67, Malakal'),
-- Панама (Id_Country = 92)
(92, 'Панама', 'Avenida Central 123, Panama City'),
(92, 'Колон', 'Calle 12 45, Colon'),
(92, 'Давид', 'Avenida Central 67, David'),
-- Папуа – Новая Гвинея (Id_Country = 93)
(93, 'Порт-Морсби', 'Waigani Drive 123, Port Moresby'),
(93, 'Лаэ', 'Markham Road 45, Lae'),
(93, 'Маданг', 'Coastwatchers Avenue 67, Madang'),
-- Парагвай (Id_Country = 94)
(94, 'Асунсьон', 'Calle Palma 123, Asuncion'),
(94, 'Сьюдад-дель-Эсте', 'Avenida San Blas 45, Ciudad del Este'),
(94, 'Энкарнасьон', 'Calle Mariscal Estigarribia 67, Encarnacion'),
-- Португалия (Id_Country = 95)
(95, 'Лиссабон', 'Rua Augusta 123, Lisbon'),
(95, 'Порту', 'Rua de Santa Catarina 45, Porto'),
(95, 'Фару', 'Rua de Santo Antonio 67, Faro'),
-- Россия (Id_Country = 96)
(96, 'Москва', 'Тверская улица 123, Москва'),
(96, 'Санкт-Петербург', 'Невский проспект 45, Санкт-Петербург'),
(96, 'Новосибирск', 'Красный проспект 67, Новосибирск'),
-- Румыния (Id_Country = 97)
(97, 'Бухарест', 'Calea Victoriei 123, Bucharest'),
(97, 'Клуж-Напока', 'Strada Memorandumului 45, Cluj-Napoca'),
(97, 'Тимишоара', 'Bulevardul Revolutiei 67, Timisoara'),
-- Сальвадор (Id_Country = 98)
(98, 'Сан-Сальвадор', 'Alameda Roosevelt 123, San Salvador'),
(98, 'Санта-Ана', 'Calle Libertad 45, Santa Ana'),
(98, 'Сан-Мигель', 'Avenida Gerardo Barrios 67, San Miguel'),
-- Саудовская Аравия (Id_Country = 99)
(99, 'Эр-Рияд', 'King Fahd Road 123, Riyadh'),
(99, 'Джидда', 'Corniche Road 45, Jeddah'),
(99, 'Мекка', 'Ibrahim Al Khalil Street 67, Mecca'),
-- Сингапур (Id_Country = 100)
(100, 'Сингапур', 'Orchard Road 123, Singapore'),
(100, 'Марина-Бэй', 'Marina Bay Sands 45, Marina Bay'),
(100, 'Чанги', 'Airport Boulevard 67, Changi'),
-- Словакия (Id_Country = 101)
(101, 'Братислава', 'Hlavné námestie 123, Bratislava'),
(101, 'Кошице', 'Hlavná ulica 45, Kosice'),
(101, 'Прешов', 'Hlavná ulica 67, Presov'),
-- Словения (Id_Country = 102)
(102, 'Любляна', 'Prešernov trg 123, Ljubljana'),
(102, 'Марибор', 'Gosposka ulica 45, Maribor'),
(102, 'Целе', 'Glavni trg 67, Celje'),
-- Сомали (Id_Country = 103)
(103, 'Могадишо', 'Maka Al Mukarama Road 123, Mogadishu'),
(103, 'Харгейса', 'Ahmed Dhagah Street 45, Hargeisa'),
(103, 'Босасо', 'Bosaso Main Road 67, Bosaso'),
-- Судан (Id_Country = 104)
(104, 'Хартум', 'Al Qasr Avenue 123, Khartoum'),
(104, 'Омдурман', 'Al Arbaeen Street 45, Omdurman'),
(104, 'Порт-Судан', 'Red Sea Road 67, Port Sudan'),
-- Таджикистан (Id_Country = 105)
(105, 'Душанбе', 'Rudaki Avenue 123, Dushanbe'),
(105, 'Худжанд', 'Lenin Street 45, Khujand'),
(105, 'Куляб', 'Shahidon Street 67, Kulob'),
-- Таиланд (Id_Country = 106)
(106, 'Бангкок', 'Sukhumvit Road 123, Bangkok'),
(106, 'Чиангмай', 'Tha Phae Road 45, Chiang Mai'),
(106, 'Пхукет', 'Thanon Rat-U-Thit 67, Phuket'),
-- Тайвань (Id_Country = 107)
(107, 'Тайбэй', 'Zhongxiao East Road 123, Taipei'),
(107, 'Гаосюн', 'Ziqiang Road 45, Kaohsiung'),
(107, 'Тайчжун', 'Zhongshan Road 67, Taichung'),
-- Танзания (Id_Country = 108)
(108, 'Дар-эс-Салам', 'Samora Avenue 123, Dar es Salaam'),
(108, 'Додома', 'Independence Avenue 45, Dodoma'),
(108, 'Аруша', 'Sokoine Road 67, Arusha'),
-- Того (Id_Country = 109)
(109, 'Ломе', 'Boulevard du 13 Janvier 123, Lome'),
(109, 'Сокоде', 'Rue de la Paix 45, Sokode'),
(109, 'Кара', 'Avenue de la Liberation 67, Kara'),
-- Туркменистан (Id_Country = 110)
(110, 'Ашхабад', 'Magtymguly Avenue 123, Ashgabat'),
(110, 'Туркменабад', 'Gurbanguly Hajji Street 45, Turkmenabat'),
(110, 'Дашогуз', 'Shavat Street 67, Dashoguz'),
-- Турция (Id_Country = 111)
(111, 'Анкара', 'Atatürk Bulvarı 123, Ankara'),
(111, 'Стамбул', 'İstiklal Caddesi 45, Istanbul'),
(111, 'Измир', 'Kordon Boyu 67, Izmir'),
-- Уганда (Id_Country = 112)
(112, 'Кампала', 'Kampala Road 123, Kampala'),
(112, 'Джинджа', 'Main Street 45, Jinja'),
(112, 'Мбале', 'Market Street 67, Mbale'),
-- Узбекистан (Id_Country = 113)
(113, 'Ташкент', 'Amir Timur Street 123, Tashkent'),
(113, 'Самарканд', 'Registan Street 45, Samarkand'),
(113, 'Бухара', 'Lyab-i Hauz Street 67, Bukhara'),
-- Украина (Id_Country = 114)
(114, 'Киев', 'Хрещатик 123, Киев'),
(114, 'Харьков', 'Сумская улица 45, Харьков'),
(114, 'Одесса', 'Дерибасовская улица 67, Одесса'),
-- Уругвай (Id_Country = 115)
(115, 'Монтевидео', 'Avenida 18 de Julio 123, Montevideo'),
(115, 'Сальто', 'Uruguay Street 45, Salto'),
(115, 'Пайсанду', 'Calle 19 de Abril 67, Paysandu'),
-- Филиппины (Id_Country = 116)
(116, 'Манила', 'Roxas Boulevard 123, Manila'),
(116, 'Себу', 'Osmeña Boulevard 45, Cebu'),
(116, 'Давао', 'Roxas Avenue 67, Davao'),
-- Финляндия (Id_Country = 117)
(117, 'Хельсинки', 'Mannerheimintie 123, Helsinki'),
(117, 'Эспоо', 'Leppävaarankatu 45, Espoo'),
(117, 'Тампере', 'Hämeenkatu 67, Tampere'),
-- Франция (Id_Country = 118)
(118, 'Париж', 'Champs-Élysées 123, Paris'),
(118, 'Марсель', 'La Canebière 45, Marseille'),
(118, 'Лион', 'Rue de la République 67, Lyon'),
-- Хорватия (Id_Country = 119)
(119, 'Загреб', 'Ilica 123, Zagreb'),
(119, 'Сплит', 'Riva 45, Split'),
(119, 'Дубровник', 'Stradun 67, Dubrovnik'),
-- Центральноафриканская Республика (Id_Country = 120)
(120, 'Банги', 'Avenue des Martyrs 123, Bangui'),
(120, 'Бимбо', 'Rue de la Paix 45, Bimbo'),
(120, 'Берберати', 'Avenue de l’Indépendance 67, Berberati'),
-- Чад (Id_Country = 121)
(121, 'Нджамена', 'Avenue Charles de Gaulle 123, N’Djamena'),
(121, 'Мунду', 'Rue du Marché 45, Moundou'),
(121, 'Сарх', 'Avenue de l’Indépendance 67, Sarh'),
-- Чехия (Id_Country = 122)
(122, 'Прага', 'Wenceslas Square 123, Prague'),
(122, 'Брно', 'Masarykova Street 45, Brno'),
(122, 'Острава', 'Masaryk Square 67, Ostrava'),
-- Чили (Id_Country = 123)
(123, 'Сантьяго', 'Avenida Libertador Bernardo O’Higgins 123, Santiago'),
(123, 'Вальпараисо', 'Avenida Argentina 45, Valparaiso'),
(123, 'Консепсьон', 'Barros Arana Avenue 67, Concepcion'),
-- Швейцария (Id_Country = 124)
(124, 'Цюрих', 'Bahnhofstrasse 123, Zurich'),
(124, 'Женева', 'Rue du Rhône 45, Geneva'),
(124, 'Базель', 'Freie Strasse 67, Basel'),
-- Швеция (Id_Country = 125)
(125, 'Стокгольм', 'Drottninggatan 123, Stockholm'),
(125, 'Гётеборг', 'Avenyn 45, Gothenburg'),
(125, 'Мальмё', 'Södergatan 67, Malmo'),
-- Эквадор (Id_Country = 126)
(126, 'Кито', 'Avenida Amazonas 123, Quito'),
(126, 'Гуаякиль', '9 de Octubre Avenue 45, Guayaquil'),
(126, 'Куэнка', 'Calle Larga 67, Cuenca'),
-- Экваториальная Гвинея (Id_Country = 127)
(127, 'Малабо', 'Avenida de la Independencia 123, Malabo'),
(127, 'Бата', 'Avenida de la Libertad 45, Bata'),
(127, 'Эбебийин', 'Calle Principal 67, Ebebiyin'),
-- Эстония (Id_Country = 128)
(128, 'Таллин', 'Viru Street 123, Tallinn'),
(128, 'Тарту', 'Raekoja plats 45, Tartu'),
(128, 'Нарва', 'Puskini Street 67, Narva'),
-- Южноафриканская Республика (Id_Country = 129)
(129, 'Йоханнесбург', 'Main Street 123, Johannesburg'),
(129, 'Кейптаун', 'Long Street 45, Cape Town'),
(129, 'Дурбан', 'Florida Road 67, Durban'),
-- Южный Судан (Id_Country = 130)
(130, 'Джуба', 'Hai Malakal Road 123, Juba'),
(130, 'Вау', 'Market Street 45, Wau'),
(130, 'Малакаль', 'Nile Road 67, Malakal'),
-- Япония (Id_Country = 131)
(131, 'Токио', 'Ginza 123, Tokyo'),
(131, 'Осака', 'Dotonbori 45, Osaka'),
(131, 'Киото', 'Shijo-dori 67, Kyoto');





declare @Storage_location_i                         int = 0;
declare @Storage_location_ID_Type_Storage_location  bigint;
declare @Storage_location_Id_Status			        bigint;
declare @Storage_location_Id_Country			    bigint;
declare @Storage_location_KeySource                 bigint;
declare @Storage_location_Name                      nvarchar(400);
declare @Storage_location_City                      nvarchar(200);
declare @Storage_location_Adress                    nvarchar(800);
declare @Storage_location_RandomLogin               nvarchar(100);
declare @Storage_location_TypePhoneRandom           nvarchar(20);
declare @Storage_location_RandomDate                date;


declare @Buyer_TypePhoneRandom     nvarchar(20);
declare @Buyer_RandomDate          date;
declare @Buyer_Premium             bit;
declare @Buyer_The_resident        bit;

 while @Storage_location_i < 314
  begin 
      set @Storage_location_ID_Type_Storage_location = (select top 1 ID_Type_Storage_location from Type_Storage_location order by  newid())
	  set @Storage_location_Id_Status = (select top 1 Id_Status from Storage_location_status order by newid())
	  set @Storage_location_Id_Country = (select top 1 Id_Country from Country order by newid())
	  set @Storage_location_KeySource  = cast(round(rand()*999999999999,0) as bigint)
	  set @Storage_location_Name  = (select top 1 t.name from @NameStorage as t where not exists (select top 1 ID_Storage_location from Storage_location where t.name = name) order by newid())
	  set @Storage_location_City = (select top 1 y.City_Name from @TempCities as y where y.Id_Country = @Storage_location_Id_Country order by newid())
	  set @Storage_location_Adress = (select top 1 y.[Address] from @TempCities as y where y.Id_Country = @Storage_location_Id_Country order by newid())
	  exec RandomLogin 10,20,   @Storage_location_RandomLogin                  output;
	  exec RandomPhone 1,       @Storage_location_TypePhoneRandom              output;
	  exec RandomDateNew  '20150101','20250101', @Storage_location_RandomDate  output;
	  
      insert into  Storage_location (ID_Type_Storage_location,Id_Status,Id_Country,KeySource,Name,City,Adress,Mail,Phone,Date_Created,[Description])
	  values 
	  (
	   @Storage_location_ID_Type_Storage_location
	   ,@Storage_location_Id_Status			      
	   ,@Storage_location_Id_Country
	   ,@Storage_location_KeySource
	   ,@Storage_location_Name
	   ,@Storage_location_City
	   ,@Storage_location_Adress
	   ,case  when round(rand()*100,0) = 99 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yandex.ru'
              when round(rand()*1,0)    = 1 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.ru'
	          when round(rand()*2,0)    = 2 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mail.com'
	          when round(rand()*3,0)    = 3 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@gmail.com'
	          when round(rand()*4,0)    = 4 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@yahoo.com'
	          when round(rand()*5,0)    = 5 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@hotmail.com'
	          when round(rand()*6,0)    = 6 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.com'
	          when round(rand()*7,0)    = 7 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@icloud.com'
	          when round(rand()*8,0)    = 8 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@moore@mail.com'
	          when round(rand()*9,0)    = 9 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@tutanota.com'
	          when round(rand()*10,0)  = 10 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@mydomain.com'
	          when round(rand()*11,0)  = 11 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@dr.com'
	          when round(rand()*12,0)  = 12 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@live.co.uk'
	          when round(rand()*13,0)  = 13 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@sharklasers.com'
	          when round(rand()*14,0)  = 14 then REPLACE(SUBSTRING(CONVERT(varchar(36), @Storage_location_RandomLogin), 1, convert(int,ROUND(rand()*120,0))), '-', '') + '@uol.com.br'
       ELSE N'Email не указан' END
	  ,@Storage_location_TypePhoneRandom
	  ,@Storage_location_RandomDate
	  ,null
	  );
  set @Storage_location_i = @Storage_location_i +1
  print ' Добавлено число ' +  ' -  строк --> ' + convert(nvarchar(10),@Storage_location_i) + '  В таблицу dbo.Storage_location';
  end;
  --rollback
 commit
go





--select Id_Country, count(ID_Storage_location) as 'число общее' from Storage_location group by Id_Country

--select * from  Storage_location where id_country = 13
