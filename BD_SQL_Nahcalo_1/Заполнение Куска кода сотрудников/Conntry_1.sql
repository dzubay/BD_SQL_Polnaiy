
/*
Сформирован через - https://chataibot.ru/app/free-chat 

Требуется вставить в таблицу "Country" через insert данные по трём колонкам. 
Первая колонка №1 - Name_Country  это наименование всех стран на Русском. 
Вторая колонка №2 - Name_English это их же  наименование на Английском, 
Третья колонка №3 - Cod_Country_Phone это код телефонного номера этой же страны.
*/

--ALTER TABLE Country  ALTER COLUMN Cod_Country_Phone nvarchar(10) null

--select * from  dbo.Country


--begin tran   --Смотрим на колонку  last_value
--if exists 
--	  (	  
--	  	SELECT * 
--	  	FROM sys.identity_columns 
--	  	WHERE object_id = OBJECT_ID('dbo.Country') 
--	  		AND last_value IS not NULL 	  
--	  )
--	  begin
--	  DBCC CHECKIDENT ('dbo.Country', RESEED, 0)
--	  end
----rollback
--commit
--go

--delete from  Country where id_Country is not null


use Magaz_DB
go
begin tran
INSERT INTO dbo.Country (Name_Country, Name_English, Cod_Country_Phone) VALUES
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
('Кюрасао', 'Curaçao', '+599'),
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
commit
go

--select * from dbo.Country