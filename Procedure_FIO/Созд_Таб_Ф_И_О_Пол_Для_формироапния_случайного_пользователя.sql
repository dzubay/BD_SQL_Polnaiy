﻿set nocount,xact_abort on;
go

begin tran 

DROP TABLE IF EXISTS names_f;

go

CREATE TABLE names_f (
  id        int            NOT NULL identity(1,1),
  firstname nvarchar(70)  DEFAULT NULL,
  gender    int            DEFAULT NULL  check(gender in (1,2)),
  constraint PK_ID_names_f Primary key  (ID),
) 

go 

INSERT INTO names_f (firstname,gender)
VALUES
	('Александр',1),
	('Алексей',1),
	('Альберт',1),
	('Анатолий',1),
	('Андрей',1),
	('Антон',1),
	('Артем',1),
	('Артур',1),
	('Афанасий',1),
	('Богдан',1),
	('Борис',1),
	('Вадим',1),
	('Валентин',1),
	('Валерий',1),
	('Василий',1),
	('Виктор',1),
	('Винер',1),
	('Виталий',1),
	('Владимир',1),
	('Владислав',1),
	('Власий',1),
	('Всеволод',1),
	('Вячеслав',1),
	('Геннадий',1),
	('Георгий',1),
	('Григорий',1),
	('Данила',1),
	('Денис',1),
	('Дмитрий',1),
	('Евгений',1),
	('Егор',1),
	('Емельян',1),
	('Захар',1),
	('Иван',1),
	('Игорь',1),
	('Илья',1),
	('Касьян',1),
	('Кирилл',1),
	('Константин',1),
	('Ксенофонт',1),
	('Кузьма',1),
	('Лев',1),
	('Леонид',1),
	('Леопольд',1),
	('Макар',1),
	('Максим',1),
	('Михаил',1),
	('Никита',1),
	('Никифор',1),
	('Николай',1),
	('Олег',1),
	('Павел',1),
	('Пётр',1),
	('Платон',1),
	('Радик',1),
	('Расиль',1),
	('Ринат',1),
	('Роман',1),
	('Руслан',1),
	('Светлана',1),
	('Сергей',1),
	('Станислав',1),
	('Степан',1),
	('Тимофей',1),
	('Тимур',1),
	('Трофим',1),
	('Фёдор',1),
	('Федот',1),
	('Фома',1),
	('Эдуард',1),
	('Юрий',1),
	('Яков',1),
	('Авдотья',2),
	('Акулина',2),
	('Александра',2),
	('Алена',2),
	('Алина',2),
	('Альфия',2),
	('Анастасия',2),
	('Ангелика',2),
	('Анеля',2),
	('Анна',2),
	('Антонина',2),
	('Валентина',2),
	('Варвара',2),
	('Вера',2),
	('Вероника',2),
	('Владимир',2),
	('Галина',2),
	('Евгения',2),
	('Евдокия',2),
	('Екатерина',2),
	('Елена',2),
	('Елизавета',2),
	('Ефросиния',2),
	('Жанна',2),
	('Инесса',2),
	('Инна',2),
	('Ираида',2),
	('Ирина',2),
	('Клавдия',2),
	('Кристина',2),
	('Ксения',2),
	('Лада',2),
	('Лариса',2),
	('Лена',2),
	('Лидия',2),
	('Лилианна',2),
	('Лилия',2),
	('Лия',2),
	('Любовь',2),
	('Людмила',2),
	('Люсия',2),
	('Маргарита',2),
	('Марина',2),
	('Мария',2),
	('Милана',2),
	('Надежда',2),
	('Наталья',2),
	('Нина',2),
	('Оксана',2),
	('Оксинья',2),
	('Ольга',2),
	('Пелагея',2),
	('Полина',2),
	('Прасковья',2),
	('Раиса',2),
	('Римма',2),
	('Рита',2),
	('Светлана',2),
	('Степанида',2),
	('Таисья',2),
	('Тамара',2),
	('Татьяна',2),
	('Фёкла',2),
	('Хевронья',2),
	('Элеонора',2),
	('Эльвира',2),
	('Юлия',2);

go

DROP TABLE IF EXISTS names_l;

go

CREATE TABLE names_l (
  id       int           NOT NULL identity(1,1),
  lastname nvarchar(70)  DEFAULT NULL,
  gender   int           DEFAULT NULL check(gender in (1,2)),
  constraint  PK_ID_names_l PRIMARY KEY (id),
) 

go

