﻿
/*
begin tran  --Если с самого начала создаётся на с ID равным = 1, то можно обновить таблицу с помощью процы, и заполнить таблицу.
if exists 
	  (	  
	  	SELECT name,last_value 
	  	FROM sys.identity_columns 
	  	WHERE object_id = OBJECT_ID('dbo.The_Subgroup') 
	  		AND last_value IS not NULL 	  
	  )
	  begin
	  DBCC CHECKIDENT ('dbo.The_Subgroup ', RESEED, 0)
	  end
--rollback
SELECT name,last_value 
FROM sys.identity_columns 
WHERE object_id = OBJECT_ID('dbo.The_Subgroup')
commit
go
*/


use Magaz_DB
go
set nocount,xact_abort on
go
begin tran
insert into The_Subgroup (ID_Group,Name_The_Subgroup,ID_Branch,ID_Parent_The_Subgroup)
values
--(1,'Финансовый депортамент'197)
     --(1,'Отдел бухгалтерского учёта',197),
	      (1,'По учёту основных средств',14,NULL)  
,		  (1,'По учёту расчетов с контрагентами',14,NULL)
,		  (1,'По учёту зарплаты и кадров',14,NULL)
,		  (1,'По подготовке финансовой отчётности',14,NULL)
     --(1,'Отдел финансового планирования и анализа',197),
,	      (2,'По бюджетированию',15,NULL)
,		  (2,'По финансовому моделированию',15,NULL)
,		  (2,'По анализу результатов',15,NULL)
,		  (2,'По управлению рисками',15,NULL)
     --(1,'Казначейство',197),
,	      (3,'По управлению ликвидностью',16,NULL)
,		  (3,'По расчетам и платежам',16,NULL)
,		  (3,'По монетарным операциям',16,NULL)
,		  (3,'По работе с банковскими учреждениями',16,NULL)
     --(1,'Отдел налогов',197),
,	      (4,'По налоговому учету',17,NULL)
,		  (4,'По налоговому планированию',17,NULL)
,		  (4,'По налоговым спорам',17,NULL)
,		  (4,'По подготовке налоговой отчётности',17,NULL)
 --(2,'Депортамен HR'292)														   	
     --(2,'Отдел подбора персонала',292),
,	      (5,'По привлечению кандидатов',17,NULL)
,		  (5,'По проведению собеседований',17,NULL)
,		  (5,'По оценке кандидатов',17,NULL)
,		  (5,'По работе с агентствами',17,NULL)
     --(2,'Отдел обучения и развития',292),
,	      (6,'По разработке учебных программ',18,NULL)
,		  (6,'По оценке эффективности обучения',18,NULL)
,		  (6,'По организационному развитию',18,NULL)
,		  (6,'По наставничеству и коучингу',18,NULL)
     --(2,'Отдел компенсаций и льгот',292),
,	      (7,'По зарплатным проверкам',19,NULL)
,		  (7,'По управлению бонусами',19,NULL)
,		  (7,'По социальным льготам',19,NULL)
,		  (7,'По пенсионным схемам',19,NULL)
 --(3,'Депортамент продаж'487)													  		,
     --(3,'Отдел управления продажами',487),
,	      (8,'По разработке стратегий продаж',20,NULL)
,		  (8,'Планирования и прогнозирования продаж',20,NULL)
,		  (8,'Анализа производительности',20,NULL)
,		  (8,'Управления ключевыми клиентами',20,NULL)
     --(3,'Отдел корпоративных продаж',487),
,	      (9,'По работе с крупными клиентами',21,NULL)
,		  (9,'По акционным предложениям',21,NULL)
,		  (9,'По тендерам и контрактам',21,NULL)
,		  (9,'По развитию партнёрских отношений',21,NULL)
     --(3,'Отдел розничных продаж',487),
,	      (10,'По управлению точками продаж',22,NULL)
,		  (10,'По обучению персонала',22,NULL)
,		  (10,'По мерчандайзингу',22,NULL)
,		  (10,'По клиентскому обслуживанию',22,NULL)
     --(3,'Отдел продаж в интернете',487),
,	      (11,'По оптимизации электронной коммерции',23,NULL)
,		  (11,'По управлению контентом',23,NULL)
,		  (11,'По анализу поведения пользователей на сайте',23,NULL)
,		  (11,'По рекламе и продвижению товаров онлайн',23,NULL)
 --(4,'Маркетинговый депортамент'506)													   	
     --(4,'Отдел исследований и аналитики',506),
,	      (12,'Потребительских исследований',24,NULL)
,		  (12,'Конкурентного анализа',24,NULL)
,		  (12,'Рыночного прогнозирования',24,NULL)
,		  (12,'Анализа данных',24,NULL)
     --(4,'Отдел стратегического маркетинга',506),
,	      (13,'Разработки маркетинговых стратегий',25,NULL)
,		  (13,'Управления брендом',25,NULL)
,		  (13,'Сегментации рынка',25,NULL)
,		  (13,'Планирования продуктов',25,NULL)
     --(4,'Отдел цифрового маркетинга',506),
