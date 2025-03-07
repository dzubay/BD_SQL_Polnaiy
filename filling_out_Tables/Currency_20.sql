
-- Cформированный через  https://chat.deepseek.com/
/*  
Сформируй все существующие официальные Валюты  в строчку(Исторические и не официальные не нужно), исходя из указанных ниже параметоров.
Должно быть пять столбцов, с указанными данными для каждого столбца ниже.
Первый столбец  - Полное наименование валюты на русском
Второй столбец - Полное наименование валюты на английском
трейтий столбец - Короткое наименование на русском
четвёртый столбец  - Короткое наименование на английском
Пятый столбец -  null
Первые четыре столбца должны быть в одинарных ковычках, в коротких наименованиях, пользоваться русским деалектом и английским .
Каждая строчка должна быть в скобках и через запятую

вот пример как должно быть 
('Российский рубль', 'Russian Ruble', 'руб.', 'RUB', NULL),
('Доллар США', 'US Dollar', 'долл.', 'USD', NULL),

Сформируй все существующие валюты в мире. Нужно именно что бы то сформировал все имеющиеся валюты, в том формате  в котором я указал.
*/

use Magaz_DB_Poln
go
set nocount,xact_abort on;
go
/*
-- Если с самого начала создаётся на с ID равным = 1, то можно обновить таблицу с помощью процы, и заполнить таблицу.
begin tran
if exists 
	  (	  
	  	SELECT * 
	  	FROM sys.identity_columns 
	  	WHERE object_id = OBJECT_ID('dbo.Currency') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.Currency', RESEED, 0)
	  end
--rollback
commit
go
*/

--select * from  dbo.Currency

--select * from  dbo.Currency_audit

--delete from  Currency where ID_Currency is not null