INSERT INTO names_l (lastname, gender) VALUES
	('Мысин',1),
	('Муравлёв',1),
	('Дягилев',1),
	('Бабаев',1),
	('Мичурин',1),
	('Микифоров',1),
	('Кунцев',1),
	('Лесин',1),
	('Бахолдин',1),
	('Евлашин',1),
	('Недосказов',1),
	('Муштаков',1),
	('Миханкин',1),
	('Витютиев',1),
	('Станкова',1),
	('Богдашкин',1),
	('Евлашов',1),
	('Мингалёв',1),
	('Грызлов',1),
	('Волков',1),
	('Жеребин',1),
	('Миронов',1),
	('Демихов',1),
	('Неприн',1),
	('Дондов',1),
	('Девятов',1),
	('Дедов',1),
	('Дежнев',1),
	('Наровчатов',1),
	('Гриньков',1),
	('Поварницин',1),
	('Будаев',1),
	('Ларюхин',1),
	('Корубин',1),
	('Голованев',1),
	('Чунов',1),
	('Сюткин',1),
	('Каймаков',1),
	('Мещеряков',1),
	('Назимов',1),
	('Архипов',1),
	('Дёмин',1),
	('Малахов',1),
	('Недозевин',1),
	('Смирнов',1),
	('Трубачёв',1),
	('Бершов',1),
	('Кадышев',1),
	('Лихачёв',1),
	('Викторов',1),
	('Бабин',1),
	('Скворцов',1),
	('Абрамцев',1),
	('Бахтияров',1),
	('Глазьев',1),
	('Ерашев',1),
	('Ковальков',1),
	('Карпушкин',1),
	('Нечаев',1),
	('Тимофеев',1),
	('Карпеев',1),
	('Благинин',1),
	('Спиридонов',1),
	('Моржеретов',1),
	('Бурмистров',1),
	('Задерихин',1),
	('Злобин',1),
	('Балашов',1),
	('Золотавин',1),
	('Листратов',1),
	('Беспалов',1),
	('Лихарев',1),
	('Евдокимов',1),
	('Астафьев',1),
	('Капшуль',1),
	('Федоров',1),
	('Брума',1),
	('Крылов',1),
	('Андреев',1),
	('Близнюков',1),
	('Наговицын',1),
	('Романов',1),
	('Нистратов',1),
	('Нежданов',1),
	('Перумов',1),
	('Гамзулин',1),
	('Бутаков',1),
	('Бестужев',1),
	('Булатов',1),
	('Недокучаев',1),
	('Загудалов',1),
	('Панов',1),
	('Морозов',1),
	('Лешуков',1),
	('Евланов',1),
	('Чумаков',1),
	('Лутошников',1),
	('Журавлёв',1),
	('Медвенцев',1),
	('Краснощёков',1),
	('Степаньков',1),
	('Королёв',1),
	('Березин',1),
	('Лунин',1),
	('Мишухин',1),
	('Вострокопытов',1),
	('Долматов',1),
	('Буконин',1),
	('Ермошкин',1),
	('Вышеславцев',1),
	('Надежин',1),
	('Бабаков',1),
	('Шулаев',1),
	('Абакумов',1),
	('Недобоев',1),
	('Новомлинцев',1),
	('Бузунов',1),
	('Веденяпин',1),
	('Касьянов',1),
	('Макаров',1),
	('Бутусов',1),
	('Недосейкин',1),
	('Шамешев',1),
	('Ирошников',1),
	('Голямов',1),
	('Евсенчев',1),
	('Кравцов',1),
	('Бабанин',1),
	('Нагайцев',1),
	('Буянтуев',1),
	('Ларин',1),
	('Дюкарев',1),
	('Киселёв',1),
	('Оськин',1),
	('Кириллов',1),
	('Ахряпов',1),
	('Лохтин',1),
	('Тукмаков',1),
	('Сидоров',1),
	('Брыкин',1),
	('Бахорин',1),
	('Чернозёмов',1),
	('Девятаев',1),
	('Свердлов',1),
	('Нагибин',1),
	('Дебособров',1),
	('Лаушкин',1),
	('Нохрин',1),
	('Оношкин',1),
	('Выжлецов',1),
	('Алампиев',1),
	('Мишакин',1),
	('Витин',1),
	('Лызлов',1),
	('Бушмин',1),
	('Любимов',1),
	('Ликунов',1),
	('Молостнов',1),
	('Богданов',1),
	('Зенкин',1),
	('Недовесов',1),
	('Винокуров',1),
	('Мишукин',1),
	('Кузьмин',1),
	('Степанов',1),
	('Буробин',1),
	('Галиев',1),
	('Дорохов',1),
	('Аривошкин',1),
	('Васнецов',1),
	('Александров',1),
	('Негодяев',1),
	('Дьяков',1),
	('Дианов',1),
	('Недоплясов',1),
	('Недочётов',1),
	('Ненашкин',1),
	('Демидов',1),
	('Екимов',1),
	('Годунов',1),
	('Дахнов',1),
	('Карагодин',1),
	('Карпиков',1),
	('Каганцев',1),
	('Веньчаков',1),
	('Беглов',1),
	('Медведев',1),
	('Мишенин',1),
	('Брежнев',1),
	('Соколов',1),
	('Горетов',1),
	('Григорьев',1),
	('Харланов',1),
	('Охохонин',1),
	('Барашков',1),
	('Ногаев',1),
	('Румянцев',1),
	('Лексиков',1),
	('Астахов',1),
	('Евсеев',1),
	('Бакунин',1),
	('Лемяхов',1),
	('Олейников',1),
	('Недачин',1),
	('Капустин',1),
	('Мынкин',1),
	('Божков',1),
	('Мишкин',1),
	('Занозин',1),
	('Ефимочкин',1),
	('Арчаков',1),
	('Мельгунов',1),
	('Сорокин',1),
	('Рыбаков',1),
	('Михайлин',1),
	('Горюнов',1),
	('Ляхов',1),
	('Недоростков',1),
	('Карпунин',1),
	('Горохов',1),
	('Мурин',1),
	('Мутылин',1),
	('Дориков',1),
	('Михалищев',1),
	('Дорожкин',1),
	('Пугачев',1),
	('Рыбин',1),
	('Недожоров',1),
	('Молоканов',1),
	('Мушкетов',1),
	('Ворошилов',1),
	('Захаров',1),
	('Балябин',1),
	('Зюряев',1),
	('Лукшин',1),
	('Калинин',1),
	('Кандауров',1),
	('Воронин',1),
	('Поливанов',1),
	('Мишагин',1),
	('Зырянов',1),
	('Михалин',1),
	('Лозбинев',1),
	('Аушев',1),
	('Новожилов',1),
	('Лутошкин',1),
	('Ковалёв',1),
	('Дураков',1),
	('Некрасов',1),
	('Харламов',1),
	('Наврузов',1),
	('Закащиков',1),
	('Железняков',1),
	('Недошивин',1),
	('Булыгин',1),
	('Назаров',1),
	('Цветков',1),
	('Микулин',1),
	('Нагульнов',1),
	('Охромеев',1),
	('Замятин',1),
	('Нестеров',1),
	('Варлов',1),
	('Черкесов',1),
	('Дымов',1),
	('Шлякотин',1),
	('Карпычев',1),
	('Звенигородцев',1),
	('Беляев',1),
	('Важенин',1),
	('Михалкин',1),
	('Лютов',1),
	('Бибиков',1),
	('Молоснов',1),
	('Мишанин',1),
	('Буков',1),
	('Гмырин',1),
	('Вельмукин',1),
	('Ветошников',1),
	('Недодаев',1),
	('Зарудин',1),
	('Мишуточкин',1),
	('Ломовцев',1),
	('Мишин',1),
	('Лабазанов',1),
	('Марков',1),
	('Анохин',1),
	('Шляпкин',1),
	('Заказчиков',1),
	('Гуров',1),
	('Мишуров',1),
	('Бессарабов',1),
	('Минеев',1),
	('Васин',1),
	('Мячин',1),
	('Чудинов',1),
	('Лабзин',1),
	('Галанин',1),
	('Батраков',1),
	('Девяткин',1),
	('Сидоркин',1),
	('Пушкин',1),
	('Новиков',1),
	('Недогадов',1),
	('Остапов',1),
	('Москвичёв',1),
	('Коновалов ',1),
	('Мелехов',1),
	('Мусатов',1),
	('Свеженцев',1),
	('Синельников',1),
	('Мирошкин',1),
	('Наслузов',1),
	('Еськов',1),
	('Колесников',1),
	('Откупщиков',1),
	('Недомеров',1),
	('Михалков',1),
	('Осташков',1),
	('Забродин',1),
	('Степанцов',1),
	('Левышев',1),
	('Беклов',1),
	('Михлин',1),
	('Залыгин',1),
	('Недопекин',1),
	('Никулин',1),
	('Ларюшкин',1),
	('Щелчков',1),
	('Мызников',1),
	('Арзамасцев',1),
	('Каманин',1),
	('Неофидов',1),
	('Ларионов',1),
	('Воргин',1),
	('Поваров',1),
	('Базулин',1),
	('Булгаков',1),
	('Силкин',1),
	('Егин',1),
	('Ширилов',1),
	('Галанкин',1),
	('Амелякин',1),
	('Мухортов',1),
	('Бронников',1),
	('Митряев',1),
	('Еранцев',1),
	('Воронов',1),
	('Ванслов',1),
	('Атиков',1),
	('Забусов',1),
	('Дроздов',1),
	('Нездольев',1),
	('Чернышёв',1),
	('Акиншин',1),
	('Трофимов',1),
	('Гамаюнов',1),
	('Муратов',1),
	('Вересаев',1),
	('Мишутин',1),
	('Недомолвин',1),
	('Доверов',1),
	('Солонин',1),
	('Ерошин',1),
	('Зверев',1),
	('Ларюшин',1),
	('Братухин',1),
	('Недогонов',1),
	('Мишунькин',1),
	('Осминин',1),
	('Буздырин',1),
	('Коркин',1),
	('Алексеев',1),
	('Карамышев',1),
	('Щедрин',1),
	('Казанцев',1),
	('Михайлов',1),
	('Карпушин',1),
	('Степашин',1),
	('Недосеев',1),
	('Асадов',1),
	('Лошкомоев',1),
	('Янин',1),
	('Алюшников',1),
	('Зайцев',1),
	('Балахонов',1),
	('Гордеев',1),
	('Болгов',1),
	('Ледяйкин',1),
	('Донцов',1),
	('Мусаков',1),
	('Таныгин',1),
	('Кабанов',1),
	('Майоров',1),
	('Фролов',1),
	('Истифеев',1),
	('Мадаев',1),
	('Девятнин',1),
	('Майков',1),
	('Амилеев',1),
	('Четвериков',1),
	('Рыков',1),
	('Лексин',1),
	('Родин',1),
	('Баратаев',1),
	('Недоглядов',1),
	('Наследышев',1),
	('Басалаев',1),
	('Никуличев',1),
	('Изотов',1),
	('Шустров',1),
	('Мишечкин',1),
	('Калашников',1),
	('Бочаров',1),
	('Калабухов',1),
	('Лалетин',1),
	('Авдеев',1),
	('Добин',1),
	('Лядов',1),
	('Найдёнов',1),
	('Гагарин',1),
	('Непомнящев',1),
	('Манихин',1),
	('Галимов',1),
	('Клейменов',1),
	('Ермаков',1),
	('Столяров',1),
	('Бавин',1),
	('Киров',1),
	('Бражников',1),
	('Дерябин',1),
	('Мещеринов',1),
	('Михалычев',1),
	('Рычков',1),
	('Огуреев',1),
	('Муравцев',1),
	('Давыдов',1),
	('Горбачёв',1),
	('Гандурин',1),
	('Зимин',1),
	('Артемьев',1),
	('Ляков',1),
	('Гузеев',1),
	('Абрамов',1),
	('Насонов',1),
	('Евтухов',1),
	('Вахромеев',1),
	('Черномырдин',1),
	('Ваганов',1),
	('Веденеев',1),
	('Михалев',1),
	('Недосекин',1),
	('Шехин',1),
	('Ерастов',1),
	('Авлов',1),
	('Осьмухин',1),
	('Андрианов',1),
	('Бывшев',1),
	('Чанов',1),
	('Кадомцев',1),
	('Ипутатов',1),
	('Максутов',1),
	('Лисицын',1),
	('Миханькин',1),
	('Дементьев',1),
	('Окладников',1),
	('Галамов',1),
	('Денисов',1),
	('Бабушкин',1),
	('Бандурин',1),
	('Илларионов',1),
	('Жернов',1),
	('Бунин',1),
	('Истратов',1),
	('Бармин',1),
	('Верьянов',1),
	('Вуколов',1),
	('Дедушкин',1),
	('Мишаков',1),
	('Федчин',1),
	('Наседкин',1),
	('Тихомиров',1),
	('Жуков',1),
	('Паньшин',1),
	('Лариошкин',1),
	('Евлампиев',1),
	('Рогозин',1),
	('Гнатов',1),
	('Халтурин',1),
	('Самашов',1),
	('Авлуков',1),
	('Големов',1),
	('Примаков',1),
	('Ванюлин',1),
	('Долгов',1),
	('Лисин',1),
	('Мотовилов',1),
	('Власов',1),
	('Глухов',1),
	('Комолов',1),
	('Чичварин',1),
	('Новодерёжкин',1),
	('Волокитин',1),
	('Лесанов',1),
	('Мишурин',1),
	('Гаврилов',1),
	('Душечкин',1),
	('Лялин',1),
	('Мишулин',1),
	('Алаев',1),
	('Меркулов',1),
	('Кашеваров',1),
	('Вергизов',1),
	('Бакланов',1),
	('Калганов',1),
	('Кашицын',1),
	('Каёхтин',1),
	('Ошурков',1),
	('Ларьков',1),
	('Воеводин',1),
	('Михаев',1),
	('Истомин',1),
	('Башуткин',1),
	('Максаков',1),
	('Федотов',1),
	('Ергин',1),
	('Усиков',1),
	('Недобитов',1),
	('Душкин',1),
	('Алымов',1),
	('Нефёдочкин',1),
	('Попов',1),
	('Бурнашов',1),
	('Дорин',1),
	('Ряхов',1),
	('Безруков',1),
	('Дежнов',1),
	('Бородин',1),
	('Фрыгин',1),
	('Бектуганов',1),
	('Пахомов',1),
	('Останин',1),
	('Андросов',1),
	('Новокшонов',1),
	('Ожгибесов',1),
	('Никульшин',1),
	('Бурмистов',1),
	('Казаков',1),
	('Верижников',1),
	('Капитонов',1),
	('Серов',1),
	('Платонов',1),
	('Еманов',1),
	('Голицын',1),
	('Лескин',1),
	('Лимарев',1),
	('Охрютин',1),
	('Ламзин',1),
	('Железнов',1),
	('Нахабин',1),
	('Бухаров',1),
	('Бадыгин',1),
	('Асланов',1),
	('Панкратов',1),
	('Недотыкин',1),
	('Евстафьев',1),
	('Лешаков',1),
	('Ивашов',1),
	('Ерошкин',1),
	('Невьянцев',1),
	('Ляпичев',1),
	('Дятлов',1),
	('Лисовин',1),
	('Лындяев',1),
	('Минакин',1),
	('Белоглазов',1),
	('Лазлов',1),
	('Ларькин',1),
	('Лобанов',1),
	('Коробов',1),
	('Логинов',1),
	('Недокукин',1),
	('Кадыков',1),
	('Винаров',1),
	('Тряпичкин',1),
	('Рябикин',1),
	('Маёров',1),
	('Каракозов',1),
	('Варакин',1),
	('Мазуров',1),
	('Смехов',1),
	('Кадыров',1),
	('Ломов',1),
	('Момотов',1),
	('Юдин',1),
	('Лыткин',1),
	('Нижегородцев',1),
	('Чернов',1),
	('Батманов',1),
	('Малышкин',1),
	('Недозрелов',1),
	('Мишунин',1),
	('Наточнев',1),
	('Акиньшин',1),
	('Мурхабинов',1),
	('Юлдашев',1),
	('Хабибуллин',1),
	('Лашманов',1),
	('Карпов',1),
	('Ососков',1),
	('Визгалов',1),
	('Ахрамеев',1),
	('Второв',1),
	('Дронин',1),
	('Лемешев',1),
	('Аршинников',1),
	('Щербатов',1),
	('Балдин',1),
	('Вешняков',1),
	('Ерлыченков',1),
	('Егошин',1),
	('Бухонин',1),
	('Меланьин',1),
	('Амченцев',1),
	('Лялькин',1),
	('Антонов',1),
	('Багин',1),
	('Нарышкин',1),
	('Лындин',1),
	('Осьминин',1),
	('Ахмадуллина',1),
	('Нехаев',1),
	('Кузнецов',1),
	('Комаров',1),
	('Ворохобин',1),
	('Неёлов',1),
	('Гурьянов',1),
	('Лапин',1),
	('Неретин',1),
	('Елпидин',1),
	('Шестаков',1),
	('Малашкин',1),
	('Шанов',1),
	('Тункин',1),
	('Жулидов',1),
	('Монахов',1),
	('Яньков',1),
	('Аверин',1),
	('Гоглачёв',1),
	('Гонохов',1),
	('Мамонтов',1),
	('Нагаев',1),
	('Буданов',1),
	('Бабкин',1),
	('Клочков',1),
	('Максютов',1),
	('Зотов',1),
	('Закутин',1),
	('Острокопытов',1),
	('Кабин',1),
	('Леонтьев',1),
	('Карпичев',1),
	('Иринархов',1),
	('Малафеев',1),
	('Недохлебов',1),
	('Мирошников',1),
	('Баландин',1),
	('Маклаков',1),
	('Шебалкин',1),
	('Десятов',1),
	('Лямин',1)
