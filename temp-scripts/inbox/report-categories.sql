update [Titania].[meta].[ReportCategories]
set Name = '9 - ІТ'
where Name = 'ІТ'

update [Titania].[meta].[ReportCategories]
set Name = '1 - Акти на бухгалтерію'
where Name = 'Акти на бухгалтерію'

update [Titania].[meta].[ReportCategories]
set Name = '2 - Виплати'
where Name = 'Виплати'

update [Titania].[meta].[ReportCategories]
set Name = '3 - ЦКП'
where Name = 'ЦКП'

update [Titania].[meta].[ReportCategories]
set Name = '4 - ДВЗ'
where Name = 'ДВЗ'

update [Titania].[meta].[ReportCategories]
set Name = '5 - ЕРУ'
where Name = 'Екпертно-розрахункове управління'

INSERT INTO [Titania].[meta].[ReportCategories] (gid, Name)
VALUES (newid(), '6 - Операційний департамент'), (newid(), '8 - Страхування (перестрахування)')

update [Titania].[meta].[ReportCategories]
set Name = '7 - ФЕД'
where Name = 'Фінансово-економічний департамент'

update [Titania].[meta].[ReportCategories]
set Name = '0 - Резерви'
where Name = '10 - Резерви'




/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [id]
      ,[gid]
      ,[Name]
  FROM [Titania].[meta].[ReportCategories]