
insert into Oberon.tmp.IntegrationServicesInfo(TableSchema, TableName)
values(N'dbo', 'CommissarExaminations'), (N'dbo', 'PayableDetails')

insert into Oberon.tmp.IntegrationServicesInfo(TableSchema, TableName)
values(N'dbo', 'PayablePayments')

SELECT TOP (1000) [Id]
      ,[TableSchema]
      ,[TableName]
      ,[Script1Part1]
      ,[Script1Part2]
      ,[Script1Part3]
      ,[Script1Part4]
      ,[LogTableSchema]
FROM [Oberon].[tmp].[IntegrationServicesInfo]


--==============================================================================--
GO
SELECT
	'Set_' + TableName + 'Variables',
	'LoadStage' + TableName,
	'Upd_' + TableName + '_L_ExDt',
	'Uran' + TableName + 'ByPeriod',
	'L_ExDt_' + TableName,
	'C_ExDt_' + TableName,
	'WarehouseStage',
	TableName
FROM [Oberon].[tmp].[IntegrationServicesInfo]
where TableSchema = 'dbo'
and Id > 17