begin tran
insert into  Currency(Full_name_rus,Full_name_eng,Abbreviation_rus,Abbreviation_eng,Description) values 
('Афгани', 'Afghan Afghani', 'афгани', 'AFN', NULL),
('Евро', 'Euro', 'евро', 'EUR', NULL),
('Лек', 'Albanian Lek', 'лек', 'ALL', NULL),
('Алжирский динар', 'Algerian Dinar', 'дин.', 'DZD', NULL),
('Доллар США', 'US Dollar', 'долл', 'USD', NULL),
('Евро', 'Euro', 'евро', 'EUR', NULL),
('Кванза', 'Angolan Kwanza', 'кванза', 'AOA', NULL),
('Восточнокарибский доллар', 'East Caribbean Dollar', 'вост.кариб.долл', 'XCD', NULL),
('Аргентинское песо', 'Argentine Peso', 'песо', 'ARS', NULL),
('Армянский драм', 'Armenian Dram', 'драм', 'AMD', NULL),
('Арубанский флорин', 'Aruban Florin', 'флорин', 'AWG', NULL),
('Австралийский доллар', 'Australian Dollar', 'австр. долл', 'AUD', NULL),
('Азербайджанский манат', 'Azerbaijani Manat', 'манат', 'AZN', NULL),
('Багамский доллар', 'Bahamian Dollar', 'багам.долл', 'BSD', NULL),
('Бахрейнский динар', 'Bahraini Dinar', 'дин', 'BHD', NULL),
('Така', 'Bangladeshi Taka', 'така', 'BDT', NULL),
('Барбадосский доллар', 'Barbadian Dollar', 'барб.долл', 'BBD', NULL),
('Белорусский рубль', 'Belarusian Ruble', 'руб', 'BYN', NULL),
('Белизский доллар', 'Belize Dollar', 'белиз.долл', 'BZD', NULL),
('Западноафриканский франк', 'West African CFA Franc', 'франк', 'XOF', NULL),
('Бермудский доллар', 'Bermudian Dollar', 'берм.долл', 'BMD', NULL),
('Нгултрум', 'Bhutanese Ngultrum', 'нгултрум', 'BTN', NULL),
('Боливиано', 'Bolivian Boliviano', 'болив', 'BOB', NULL),
('Конвертируемая марка', 'Bosnia-Herzegovina Convertible Mark', 'марка', 'BAM', NULL),
('Ботсванская пула', 'Botswana Pula', 'пула', 'BWP', NULL),
('Бразильский реал', 'Brazilian Real', 'реал', 'BRL', NULL),
('Брунейский доллар', 'Brunei Dollar', 'брун.долл', 'BND', NULL),
('Болгарский лев', 'Bulgarian Lev', 'лев', 'BGN', NULL),
('Бурундийский франк', 'Burundian Franc', 'франк', 'BIF', NULL),
('Кабо-вердешское эскудо', 'Cape Verdean Escudo', 'эскудо', 'CVE', NULL),
('Камбоджийский риель', 'Cambodian Riel', 'риель', 'KHR', NULL),
('Центральноафриканский франк', 'Central African CFA Franc', 'франк', 'XAF', NULL),
('Канадский доллар', 'Canadian Dollar', 'кан.долл', 'CAD', NULL),
('Доллар Каймановых островов', 'Cayman Islands Dollar', 'долл.Кайман', 'KYD', NULL),
('Чилийское песо', 'Chilean Peso', 'песо', 'CLP', NULL),
('Китайский юань', 'Chinese Yuan', 'юань', 'CNY', NULL),
('Колумбийское песо', 'Colombian Peso', 'песо', 'COP', NULL),
('Коморский франк', 'Comorian Franc', 'франк', 'KMF', NULL),
('Конголезский франк', 'Congolese Franc', 'франк', 'CDF', NULL),
('Новозеландский доллар', 'New Zealand Dollar', 'новозел.долл', 'NZD', NULL),
('Коста-риканский колон', 'Costa Rican Colon', 'колон', 'CRC', NULL),
('Хорватская куна', 'Croatian Kuna', 'куна', 'HRK', NULL),
('Кубинское песо', 'Cuban Peso', 'песо', 'CUP', NULL),
('Чешская крона', 'Czech Koruna', 'крона', 'CZK', NULL),
('Датская крона', 'Danish Krone', 'крона', 'DKK', NULL),
('Джибутийский франк', 'Djiboutian Franc', 'франк', 'DJF', NULL),
('Доминиканское песо', 'Dominican Peso', 'песо', 'DOP', NULL),
('Египетский фунт', 'Egyptian Pound', 'фунт', 'EGP', NULL),
('Сальвадорский колон', 'Salvadoran Colon', 'колон', 'SVC', NULL),
('Эритрейская накфа', 'Eritrean Nakfa', 'накфа', 'ERN', NULL),
('Эфиопский быр', 'Ethiopian Birr', 'быр', 'ETB', NULL),
('Фиджийский доллар', 'Fijian Dollar', 'фидж.долл', 'FJD', NULL),
('Гамбийский даласи', 'Gambian Dalasi', 'даласи', 'GMD', NULL),
('Лари', 'Georgian Lari', 'лари', 'GEL', NULL),
('Ганский седи', 'Ghanaian Cedi', 'седи', 'GHS', NULL),
('Гибралтарский фунт', 'Gibraltar Pound', 'фунт', 'GIP', NULL),
('Гватемальский кетсаль', 'Guatemalan Quetzal', 'кетсаль', 'GTQ', NULL),
('Гвинейский франк', 'Guinean Franc', 'франк', 'GNF', NULL),
('Гайанский доллар', 'Guyanese Dollar', 'гайан.долл', 'GYD', NULL),
('Гурд', 'Haitian Gourde', 'гурд', 'HTG', NULL),
('Гондурасская лемпира', 'Honduran Lempira', 'лемпира', 'HNL', NULL),
('Гонконгский доллар', 'Hong Kong Dollar', 'гонк.долл', 'HKD', NULL),
('Форинт', 'Hungarian Forint', 'форинт', 'HUF', NULL),
('Исландская крона', 'Icelandic Króna', 'крона', 'ISK', NULL),
('Индийская рупия', 'Indian Rupee', 'рупия', 'INR', NULL),
('Индонезийская рупия', 'Indonesian Rupiah', 'рупия', 'IDR', NULL),
('Иранский риал', 'Iranian Rial', 'риал', 'IRR', NULL),
('Иракский динар', 'Iraqi Dinar', 'дин', 'IQD', NULL),
('Новый израильский шекель', 'Israeli New Shekel', 'шекель', 'ILS', NULL),
('Ямайский доллар', 'Jamaican Dollar', 'ямайк.долл', 'JMD', NULL),
('Иена', 'Japanese Yen', 'иена', 'JPY', NULL),
('Иорданский динар', 'Jordanian Dinar', 'дин', 'JOD', NULL),
('Тенге', 'Kazakhstani Tenge', 'тенге', 'KZT', NULL),
('Кенийский шиллинг', 'Kenyan Shilling', 'шилл', 'KES', NULL),
('Кувейтский динар', 'Kuwaiti Dinar', 'дин', 'KWD', NULL),
('Сом', 'Kyrgyzstani Som', 'сом', 'KGS', NULL),
('Лаосский кип', 'Lao Kip', 'кип', 'LAK', NULL),
('Латвийский лат', 'Latvian Lats', 'лат', 'LVL', NULL),
('Ливанский фунт', 'Lebanese Pound', 'фунт', 'LBP', NULL),
('Лоти', 'Lesotho Loti', 'лоти', 'LSL', NULL),
('Либерийский доллар', 'Liberian Dollar', 'либер.долл', 'LRD', NULL),
('Ливийский динар', 'Libyan Dinar', 'дин', 'LYD', NULL),
('Швейцарский франк', 'Swiss Franc', 'франк', 'CHF', NULL),
('Македонский денар', 'Macedonian Denar', 'денар', 'MKD', NULL),
('Малагасийский ариари', 'Malagasy Ariary', 'ариари', 'MGA', NULL),
('Малавийская квача', 'Malawian Kwacha', 'квача', 'MWK', NULL),
('Малайзийский ринггит', 'Malaysian Ringgit', 'ринггит', 'MYR', NULL),
('Мальдивская руфия', 'Maldivian Rufiyaa', 'руфия', 'MVR', NULL),
('Угия', 'Mauritanian Ouguiya', 'угия', 'MRU', NULL),
('Маврикийская рупия', 'Mauritian Rupee', 'рупия', 'MUR', NULL),
('Мексиканское песо', 'Mexican Peso', 'песо', 'MXN', NULL),
('Молдавский лей', 'Moldovan Leu', 'лей', 'MDL', NULL),
('Тугрик', 'Mongolian Tögrög', 'тугрик', 'MNT', NULL),
('Марокканский дирхам', 'Moroccan Dirham', 'дирхам', 'MAD', NULL),
('Мозамбикский метикал', 'Mozambican Metical', 'метикал', 'MZN', NULL),
('Мьянманский кьят', 'Myanmar Kyat', 'кьят', 'MMK', NULL),
('Намибийский доллар', 'Namibian Dollar', 'нам.долл', 'NAD', NULL),
('Непальская рупия', 'Nepalese Rupee', 'рупия', 'NPR', NULL),
('Нидерландский антильский гульден', 'Netherlands Antillean Guilder', 'гульден', 'ANG', NULL),
('Новозеландский доллар', 'New Zealand Dollar', 'новозел.долл', 'NZD', NULL),
('Никарагуанская кордоба', 'Nicaraguan Córdoba', 'кордоба', 'NIO', NULL),
('Найра', 'Nigerian Naira', 'найра', 'NGN', NULL),
('Северокорейская вона', 'North Korean Won', 'вона', 'KPW', NULL),
('Норвежская крона', 'Norwegian Krone', 'крона', 'NOK', NULL),
('Оманский риал', 'Omani Rial', 'риал', 'OMR', NULL),
('Пакистанская рупия', 'Pakistani Rupee', 'рупия', 'PKR', NULL),
('Панамский бальбоа', 'Panamanian Balboa', 'бальбоа', 'PAB', NULL),
('Кина', 'Papua New Guinean Kina', 'кина', 'PGK', NULL),
('Парагвайский гуарани', 'Paraguayan Guarani', 'гуарани', 'PYG', NULL),
('Перуанский соль', 'Peruvian Sol', 'соль', 'PEN', NULL),
('Филиппинское песо', 'Philippine Peso', 'песо', 'PHP', NULL),
('Польский злотый', 'Polish Zloty', 'злотый', 'PLN', NULL),
('Катарский риал', 'Qatari Rial', 'риал', 'QAR', NULL),
('Румынский лей', 'Romanian Leu', 'лей', 'RON', NULL),
('Российский рубль', 'Russian Ruble', 'руб', 'RUB', NULL),
('Руандийский франк', 'Rwandan Franc', 'франк', 'RWF', NULL),
('Самоанская тала', 'Samoan Tala', 'тала', 'WST', NULL),
('Добра', 'São Tomé and Príncipe Dobra', 'добра', 'STN', NULL),
('Саудовский риял', 'Saudi Riyal', 'риял', 'SAR', NULL),
('Сербский динар', 'Serbian Dinar', 'дин', 'RSD', NULL),
('Сейшельская рупия', 'Seychellois Rupee', 'рупия', 'SCR', NULL),
('Сьерра-леонский леоне', 'Sierra Leonean Leone', 'леоне', 'SLL', NULL),
('Сингапурский доллар', 'Singapore Dollar', 'сингап.долл', 'SGD', NULL),
('Соломоновский доллар', 'Solomon Islands Dollar', 'солом.долл', 'SBD', NULL),
('Сомалийский шиллинг', 'Somali Shilling', 'шилл', 'SOS', NULL),
('Южноафриканский рэнд', 'South African Rand', 'рэнд', 'ZAR', NULL),
('Южнокорейская вона', 'South Korean Won', 'вона', 'KRW', NULL),
('Южносуданский фунт', 'South Sudanese Pound', 'фунт', 'SSP', NULL),
('Шри-ланкийская рупия', 'Sri Lankan Rupee', 'рупия', 'LKR', NULL),
('Суданский фунт', 'Sudanese Pound', 'фунт', 'SDG', NULL),
('Суринамский доллар', 'Surinamese Dollar', 'суринам.долл', 'SRD', NULL),
('Шведская крона', 'Swedish Krona', 'крона', 'SEK', NULL),
('Сирийский фунт', 'Syrian Pound', 'фунт', 'SYP', NULL),
('Тайваньский доллар', 'New Taiwan Dollar', 'тайв.долл', 'TWD', NULL),
('Таджикский сомони', 'Tajikistani Somoni', 'сомони', 'TJS', NULL),
('Танзанийский шиллинг', 'Tanzanian Shilling', 'шилл', 'TZS', NULL),
('Бат', 'Thai Baht', 'бат', 'THB', NULL),
('Паанга', 'Tongan Paʻanga', 'паанга', 'TOP', NULL),
('Тринидадский доллар', 'Trinidad and Tobago Dollar', 'тринид.долл', 'TTD', NULL),
('Тунисский динар', 'Tunisian Dinar', 'дин', 'TND', NULL),
('Турецкая лира', 'Turkish Lira', 'лира', 'TRY', NULL),
('Туркменский манат', 'Turkmenistani Manat', 'манат', 'TMT', NULL),
('Угандийский шиллинг', 'Ugandan Shilling', 'шилл', 'UGX', NULL),
('Гривна', 'Ukrainian Hryvnia', 'гривна', 'UAH', NULL),
('Дирхам ОАЭ', 'United Arab Emirates Dirham', 'дирхам', 'AED', NULL),
('Фунт стерлингов', 'British Pound', 'фунт', 'GBP', NULL),
('Уругвайское песо', 'Uruguayan Peso', 'песо', 'UYU', NULL),
('Узбекский сум', 'Uzbekistani Som', 'сум', 'UZS', NULL),
('Вату', 'Vanuatu Vatu', 'вату', 'VUV', NULL),
('Венесуэльский боливар', 'Venezuelan Bolívar', 'боливар', 'VES', NULL),
('Вьетнамский донг', 'Vietnamese Dong', 'донг', 'VND', NULL),
('Йеменский риал', 'Yemeni Rial', 'риал', 'YER', NULL),
('Замбийская квача', 'Zambian Kwacha', 'квача', 'ZMW', NULL),
('Доллар Зимбабве', 'Zimbabwean Dollar', 'зимб.долл', 'ZWL', NULL)
--rollback
commit




--премиум 
--Резидент не резидент 