,	      (14,'SMM (социальные медиа)',26,NULL)
,		  (14,'Контент-маркетинга',26,NULL)
,		  (14,'SEO (поисковая оптимизация)',26,NULL)
,		  (14,'Email-маркетинга',26,NULL)
     --(4,'Отдел рекламы и PR',506),
,	      (15,'Рекламных кампаний',27,NULL)
,		  (15,'PR и медиа-отношений',27,NULL)
,		  (15,'Управления событиями',27,NULL)
,		  (15,'Креативного дизайна',27,NULL)
 --(5,'Операционный депортамент'129)													   	
      --(5,'Отдел планирования операций',129),
,	      (16,'Группа стратегического планирования',28,NULL)
,		  (16,'Группа тактического планирования',28,NULL)
,		  (16,'Группа управления ресурсами',28,NULL)
,		  (16,'Группа анализа результативности',28,NULL)
     --(5,'Отдел управления проектами',129),
,	      (17,'Группа инициации проектов',29,NULL)
,		  (17,'Группа мониторинга и контроля',29,NULL)
,		  (17,'Группа оценки рисков',29,NULL)
,		  (17,'Группа закрытия проектов',29,NULL)
    --(5,'Отдел контроля качества',129),
,	      (18,'Группа внутреннего аудита',30,NULL)
,		  (18,'Группа обеспечения стандартов',30,NULL)
,		  (18,'Группа анализа несоответствий',30,NULL)
,		  (18,'Группа улучшения процессов',30,NULL)
     --(5,'Отдел информационных технологий',129),
,	      (19,'Группа разработки программного обеспечения',31,NULL)
,		  (19,'Группа технической поддержки',31,NULL)
,		  (19,'Группа управления базами данных',31,NULL)
,		  (19,'Группа внедрения новых технологий',31,NULL)
     --(5,'Отдел логистики и снабжения',129),
,	      (20,'Группа управления поставками',32,NULL)
,		  (20,'Группа складского учета',32,NULL)
,		  (20,'Группа доставки и распределения',32,NULL)
,		  (20,'Группа оптимизации запасов',32,NULL)
 --(6,'Депортамен IT (информационных технологий)'556)											   	
     -- (6,'Разработка программного обеспечения',556),