go

INSERT INTO names_l (lastname, gender) VALUES
	('Мижурин',1),
	('Дерюгин',1),
	('Нефёдов',1),
	('Ненашев',1),
	('Говендяев',1),
	('Кудрин',1),
	('Близняков',1),
	('Батюшков',1),
	('Гладышев',1),
	('Завражнов',1),
	('Слюдачёв',1),
	('Агуреев',1),
	('Позолотин',1),
	('Недоспасов',1),
	('Петров',1),
	('Вырошников',1),
	('Баранов',1),
	('Щербаков',1),
	('Скороходов',1),
	('Митрошкин',1),
	('Калюгин',1),
	('Напалков',1),
	('Минин',1),
	('Мишуткин',1),
	('Ерёмин',1),
	('Леонов',1),
	('Лаптев',1),
	('Митрохин',1),
	('Астапов',1),
	('Сладков',1),
	('Майданов',1),
	('Аратов',1),
	('Недожогин',1),
	('Проханов',1),
	('Однодворцев',1),
	('Мурсякаев',1),
	('Шашурин',1),
	('Недоквасов',1),
	('Шумаков',1),
	('Аношкин',1),
	('Бабурин',1),
	('Доможиров',1),
	('Морюнин',1),
	('Евлахов',1),
	('Волосатов',1),
	('Голоднов',1),
	('Тихоходов',1),
	('Ширяев',1),
	('Любимцев',1),
	('Осьминкин',1),
	('Ерохин',1),
	('Маркин',1),
	('Вараксин',1),
	('Недокладов',1),
	('Недоносков',1),
	('Бакулин',1),
	('Носаев',1),
	('Синякин',1),
	('Нефедьев',1),
	('Белоярцев',1),
	('Багаев',1),
	('Веретинов',1),
	('Лутошин',1),
	('Наточеев',1),
	('Лёвочкин',1),
	('Закатов',1),
	('Онегин',1),
	('Дюжев',1),
	('Надеин',1),
	('Деревятин',1),
	('Лалитин',1),
	('Выростов',1),
	('Минаев',1),
	('Гандыбин',1),
	('Андронников',1),
	('Куликов',1),
	('Осьмаков',1),
	('Лутохин',1),
	('Зюганов',1),
	('Егоров',1),
	('Беднов',1),
	('Арутюнов',1),
	('Качулин',1),
	('Гаршин',1),
	('Мымликов',1),
	('Неделин',1),
	('Дробышев',1),
	('Волостнов',1),
	('Желваков',1),
	('Башутин',1),
	('Белов',1),
	('Евланин',1),
	('Жаринов',1),
	('Алимов',1),
	('Оплетаев',1),
	('Жмакин',1),
	('Исаев',1),
	('Васильев',1),
	('Ноговицын',1),
	('Проханова',2),
	('Абрамцева',2),
	('Годунова',2),
	('Бадыгина',2),
	('Каймакова',2),
	('Недошивина',2),
	('Ламзина',2),
	('Башутина',2),
	('Батманова',2),
	('Лындяева',2),
	('Лешакова',2),
	('Журавлёва',2),
	('Арзамасцева',2),
	('Ермакова',2),
	('Бабакова',2),
	('Ошуркова',2),
	('Мотовилова',2),
	('Чернышёва',2),
	('Десятова',2),
	('Лалитина',2),
	('Слюдачёва',2),
	('Карпичева',2),
	('Шебалкина',2),
	('Девятова',2),
	('Найдёнова',2),
	('Евланина',2),
	('Мишакова',2),
	('Романова',2),
	('Визгалова',2),
	('Лемяхова',2),
	('Девятаева',2),
	('Атикова',2),
	('Оськина',2),
	('Маннапова',2),
	('Тарханова',2),
	('Новокшонова',2),
	('Истомина',2),
	('Лютова',2),
	('Минина',2),
	('Лешукова',2),
	('Занозина',2),
	('Бакулина',2),
	('Лякова',2),
	('Ногаева',2),
	('Дерябина',2),
	('Недоросткова',2),
	('Мазурова',2),
	('Беспалова',2),
	('Баранова',2),
	('Багаева',2),
	('Чичварина',2),
	('Леонова',2),
	('Дедушкина',2),
	('Дорикова',2),
	('Янина',2),
	('Мусакова',2),
	('Нестерова',2),
	('Недосеева',2),
	('Злобина',2),
	('Евлашова',2),
	('Выжлецова',2),
	('Еманова',2),
	('Евдокимова',2),
	('Задерихина',2),
	('Ванюлина',2),
	('Бибикова',2),
	('Недокукина',2),
	('Вышеславцева',2),
	('Маркова',2),
	('Айдуллина',2),
	('Бочарова',2),
	('Бухонина',2),
	('Михайлина',2),
	('Мусатова',2),
	('Витина',2),
	('Лялина',2),
	('Гоглачёва',2),
	('Богданова',2),
	('Долматова',2),
	('Вешнякова',2),
	('Големова',2),
	('Архипова',2),
	('Тукмакова',2),
	('Недоноскова',2),
	('Мадаева',2),
	('Баратаева',2),
	('Багдасарян',2),
	('Глаголева',2),
	('Бунина',2),
	('Белова',2),
	('Ерошкина',2),
	('Неретина',2),
	('Бронникова',2),
	('Носаева',2),
	('Андросова',2),
	('Забродина',2),
	('Закутина',2),
	('Киселёва',2),
	('Анохина',2),
	('Щербатова',2),
	('Столярова',2),
	('Сергеева',2),
	('Вострокопытова',2),
	('Недомолвина',2),
	('Мызникова',2),
	('Нечаева',2),
	('Забусова',2),
	('Лапина',2),
	('Дюкарева',2),
	('Нохрина',2),
	('Голицына',2),
	('Недосекина',2),
	('Румянцева',2),
	('Откупщикова',2),
	('Железнякова',2),
	('Осьминина',2),
	('Гандурина',2),
	('Мазова',2),
	('Мишутина',2),
	('Дедова',2),
	('Благинина',2),
	('Душечкина',2),
	('Малахова',2),
	('Недозевина',2),
	('Жмакина',2),
	('Михлина',2),
	('Щелчкова',2),
	('Молостнова',2),
	('Васина',2),
	('Лексикова',2),
	('Попова',2),
	('Веретинова',2),
	('Александрова',2),
	('Харламова',2),
	('Лозбинева',2),
	('Капитонова',2),
	('Голоднова',2),
	('Беглова',2),
	('Галамова',2),
	('Бектуганова',2),
	('Бестужева',2),
	('Мишечкина',2),
	('Мишурова',2),
	('Еськова',2),
	('Карпочкина',2),
	('Майкова',2),
	('Ликунова',2),
	('Желвакова',2),
	('Силкина',2),
	('Денисова',2),
	('Закатова',2),
	('Шехина',2),
	('Кадомцева',2),
	('Охромеева',2),
	('Андрианова',2),
	('Тимофеева',2),
	('Екимова',2),
	('Астапова',2),
	('Ерёмина',2),
	('Ковалёва',2),
	('Воронова',2),
	('Остроушко',2),
	('Мишунина',2),
	('Ларюхина',2),
	('Мухортова',2),
	('Недожорова',2),
	('Мушкетова',2),
	('Нефедьева',2),
	('Минакина',2),
	('Новодерёжкина',2),
	('Дежнова',2),
	('Мымликова',2),
	('Демидова',2),
	('Карпеева',2),
	('Алексеева',2),
	('Мелехова',2),
	('Ларина',2),
	('Любимова',2),
	('Дорожкина',2),
	('Михайлова',2),
	('Лариошкина',2),
	('Ларюшина',2),
	('Винарова',2),
	('Майорова',2),
	('Базулина',2),
	('Буробина',2),
	('Наследышева',2),
	('Нефёдова',2),
	('Калинина',2),
	('Белоярцева',2),
	('Ряхова',2),
	('Еранцева',2),
	('Авлукова',2),
	('Ерошина',2),
	('Ванслова',2),
	('Михалычева',2),
	('Бутусова',2),
	('Васильева',2),
	('Недоквасова',2),
	('Наровчатова',2),
	('Нистратова',2),
	('Березина',2),
	('Егина',2),
	('Волокитина',2),
	('Лобанова',2),
	('Мишурина',2),
	('Вуколова',2),
	('Ососкова',2),
	('Синякина',2),
	('Лескина',2),
	('Доможирова',2),
	('Нагульнова',2),
	('Бахтиярова',2),
	('Важенина',2),
	('Лашманова',2),
	('Макарова',2),
	('Горбачёва',2),
	('Бершова',2),
	('Недогонова',2),
	('Арутюнова',2),
	('Нехаева',2),
	('Недовесова',2),
	('Дорохова',2),
	('Евлашина',2),
	('Шашурина',2),
	('Логинова',2),
	('Викторова',2),
	('Близнякова',2),
	('Мишагина',2),
	('Ергина',2),
	('Муравлёва',2),
	('Зюганова',2),
	('Ожгибесова',2),
	('Галимова',2),
	('Карпунина',2),
	('Четверикова',2),
	('Ермошкина',2),
	('Ширилова',2),
	('Ломовцева',2),
	('Цветкова',2),
	('Шлякотина',2),
	('Митрохина',2),
	('Бакунина',2),
	('Наврузова',2),
	('Лимарева',2),
	('Лисина',2),
	('Степашина',2),
	('Кашицына',2),
	('Пушкина',2),
	('Григорьева',2),
	('Юдина',2),
	('Асланова',2),
	('Демихова',2),
	('Максютова',2),
	('Примакова',2),
	('Воронина',2),
	('Астафьева',2),
	('Арчакова',2),
	('Тихоходова',2),
	('Листратова',2),
	('Любимцева',2),
	('Каёхтина',2),
	('Казакова',2),
	('Лесанова',2),
	('Ерлыченкова',2),
	('Непомнящева',2),
	('Верижникова',2),
	('Балашова',2),
	('Дахнова',2),
	('Напалкова',2),
	('Ларюшкина',2),
	('Мичурина',2),
	('Михаева',2),
	('Клочкова',2),
	('Вергизова',2),
	('Добина',2),
	('Вараксина',2),
	('Недоспасова',2),
	('Майданова',2),
	('Лызлова',2),
	('Недопекина',2),
	('Микулина',2),
	('Трубачёва',2),
	('Сорокина',2),
	('Солонина',2),
	('Лалетина',2),
	('Калганова',2),
	('Андронникова',2),
	('Башуткина',2),
	('Зарудина',2),
	('Соколова',2),
	('Самашова',2),
	('Сюткина',2),
	('Мещеринова',2),
	('Лутошкина',2),
	('Лисицына',2),
	('Лындина',2),
	('Исаева',2),
	('Бакланова',2),
	('Лялькина',2),
	('Кадырова',2),
	('Максутова',2),
	('Паньшина',2),
	('Однодворцева',2),
	('Муштакова',2),
	('Маклакова',2),
	('Дягилева',2),
	('Горетова',2),
	('Дёмина',2),
	('Митряева',2),
	('Ларькина',2),
	('Кузнецова',2),
	('Ларькова',2),
	('Изотова',2),
	('Коробова',2),
	('Алюшникова',2),
	('Янькова',2),
	('Букова',2),
	('Гурьянова',2),
	('Доверова',2),
	('Дронина',2),
	('Давыдова',2),
	('Кравцова',2),
	('Наточнева',2),
	('Гладышева',2),
	('Гурова',2),
	('Мирошкина',2),
	('Мишуточкина',2),
	('Беклова',2),
	('Мурина',2),
	('Васнецова',2),
	('Бабанина',2),
	('Недогадова',2),
	('Дымова',2),
	('Зверева',2),
	('Фролова',2),
	('Дебособрова',2),
	('Голованева',2),
	('Гонохова',2),
	('Зюряева',2),
	('Тихомирова',2),
	('Аушева',2),
	('Мурсякаева',2),
	('Бородина',2),
	('Бабина',2),
	('Нездольева',2),
	('Меркулова',2),
	('Алымова',2),
	('Гринькова',2),
	('Лутошина',2),
	('Осташкова',2),
	('Комолова',2),
	('Ерастова',2),
	('Маркина',2),
	('Лутошникова',2),
	('Щербакова',2),
	('Ишмухаметова',2),
	('Мингалёва',2),
	('Гандыбина',2),
	('Беляева',2),
	('Мишкина',2),
	('Петрова',2),
	('Спиридонова',2),
	('Назарова',2),
	('Воргина',2),
	('Миронова',2),
	('Михалева',2),
	('Карагодина',2),
	('Молоканова',2),
	('Зайцева',2),
	('Мирошникова',2),
	('Ваганова',2),
	('Рогозина',2),
	('Чумакова',2),
	('Бражникова',2),
	('Кудрина',2),
	('Дежнева',2),
	('Панкратова',2),
	('Гамаюнова',2),
	('Малафеева',2),
	('Чернозёмова',2),
	('Куликова',2),
	('Недобитова',2),
	('Лаушкина',2),
	('Лемешева',2),
	('Муратова',2),
	('Каманина',2),
	('Звенигородцева',2),
	('Буконина',2),
	('Медвенцева',2),
	('Ломова',2),
	('Шаймарданова',2),
	('Балахонова',2),
	('Останина',2),
	('Недоглядова',2),
	('Амченцева',2),
	('Сидорова',2),
	('Лазлова',2),
	('Бармина',2),
	('Бессарабова',2),
	('Амелякина',2),
	('Безрукова',2),
	('Истифеева',2),
	('Максакова',2),
	('Миханькина',2),
	('Недосказова',2),
	('Бузунова',2),
	('Жулидова',2),
	('Ветошникова',2),
	('Свердлова',2),
	('Недосейкина',2),
	('Железнова',2),
	('Веньчакова',2),
	('Бывшева',2),
	('Ворошилова',2),
	('Лёвочкина',2),
	('Аратова',2),
	('Усикова',2),
	('Ерашева',2),
	('Лабазанова',2),
	('Золотавина',2),
	('Щедрина',2),
	('Дюжева',2),
	('Крылова',2),
	('Недокладова',2),
	('Лаптева',2),
	('Харланова',2),
	('Неприна',2),
	('Заказчикова',2),
	('Нагайцева',2),
	('Ворохобина',2),
	('Малышкина',2),
	('Донцова',2),
	('Дятлова',2),
	('Пугачева',2),
	('Ерохина',2),
	('Наточеева',2),
	('Братухина',2),
	('Авлова',2),
	('Нежданова',2),
	('Охохонина',2),
	('Елпидина',2),
	('Акиншина',2),
	('Мынкина',2),
	('Лабзина',2),
	('Рыбина',2),
	('Недоплясова',2),
	('Шляпкина',2),
	('Недочётова',2),
	('Наговицына',2),
	('Капустина',2),
	('Дробышева',2),
	('Евсеева',2),
	('Нагаева',2),
	('Леонтьева',2),
	('Второва',2),
	('Кашеварова',2),
	('Ивашова',2),
	('Выростова',2),
	('Ляхова',2),
	('Рябикина',2),
	('Сладкова',2),
	('Галанина',2),
	('Чунова',2),
	('Гаршина',2),
	('Евланова',2),
	('Казанцева',2),
	('Рыбакова',2),
	('Горохова',2),
	('Михалищева',2),
	('Бабаева',2),
	('Вересаева',2),
	('Гамзулина',2),
	('Михалкова',2),
	('Дианова',2),
	('Мишухина',2),
	('Басалаева',2),
	('Никулина',2),
	('Лаврова',2),
	('Веденяпина',2),
	('Забирова',2),
	('Лихарева',2),
	('Новомлинцева',2),
	('Егорова',2),
	('Винокурова',2),
	('Евлампиева',2),
	('Сидоркина',2),
	('Кириллова',2),
	('Бурнашова',2),
	('Некрасова',2),
	('Балябина',2),
	('Жаринова',2),
	('Бутакова',2),
	('Михалкина',2),
	('Поварницина',2),
	('Жукова',2),
	('Мишина',2),
	('Левышева',2),
	('Каракозова',2),
	('Мишанина',2),
	('Мишукина',2),
	('Новикова',2),
	('Закащикова',2),
	('Качулина',2),
	('Богдашкина',2),
	('Брыкина',2),
	('Меланьина',2),
	('Карпушина',2),
	('Недомерова',2),
	('Лямина',2),
	('Волосатова',2),
	('Варлова',2),
	('Бухарова',2),
	('Мишакина',2),
	('Жеребина',2),
	('Нарышкина',2),
	('Булгакова',2),
	('Буданова',2),
	('Родина',2),
	('Евлахова',2),
	('Баглай',2),
	('Поварова',2),
	('Ирошникова',2),
	('Кадышева',2),
	('Дуракова',2),
	('Колесникова',2),
	('Осьмакова',2),
	('Багина',2),
	('Неёлова',2),
	('Верьянова',2),
	('Говендяева',2),
	('Кирова',2),
	('Федчина',2),
	('Карпова',2),
	('Молоснова',2),
	('Черномырдина',2),
	('Глазьева',2),
	('Демичева',2),
	('Оплетаева',2),
	('Гузеева',2),
	('Чудинова',2),
	('Зырянова',2),
	('Онегина',2),
	('Наслузова',2),
	('Федотова',2),
	('Недокучаева',2),
	('Морозова',2),
	('Шустрова',2),
	('Осминина',2),
	('Шумакова',2),
	('Агуреева',2),
	('Окладникова',2),
	('Глухова',2),
	('Оношкина',2),
	('Дерюгина',2),
	('Недачина',2),
	('Зенкина',2),
	('Неофидова',2),
	('Синельникова',2),
	('Алаева',2),
	('Карпикова',2),
	('Алампиева',2),
	('Краснощёкова',2),
	('Варакина',2),
	('Девятнина',2),
	('Мамонтова',2),
	('Батракова',2),
	('Никульшина',2),
	('Залыгина',2),
	('Нижегородцева',2),
	('Вельмукина',2),
	('Бабурина',2),
	('Гагарина',2),
	('Осьминкина',2),
	('Недожогина',2),
	('Астахова',2),
	('Минеева',2),
	('Булыгина',2),
	('Ипутатова',2),
	('Дорина',2),
	('Нахабина',2),
	('Карамышева',2),
	('Поливанова',2),
	('Вырошникова',2),
	('Малашкина',2),
	('Насонова',2),
	('Кунцева',2),
	('Лядова',2),
	('Никуличева',2),
	('Морюнина',2),
	('Евтухова',2),
	('Неделина',2),
	('Алимова',2),
	('Вахромеева',2),
	('Черкесова',2),
	('Фрыгина',2),
	('Лошкомоева',2),
	('Антонова',2),
	('Жернова',2),
	('Чанова',2),
	('Корубина',2),
	('Бурмистрова',2),
	('Рычкова',2),
	('Москвичёва',2),
	('Наседкина',2),
	('Болгова',2),
	('Воеводина',2),
	('Барашкова',2),
	('Лохтина',2),
	('Гнатова',2),
	('Новожилова',2),
	('Момотова',2),
	('Бавина',2),
	('Лутохина',2),
	('Кузьмина',2),
	('Осьмухина',2),
	('Недозрелова',2),
	('Миханкина',2),
	('Мишулина',2),
	('Булатова',2),
	('Галанкина',2),
	('Смехова',2),
	('Кадыкова',2),
	('Мишуткина',2),
	('Егошина',2),
	('Загудалова',2),
	('Карпушкина',2),
	('Ноговицына',2),
	('Мещерякова',2),
	('Рыкова',2),
	('Королёва',2),
	('Деревятина',2),
	('Тряпичкина',2),
	('Ковалькова',2),
	('Гималетдинова',2),
	('Бабкина',2),
	('Мячина',2),
	('Степанцова',2),
	('Лунина',2),
	('Митрошкина',2),
	('Авдеева',2),
	('Волостнова',2),
	('Буздырина',2),
	('Иринархова',2),
	('Бурмистова',2),
	('Маёрова',2),
	('Лисовина',2),
	('Душкина',2),
	('Охрютина',2),
	('Ширяева',2),
	('Баландина',2),
	('Захарова',2),
	('Степанькова',2),
	('Трофимова',2),
	('Панова',2),
	('Илларионова',2),
	('Нефёдочкина',2),
	('Ахряпова',2),
	('Скороходова',2),
	('Минаева',2),
	('Грызлова',2),
	('Абрамова',2),
	('Горюнова',2),
	('Ненашкина',2),
	('Шанова',2),
	('Медведева',2),
	('Калашникова',2),
	('Амилеева',2),
	('Моржеретова',2),
	('Негодяева',2),
	('Аривошкина',2),
	('Артемьева',2),
	('Нагибина',2),
	('Надежина',2),
	('Михалина',2),
	('Ефимочкина',2),
	('Балдина',2),
	('Витютиева',2),
	('Мельгунова',2),
	('Лесун',2),
	('Евсенчева',2),
	('Лукшина',2),
	('Евстафьева',2),
	('Гмырина',2),
	('Касьянова',2),
	('Клейменова',2),
	('Ледяйкина',2),
	('Гаврилова',2),
	('Ермолина',2),
	('Аношкина',2),
	('Близнюкова',2),
	('Недотыкина',2),
	('Огуреева',2),
	('Дьякова',2),
	('Салимова',2),
	('Шестакова',2),
	('Недохлебова',2),
	('Монахова',2),
	('Мысина',2),
	('Гордеева',2),
	('Лесина',2),
	('Ненашева',2),
	('Будаева',2),
	('Перумова',2),
	('Андреева',2),
	('Завражнова',2),
	('Ляпичева',2),
	('Назимова',2),
	('Бушмина',2),
	('Недодаева',2),
	('Кабанова',2),
	('Муравцева',2),
	('Ахрамеева',2),
	('Зимина',2),
	('Чернова',2),
	('Лексина',2),
	('Зотова',2),
	('Девяткина',2),
	('Долгова',2),
	('Позолотина',2),
	('Невьянцева',2),
	('Бахолдина',2),
	('Микифорова',2),
	('Веденеева',2),
	('Волкова',2),
	('Платонова',2),
	('Каганцева',2),
	('Голямова',2),
	('Буянтуева',2),
	('Божкова',2),
	('Недобоева',2),
	('Лихачёва',2),
	('Остапова',2),
	('Асадова',2),
	('Надеина',2),
	('Мутылина',2),
	('Бабушкина',2),
	('Власова',2),
	('Кандаурова',2),
	('Лыткина',2),
	('Олейникова',2),
	('Замятина',2),
	('Смирнова',2),
	('Острокопытова',2),
	('Мижурина',2),
	('Бахорина',2),
	('Мишенина',2),
	('Манихина',2),
	('Аршинникова',2),
	('Калюгина',2),
	('Свеженцева',2),
	('Калабухова',2),
	('Мишунькина',2),
	('Дементьева',2),
	('Комарова',2),
	('Батюшкова',2);