,	      (21,'Отдел фронтенд-разработки',33,NULL)
		     --(21,'Разработка пользовательского интерфейса (UI)
		     --(21,'Разработка пользовательского опыта (UX)
		     --(21,'Верстка и адаптивный дизайн
		     --(21,'Анимации и динамические элементы
,		  (21,'Отдел бэкенд-разработки',33,NULL)
		     --(21,'Разработка RESTful API
		     --(21,'Управление базами данных (DBA)
		     --(21,'Интеграция сторонних сервисов
		     --(21,'Работа с серверной архитектурой и микросервисами
,		  (21,'Отдел мобильной разработки',33,NULL)
		     --(21,'Разработка приложений для iOS
		     --(21,'Разработка приложений для Android
		     --(21,'Кроссплатформенная разработка
		     --(21,'Оптимизация производительности мобильных приложений
,		  (21,'Отдел тестирования и контроля качества',33,NULL)
		     --(21,'Функциональное тестирование
		     --(21,'Автоматизированное тестирование
		     --(21,'Нагрузочное тестирование
    -- (6,'Системное администрирование',556),
,	      (22,'Отдел технической поддержки',34,NULL)
		     --(22,'Обработка запросов от пользователей
		     --(22,'Поддержка программного обеспечения
		     --(22,'Мониторинги поддержка серверов и сетей
		     --(22,'Интеграция с сторонними сервисами
		     --(22,'Настройка автоматизации процессов
,		  (22,'Отдел управления сетями',34,NULL)
		     --(22,'Обработка запросов от пользователей
		     --(22,'Поддержка программного обеспечения
		     --(22,'Мониторинги поддержка серверов и сетей
		     --(22,'Интеграция с сторонними сервисами
		     --(22,'Настройка автоматизации процессов
,		  (22,'Отдел безопасности информационных систем',34,NULL)
		     --(22,'Управление рисками
		     --(22,'Защита данных
		     --(22,'Инцидент-менеджмент
     --(6,'Информационные технологии (IT)',556),
,	      (23,'Отдел разработки IT-стратегий',35,NULL)
		     --(23,'Анализ требований и исследований
		     --(23,'Разработка архитектуры IT-решений
		     --(23,'Управление инновациями
		     --(23,'Планирование и бюджетирование IT-проектов
,		  (23,'Отдел поддержки пользователей и оборудования',35,NULL)
		     --(23,'Поддержка рабочих станций и устройств
		     --(23,'Служба технической поддержки станций и устройств
		     --(23,'Управление инвентаризацией оборудования
		     --(23,'Обучение пользователей по продукту 
,		  (23,'Отдел управления проектами',35,NULL)
		     --(23,'Инициация и планирование проектов
		     --(23,'Контроль выполнения и качества
		     --(23,'Управление рисками и изменениями
     --(6,'Аналитика и бизнес-разведка',556),
,	      (24,'Отдел анализа данных',36,NULL)
		     -- (24,'Моделирование и прогнозирование
		  	  --(24,'Визуализация данных
		  	  --(24,'Анализ больших данных
,		  (24,'Отдел бизнес-анализа',36,NULL)
		     -- (24,'Сбор и анализ бизнес-требований
		  	  --(24,'Оптимизация бизнес-процессов
		  	  --(24,'Оценка экономической эффективности проектов
		  	  --(24,'Подготовка отчетности для руководства
,		  (24,'Отдел финансовой аналитики',36,NULL)
		     -- (24,'Анализ финансовых отчетов
		  	  --(24,'Бюджетирование и прогнозирование доходов
		  	  --(24,'Оценка инвестиционных проектов
     --(6,'Управление проектами',556),
,	      (25,'Отдел управления проектами',37,NULL)
		     -- (25,'Планирование и организация проектов.
		  	  --(25,'Контроль выполнения сроков и бюджета.
		  	  --(25,'Управление рисками и изменениями.
		  	  --(25,'Координация работы команды и коммуникация с заинтересованными сторонами.
,		  (25,'Отдел по работе с клиентами',37,NULL)
		     -- (25,'Обработка запросов и жалоб клиентов.
		  	  --(25,'Поддержка и консультирование клиентов.
		  	  --(25,'Сбор отзывов и улучшение сервиса.
		  	  --(25,'Установление долгосрочных отношений с клиентами.
,		  (25,'Отдел долгосрочного планирования',37,NULL)
		     -- (25,'Разработка стратегических планов компании.
		  	  --(25,'Анализ рыночных тенденций и условий.
		  	  --(25,'Оценка ресурсных потребностей на будущее.
		  	  --(25,'Подготовка сценариев и планов на случай непредвиденных обстоятельств.
     --(6,'Маркетинг и Продажи',556),
,	      (26,'Отдел цифрового маркетинга',38,NULL)
		   -- (26,'Разработка и реализация стратегий онлайн-продвижения.
		  	--(26,'Управление рекламными кампаниями в социальных сетях и поисковых системах.
		  	--(26,'Анализ результатов маркетинговых активностей и оптимизация кампаний.
		  	--(26,'Создание контента для веб-сайтов, блогов и социальных платформ.
,		  (26,'Отдел продаж продуктов',38,NULL)
		   -- (26,'Организация процессов продаж и взаимодействия с клиентами.
		  	--(26,'Поиск и привлечение новых клиентов.
		  	--(26,'Поддержка существующих клиентов и развитие долгосрочных отношений.
		  	--(26,'Проведение тренингов для команды продаж и мониторинг их эффективности.
,		  (26,'Отдел по работе с клиентами',38,NULL)
		   -- (26,'Обработка запросов и динамическое реагирование на потребности клиентов.
		  	--(26,'Обеспечение высокого уровня сервиса и удовлетворенности клиентов.
		  	--(26,'Сбор отзывов для дальнейшего улучшения продукта и сервиса.
		  	--(26,'Содействие в решении конфликтных ситуаций между компанией и клиентами.
    --(6,'Кибербезопасность',556),
,	    (27,'Отдел реагирования на инциденты',39,NULL)
		 --   (27,'Команда мониторинга событий безопасности (SIEM) 
			--(27,'Команда по анализу инцидентов                   
			--(27,'Команда восстановления после инцидентов         
			--(27,'Команда обучения и осведомленности              
,		(27,'Отдел анализа уязвимостей',39,NULL)
		 --   (27,'Команда сканирования уязвимостей
			--(27,'Команда оценки рисков           
			--(27,'Команда управления уязвимостями 
			--(27,'Команда мониторинга новых угроз
,		(27,'Отдел обеспечения безопасности данных',39,NULL)
		 --   (27,'Команда управления доступом             
			--(27,'Команда шифрования и защиты данных      
			--(27,'Команда соответствия стандартам и нормам
			--(27,'Команда по реагированию на утечки данных
     --(6,'Дизайн и пользовательский опыт (UX/UI)',556),
,	    (28,'Отдел графического дизайна',40,NULL)
		 --   (28,'Команда иллюстрации
			--(28,'Команда веб-дизайна
			--(28,'Команда типографики
			--(28,'Команда брендинга
,		(28,'Отдел UX-исследований',40,NULL)
		    --(28,'Команда пользовательских интервью
			--(28,'Команда юзабилити-тестирования
			--(28,'Команда анализа данных
			--(28,'Команда создания персонажей (персон)
,		(28,'Отдел прототипирования и вайрфрейминга',40,NULL)
		 --   (28,'Команда низкой четкости (low-fidelity) прототипов
			--(28,'Команда высокой четкости (high-fidelity) прототипов
			--(28,'Команда тестирования прототипов
--7,'Юридический Депортамент'395)													   	
     --(7,'Отдел корпоративного права',395),
,	        (29,'Секретариат совета директоров',42,NULL)  
,	        (29,'Контрактного управления',42,NULL)  
,	        (29,'Соблюдения корпоративного законодательства',42,NULL)
,	        (29,'Защиты интеллектуальной собственности',42,NULL) 
     --(7,'Отдел гражданского права',395),
,	        (30,'Споров о собственности',43,NULL)  
,			(30,'По делам о банкротстве',43,NULL)   
,			(30,'Договорных обязательств',43,NULL)  
,			(30,'Защиты прав потребителей',43,NULL) 
     --(7,'Отдел уголовного права',395),
,	        (31,'Расследования уголовных дел',44,NULL)   
,			(31,'Защиты обвиняемых',44,NULL)  
,			(31,'Судебного преследования',44,NULL)  
,			(31,'По правам жертв преступлений',44,NULL) 
     --(7,'Отдел административного права',395),
,	        (32,'Правовой поддержки государственных органов',45,NULL)  
,			(32,'Надзорных производств',45,NULL)   
,			(32,'По контролю за соблюдением норм законодательства',45,NULL)  
,			(32,'Обжалования административных решений',45,NULL)   
--8,'Депортамент службы безопастности'127)											   		
     --(8,'Отдел аналитики и прогнозирования',127),
,	        (33,'Прогнозирования угроз',46,NULL) 
,			(33,'Анализа рисков',46,NULL)
,			(33,'Работы с открытыми источниками',46,NULL)
,			(33,'Межведомственного взаимодействия',46,NULL)
     --(8,'Отдел оперативной поддержки',127),
,	        (34,'По координации действий с другими службами',47,NULL)
,			(34,'По работе с информаторами',47,NULL)
,			(34,'Сбора и анализа данных',47,NULL)
     --(8,'Отдел физической безопасности',127),
,	        (35,'Охраны объектов',48,NULL)
,			(35,'Контроля видеонаблюдения',48,NULL)
,			(35,'Проверки сотрудников',48,NULL)
,			(35,'Реагирования на угрозы',48,NULL)
     --(8,'Отдел аналитики и прогнозирования',127)
,	        (36,'Прогнозирования угроз',49,NULL)
,			(36,'Анализа рисков',49,NULL)
,			(36,'Работы с открытыми источниками',49,NULL)
,			(36,'Межведомственного взаимодействия',49,NULL)
--rollback
commit

go


begin tran
insert into The_Subgroup (ID_Group,Name_The_Subgroup,ID_Branch,ID_Parent_The_Subgroup)
values
--(1,'Финансовый депортамент'197)
     --(1,'Отдел бухгалтерского учёта',197),
	   --   (1,'По учёту основных средств',14,NULL)  
		  --(1,'По учёту расчетов с контрагентами',14,NULL)
		  --(1,'По учёту зарплаты и кадров',14,NULL)
		  --(1,'По подготовке финансовой отчётности',14,NULL)
     --(1,'Отдел финансового планирования и анализа',197),
	   --   (2,'По бюджетированию',15,NULL)
		  --(2,'По финансовому моделированию',15,NULL)
		  --(2,'По анализу результатов',15,NULL)
		  --(2,'По управлению рисками',15,NULL)
     --(1,'Казначейство',197),
	   --   (3,'По управлению ликвидностью',16,NULL)
		  --(3,'По расчетам и платежам',16,NULL)
		  --(3,'По монетарным операциям',16,NULL)
		  --(3,'По работе с банковскими учреждениями',16,NULL)
     --(1,'Отдел налогов',197),
	   --   (4,'По налоговому учету',17,NULL)
		  --(4,'По налоговому планированию',17,NULL)
		  --(4,'По налоговым спорам',17,NULL)
		  --(4,'По подготовке налоговой отчётности',17,NULL)
 --(2,'Депортамен HR'292)														   	
     --(2,'Отдел подбора персонала',292),
	   --   (5,'По привлечению кандидатов',17,NULL)
		  --(5,'По проведению собеседований',17,NULL)
		  --(5,'По оценке кандидатов',17,NULL)
		  --(5,'По работе с агентствами',17,NULL)
     --(2,'Отдел обучения и развития',292),
	   --   (6,'По разработке учебных программ',18,NULL)
		  --(6,'По оценке эффективности обучения',18,NULL)
		  --(6,'По организационному развитию',18,NULL)
		  --(6,'По наставничеству и коучингу',18,NULL)
     --(2,'Отдел компенсаций и льгот',292),
	   --   (7,'По зарплатным проверкам',19,NULL)
		  --(7,'По управлению бонусами',19,NULL)
		  --(7,'По социальным льготам',19,NULL)
		  --(7,'По пенсионным схемам',19,NULL)
 --(3,'Депортамент продаж'487)													  		,
     --(3,'Отдел управления продажами',487),
	   --   (8,'По разработке стратегий продаж',20,NULL)
		  --(8,'Планирования и прогнозирования продаж',20,NULL)
		  --(8,'Анализа производительности',20,NULL)
		  --(8,'Управления ключевыми клиентами',20,NULL)
     --(3,'Отдел корпоративных продаж',487),
	   --   (9,'По работе с крупными клиентами',21,NULL)
		  --(9,'По акционным предложениям',21,NULL)
		  --(9,'По тендерам и контрактам',21,NULL)
		  --(9,'По развитию партнёрских отношений',21,NULL)
     --(3,'Отдел розничных продаж',487),
	   --   (10,'По управлению точками продаж',22,NULL)
		  --(10,'По обучению персонала',22,NULL)
		  --(10,'По мерчандайзингу',22,NULL)
		  --(10,'По клиентскому обслуживанию',22,NULL)
     --(3,'Отдел продаж в интернете',487),
	   --   (11,'По оптимизации электронной коммерции',23,NULL)
		  --(11,'По управлению контентом',23,NULL)
		  --(11,'По анализу поведения пользователей на сайте',23,NULL)
		  --(11,'По рекламе и продвижению товаров онлайн',23,NULL)
 --(4,'Маркетинговый депортамент'506)													   	
     --(4,'Отдел исследований и аналитики',506),
	   --   (12,'Потребительских исследований',24,NULL)
		  --(12,'Конкурентного анализа',24,NULL)
		  --(12,'Рыночного прогнозирования',24,NULL)
		  --(12,'Анализа данных',24,NULL)
     --(4,'Отдел стратегического маркетинга',506),
	   --   (13,'Разработки маркетинговых стратегий',25,NULL)
		  --(13,'Управления брендом',25,NULL)
		  --(13,'Сегментации рынка',25,NULL)
		  --(13,'Планирования продуктов',25,NULL)
     --(4,'Отдел цифрового маркетинга',506),
	   --   (14,'SMM (социальные медиа)',26,NULL)
		  --(14,'Контент-маркетинга',26,NULL)
		  --(14,'SEO (поисковая оптимизация)',26,NULL)
		  --(14,'Email-маркетинга',26,NULL)
     --(4,'Отдел рекламы и PR',506),
	   --   (15,'Рекламных кампаний',27,NULL)
		  --(15,'PR и медиа-отношений',27,NULL)
		  --(15,'Управления событиями',27,NULL)
		  --(15,'Креативного дизайна',27,NULL)
 --(5,'Операционный депортамент'129)													   	
      --(5,'Отдел планирования операций',129),
	   --   (16,'Группа стратегического планирования',28,NULL)
		  --(16,'Группа тактического планирования',28,NULL)
		  --(16,'Группа управления ресурсами',28,NULL)
		  --(16,'Группа анализа результативности',28,NULL)
     --(5,'Отдел управления проектами',129),
	   --   (17,'Группа инициации проектов',29,NULL)
		  --(17,'Группа мониторинга и контроля',29,NULL)
		  --(17,'Группа оценки рисков',29,NULL)
		  --(17,'Группа закрытия проектов',29,NULL)
    --(5,'Отдел контроля качества',129),
	   --   (18,'Группа внутреннего аудита',30,NULL)
		  --(18,'Группа обеспечения стандартов',30,NULL)
		  --(18,'Группа анализа несоответствий',30,NULL)
		  --(18,'Группа улучшения процессов',30,NULL)
     --(5,'Отдел информационных технологий',129),
	   --   (19,'Группа разработки программного обеспечения',31,NULL)
		  --(19,'Группа технической поддержки',31,NULL)
		  --(19,'Группа управления базами данных',31,NULL)
		  --(19,'Группа внедрения новых технологий',31,NULL)
     --(5,'Отдел логистики и снабжения',129),
	   --   (20,'Группа управления поставками',32,NULL)
		  --(20,'Группа складского учета',32,NULL)
		  --(20,'Группа доставки и распределения',32,NULL)
		  --(20,'Группа оптимизации запасов',32,NULL)
 --(6,'Депортамен IT (информационных технологий)'556)											   	
     -- (6,'Разработка программного обеспечения',556),
	      --(21,'Отдел фронтенд-разработки',33,NULL)
		          (21,'Разработка пользовательского интерфейса (UI)',33,81)
,		          (21,'Разработка пользовательского опыта (UX)',33,81)
,		          (21,'Верстка и адаптивный дизайн',33,81)
,		          (21,'Анимации и динамические элементы',33,81)
		  --(21,'Отдел бэкенд-разработки',33,NULL)
,		          (21,'Разработка RESTful API',33,82)
,		          (21,'Управление базами данных (DBA)',33,82)
,		          (21,'Интеграция сторонних сервисов',33,82)
,		          (21,'Работа с серверной архитектурой и микросервисами',33,82)
		  --(21,'Отдел мобильной разработки',33,NULL)
,		          (21,'Разработка приложений для iOS',33,83)
,		          (21,'Разработка приложений для Android',33,83)
,		          (21,'Кроссплатформенная разработка',33,83)
,		          (21,'Оптимизация производительности мобильных приложений',33,83)
		  --(21,'Отдел тестирования и контроля качества',33,NULL)
,		          (21,'Функциональное тестирование',33,84)
,		          (21,'Автоматизированное тестирование',33,84)
,		          (21,'Нагрузочное тестирование',33,84)
    -- (6,'Системное администрирование',556),
	      --(22,'Отдел технической поддержки',34,NULL)
,		     (22,'Обработка запросов от пользователей',34,85)
,		     (22,'Поддержка программного обеспечения',34,85)
,		     (22,'Мониторинги поддержка серверов и сетей',34,85)
,		     (22,'Интеграция с сторонними сервисами',34,85)
,		     (22,'Настройка автоматизации процессов',34,85)
		  --(22,'Отдел управления сетями',34,NULL)
,		     (22,'Обработка запросов от пользователей',34,86)
,		     (22,'Поддержка программного обеспечения',34,86)
,		     (22,'Мониторинги поддержка серверов и сетей',34,86)
,		     (22,'Интеграция с сторонними сервисами',34,86)
,		     (22,'Настройка автоматизации процессов',34,86)
		  --(22,'Отдел безопасности информационных систем',34,NULL)
,		     (22,'Управление рисками',34,87)
,		     (22,'Защита данных',34,87)
,		     (22,'Инцидент-менеджмент',34,87)
     --(6,'Информационные технологии (IT)',556),
	      --(23,'Отдел разработки IT-стратегий',35,NULL)
,		     (23,'Анализ требований и исследований',35,88)
,		     (23,'Разработка архитектуры IT-решений',35,88)
,		     (23,'Управление инновациями',35,88)
,		     (23,'Планирование и бюджетирование IT-проектов',35,88)
		  --(23,'Отдел поддержки пользователей и оборудования',35,NULL)
,		     (23,'Поддержка рабочих станций и устройств',35,89)
,		     (23,'Служба технической поддержки станций и устройств',35,89)
,		     (23,'Управление инвентаризацией оборудования',35,89)
,		     (23,'Обучение пользователей по продукту',35,89) 
		  --(23,'Отдел управления проектами',35,NULL)
,		     (23,'Инициация и планирование проектов',35,90)
,		     (23,'Контроль выполнения и качества',35,90)
,		     (23,'Управление рисками и изменениями',35,90)
     --(6,'Аналитика и бизнес-разведка',556),
	      --(24,'Отдел анализа данных',36,NULL)
,		     (24,'Моделирование и прогнозирование',36,91)
,		  	 (24,'Визуализация данных',36,91)
,		  	 (24,'Анализ больших данных',36,91)
		  --(24,'Отдел бизнес-анализа',36,NULL)
,		     (24,'Сбор и анализ бизнес-требований',36,92)
,		  	 (24,'Оптимизация бизнес-процессов',36,92)
,		  	 (24,'Оценка экономической эффективности проектов',36,92)
,		  	 (24,'Подготовка отчетности для руководства',36,92)
		  --(24,'Отдел финансовой аналитики',36,NULL)
,		     (24,'Анализ финансовых отчетов',36,93)
,		  	 (24,'Бюджетирование и прогнозирование доходов',36,93)
,		  	 (24,'Оценка инвестиционных проектов',36,93)
     --(6,'Управление проектами',556),
	      --(25,'Отдел управления проектами',37,NULL)
,		     (25,'Планирование и организация проектов',37,94)
,		  	 (25,'Контроль выполнения сроков и бюджета',37,94)
,		  	 (25,'Управление рисками и изменениями',37,94)
,		  	 (25,'Координация работы команды и коммуникация с заинтересованными сторонами',37,94)
		  --(25,'Отдел по работе с клиентами',37,NULL)
,		     (25,'Обработка запросов и жалоб клиентов',37,95)
,		  	 (25,'Поддержка и консультирование клиентов',37,95)
,		  	 (25,'Сбор отзывов и улучшение сервиса',37,95)
,		  	 (25,'Установление долгосрочных отношений с клиентами',37,95)
		  --(25,'Отдел долгосрочного планирования',37,NULL)
,		     (25,'Разработка стратегических планов компании',37,96)
,		  	 (25,'Анализ рыночных тенденций и условий',37,96)
,		  	 (25,'Оценка ресурсных потребностей на будущее',37,96)
,		  	 (25,'Подготовка сценариев и планов на случай непредвиденных обстоятельств',37,96)
     --(6,'Маркетинг и Продажи',556),
	      --(26,'Отдел цифрового маркетинга',38,NULL)
,		      (26,'Разработка и реализация стратегий онлайн-продвижения',38,97)
,		  	  (26,'Управление рекламными кампаниями в социальных сетях и поисковых системах',38,97)
,		  	  (26,'Анализ результатов маркетинговых активностей и оптимизация кампаний',38,97)
,		  	  (26,'Создание контента для веб-сайтов, блогов и социальных платформ',38,97)
		  --(26,'Отдел продаж продуктов',38,NULL)
,		      (26,'Организация процессов продаж и взаимодействия с клиентами',38,98)
,		  	  (26,'Поиск и привлечение новых клиентов',38,98)
,		  	  (26,'Поддержка существующих клиентов и развитие долгосрочных отношений',38,98)
,		  	  (26,'Проведение тренингов для команды продаж и мониторинг их эффективности',38,98)
		  --(26,'Отдел по работе с клиентами',38,NULL)
,		       (26,'Обработка запросов и динамическое реагирование на потребности клиентов',38,99)
,		       (26,'Обеспечение высокого уровня сервиса и удовлетворенности клиентов',38,99)
,		       (26,'Сбор отзывов для дальнейшего улучшения продукта и сервиса',38,99)
,		       (26,'Содействие в решении конфликтных ситуаций между компанией и клиентами',38,99)
    --(6,'Кибербезопасность',556),
	    --(27,'Отдел реагирования на инциденты',39,NULL)
,		      (27,'Команда мониторинга событий безопасности (SIEM)',39,100) 
,			  (27,'Команда по анализу инцидентов',39,100)                    
,			  (27,'Команда восстановления после инцидентов',39,100)          
,			  (27,'Команда обучения и осведомленности',39,100)               
		--(27,'Отдел анализа уязвимостей',39,NULL)
,		      (27,'Команда сканирования уязвимостей',39,101) 
,			  (27,'Команда оценки рисков',39,101)            
,			  (27,'Команда управления уязвимостями',39,101)  
,			  (27,'Команда мониторинга новых угроз',39,101) 
		--(27,'Отдел обеспечения безопасности данных',39,NULL)
,		      (27,'Команда управления доступом',39,102)              
,			  (27,'Команда шифрования и защиты данных',39,102)      
,			  (27,'Команда соответствия стандартам и нормам',39,102)
,			  (27,'Команда по реагированию на утечки данных',39,102)
     --(6,'Дизайн и пользовательский опыт (UX/UI)',556),
	    --(28,'Отдел графического дизайна',40,NULL)
,		      (28,'Команда иллюстрации',40,103)
,		      (28,'Команда веб-дизайна',40,103)
,		      (28,'Команда типографики',40,103)
,		      (28,'Команда брендинга',40,103)
		--(28,'Отдел UX-исследований',40,NULL)
,		      (28,'Команда пользовательских интервью',40,104)
,			  (28,'Команда юзабилити-тестирования',40,104)
,			  (28,'Команда анализа данных',40,104)
,			  (28,'Команда создания персонажей (персон)',40,104)
		--(28,'Отдел прототипирования и вайрфрейминга',40,NULL)
,		      (28,'Команда низкой четкости (low-fidelity) прототипов',40,105)
,			  (28,'Команда высокой четкости (high-fidelity) прототипов',40,105)
,			  (28,'Команда тестирования прототипов',40,105)
   --7,'Юридический Депортамент'395)													   	
     --(7,'Отдел корпоративного права',395),
	        --(29,'Секретариат совета директоров',42,NULL)  
	        --(29,'Контрактного управления',42,NULL)  
	        --(29,'Соблюдения корпоративного законодательства',42,NULL)
	        --(29,'Защиты интеллектуальной собственности',42,NULL) 
     --(7,'Отдел гражданского права',395),
	        --(30,'Споров о собственности',43,NULL)  
			--(30,'По делам о банкротстве',43,NULL)   
			--(30,'Договорных обязательств',43,NULL)  
			--(30,'Защиты прав потребителей',43,NULL) 
     --(7,'Отдел уголовного права',395),
	        --(31,'Расследования уголовных дел',44,NULL)   
			--(31,'Защиты обвиняемых',44,NULL)  
			--(31,'Судебного преследования',44,NULL)  
			--(31,'По правам жертв преступлений',44,NULL) 
     --(7,'Отдел административного права',395),
	        --(32,'Правовой поддержки государственных органов',45,NULL)  
			--(32,'Надзорных производств',45,NULL)   
			--(32,'По контролю за соблюдением норм законодательства',45,NULL)  
			--(32,'Обжалования административных решений',45,NULL)   
  --8,'Депортамент службы безопастности'127)											   		
     --(8,'Отдел аналитики и прогнозирования',127),
	        --(33,'Прогнозирования угроз',46,NULL) 
			--(33,'Анализа рисков',46,NULL)
			--(33,'Работы с открытыми источниками',46,NULL)
			--(33,'Межведомственного взаимодействия',46,NULL)
     --(8,'Отдел оперативной поддержки',127),
	        --(34,'По координации действий с другими службами',47,NULL)
			--(34,'По работе с информаторами',47,NULL)
			--(34,'Сбора и анализа данных',47,NULL)
     --(8,'Отдел физической безопасности',127),
	        --(35,'Охраны объектов',48,NULL)
			--(35,'Контроля видеонаблюдения',48,NULL)
			--(35,'Проверки сотрудников',48,NULL)
			--(35,'Реагирования на угрозы',48,NULL)
     --(8,'Отдел аналитики и прогнозирования',127)
	        --(36,'Прогнозирования угроз',49,NULL)
			--(36,'Анализа рисков',49,NULL)
			--(36,'Работы с открытыми источниками',49,NULL)
			--(36,'Межведомственного взаимодействия',49,NULL)
--rollback
commit


begin tran
drop table if exists #t_3
Select ID_The_Subgroup,null as Department_Code, 0 flag into #t_3 from dbo.The_Subgroup
go
declare @i_3 int = 0;
declare @s_1 int;
declare @ROWCOUNT_1 int;

declare
 @ID_The_Subgroup     bigint  
,@Department_Code     int
,@flag                int
declare mycur_3 cursor local fast_forward read_only for

Select * from #t_3

open  mycur_3
fetch next from  mycur_3 into @ID_The_Subgroup,@Department_Code,@flag
 while @@FETCH_STATUS  = 0
    begin
        begin try

              set  @s_1= (case when (round(rand()*4,0)) =1 then round(rand()*9999999,0)
						       when (round(rand()*4,0)) =2 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =3 then round(rand()*9999999,0)
							   when (round(rand()*4,0)) =4 then round(rand()*9999999,0)
                           else  round(rand()*9999999,0)  end);
			  print ' Сформировали случайное число -->' + convert(nvarchar(10),@s_1)

			  if ( select top 1 1 
			       from dbo.#t_3  as Gr 
				   where 1 = 1 
				   and Gr.flag = 0 
				   and Gr.ID_The_Subgroup = @ID_The_Subgroup 
				   and Gr.Department_Code is  null)  = 1
			     begin
	                update  Gr
	                set Department_Code = @s_1 
	                from  dbo.#t_3  as Gr 
			        where  Gr.flag = 0 and  Gr.ID_The_Subgroup = @ID_The_Subgroup and Gr.Department_Code is  null					
					set @ROWCOUNT_1 = @@ROWCOUNT

			        print ' Случайное число внесено в Department_Сode в таблицу dbo.#t_3 --> ' + convert(nvarchar(10),@ID_The_Subgroup)
                 end
			  
			  if  @ROWCOUNT_1 > 0   
			     begin
			         update m 
			         set flag = 1 
			         from #t_3  as m where  ID_The_Subgroup = @ID_The_Subgroup and flag = 0 
					 print ' ID_Group ' +  convert(nvarchar(10),@ID_The_Subgroup) + ' flag с "0" изменён на "1" в таблице #t_3' 
			     end  
        end try
	    begin catch
	       if xact_state() in (1, -1) -- Функция XACT_STATE сообщает о состоянии пользовательской транзакции текущего выполняемого запроса.
		              /*
		              1 : запрос внутри блока транзакции активен и действителен (не выдал ошибку).
                      0 : запрос не выдаст ошибку (например, запрос select внутри транзакции без запросов update / insert).
                      -1: Запрос внутри транзакции выдал ошибку (при вводе блока catch) и выполнит полный откат
					  (если у нас есть 4 успешных запроса и 1 выдает ошибку ,все 5 запросов будут откатаны ).
		              */
              ROLLBACK TRAN
           SELECT 
             ERROR_NUMBER() AS ErrorNumber,
             ERROR_SEVERITY() AS ErrorSeverity,
             ERROR_STATE() as ErrorState,
             ERROR_PROCEDURE() as ErrorProcedure,
             ERROR_LINE() as ErrorLine,
             ERROR_MESSAGE() as ErrorMessage;
	    end catch
     fetch next from  mycur_3 into @ID_The_Subgroup,@Department_Code,@flag
   end
close mycur_3
deallocate mycur_3
--rollback
commit

begin tran
declare
 @ID_The_Subgroup_2            bigint  
,@Department_Code_2     int
,@flag_2                int;

 if exists (select flag from #t_3 where  not exists ( select flag from #t_3 where flag = 0))
	   begin
			   declare  mycur_4 cursor local fast_forward read_only for 
			   select ID_The_Subgroup,Department_Code,flag from  #t_3 
			   open  mycur_4
			     fetch next from  mycur_4 into @ID_The_Subgroup_2,@Department_Code_2,@flag_2
			       while @@FETCH_STATUS =  0 
				       begin
					       begin try
						         update Gr_2
								 set Department_Code = @Department_Code_2
								 from dbo.[The_Subgroup] as Gr_2
								 where @ID_The_Subgroup_2 = ID_The_Subgroup and @flag_2 = 1
								 print ' По -->  ID_Group ' +  convert(nvarchar(10),@ID_The_Subgroup_2) + ' Внесены изменения в таблице Group из таблицы #t_3' 
						   end try
						   begin catch
						          if xact_state() in (1, -1)   
								      ROLLBACK TRAN
                                  SELECT 
								    ERROR_NUMBER() AS ErrorNumber,
								    ERROR_SEVERITY() AS ErrorSeverity,
								    ERROR_STATE() as ErrorState,
								    ERROR_PROCEDURE() as ErrorProcedure,
								    ERROR_LINE() as ErrorLine,
								    ERROR_MESSAGE() as ErrorMessage;
						   end catch
                       fetch next from  mycur_4 into @ID_The_Subgroup_2,@Department_Code_2,@flag_2
					   end
               close mycur_4
              deallocate mycur_4
            end
commit
--rollback