go

DROP TABLE IF EXISTS names_m;

go

CREATE TABLE names_m (
  id         int           NOT NULL identity(1,1),
  middlename nvarchar(70)  DEFAULT NULL,
  gender     int           DEFAULT NULL check(gender in (1,2)),
  constraint PK_ID_names_m PRIMARY KEY (id),
) 


go


INSERT INTO names_m (middlename, gender)
VALUES
	('Александрович',1),
	('Алексеевич',1),
	('Альбертович',1),
	('Анатольевич',1),
	('Андреевич',1),
	('Антонович',1),
	('Арсланович',1),
	('Афанасьевич',1),
	('Богданович',1),
	('Борисович',1),
	('Вадимович',1),
	('Валентинович',1),
	('Валерьевич',1),
	('Васильевич',1),
	('Викторович',1),
	('Витальевич',1),
	('Владимирович',1),
	('Владиславович',1),
	('Власиевич',1),
	('Всеволодович',1),
	('Вячеславович',1),
	('Геннадьевич',1),
	('Георгиевич',1),
	('Григорьевич',1),
	('Данилович',1),
	('Даянович',1),
	('Денисович',1),
	('Дмитриевич',1),
	('Евгеньевич',1),
	('Егорович',1),
	('Емельянович',1),
	('Захарович',1),
	('Иванович',1),
	('Игоревич',1),
	('Ильич',1),
	('Касьянович',1),
	('Кириллович',1),
	('Константинович',1),
	('Ксенофонтович',1),
	('Кузьмич',1),
	('Леонидович',1),
	('Леопольдович',1),
	('Львович',1),
	('Макарович',1),
	('Максимович',1),
	('Михайлович',1),
	('Никитич',1),
	('Никифорович',1),
	('Николаевич',1),
	('Олегович',1),
	('Павлович',1),
	('Петрович',1),
	('Платонович',1),
	('Романович',1),
	('Русланович',1),
	('Сергеевич',1),
	('Станиславович',1),
	('Степанович',1),
	('Тимофеевич',1),
	('Тимурович',1),
	('Трофимович',1),
	('Фанисович',1),
	('Фёдорович',1),
	('Федотович',1),
	('Фомич',1),
	('Эдуардович',1),
	('Юрьевич',1),
	('Яковлевич',1),
	('Александровна',2),
	('Алексеевна',2),
	('Альбертовна',2),
	('Анатольевна',2),
	('Андреевна',2),
	('Антоновна',2),
	('Аркадьевна',2),
	('Афанасьевна',2),
	('Богдановна',2),
	('Борисовна',2),
	('Вадимовна',2),
	('Валентиновна',2),
	('Валерьевна',2),
	('Васильевна',2),
	('Викторовна',2),
	('Витальевна',2),
	('Владимировна',2),
	('Владиславовна',2),
	('Власиевна',2),
	('Всеволодовна',2),
	('Вячеславовна',2),
	('Геннадьевна',2),
	('Георгиевна',2),
	('Григорьевна',2),
	('Даниловна',2),
	('Денисовна',2),
	('Дмитриевна',2),
	('Евгеньевна',2),
	('Егоровна',2),
	('Емельяновна',2),
	('Захаровна',2),
	('Ивановна',2),
	('Игоревна',2),
	('Ильинична',2),
	('Касьяновна',2),
	('Кирилловна',2),
	('Константиновна',2),
	('Ксенофонтовна',2),
	('Кузьминична',2),
	('Леонидовна',2),
	('Леопольдовна',2),
	('Львовна',2),
	('Макаровна',2),
	('Максимовна',2),
	('Маратовна',2),
	('Михайловна',2),
	('Никитична',2),
	('Никифоровна',2),
	('Николаевна',2),
	('Олеговна',2),
	('Павловна',2),
	('Петровна',2),
	('Платоновна',2),
	('Рамилевна',2),
	('Романовна',2),
	('Руслановна',2),
	('Саматовна',2),
	('Сергеевна',2),
	('Станиславовна',2),
	('Степановна',2),
	('Султангалиевна',2),
	('Суреновна',2),
	('Тимофеевна',2),
	('Тимуровна',2),
	('Трифоновна',2),
	('Трофимовна',2),
	('Фёдоровна',2),
	('Федотовна',2),
	('Фоминична',2),
	('Эдуардовна',2),
	('Юрьевна',2),
	('Явдатовна',2),
	('Яковлевна',2);
go

commit

