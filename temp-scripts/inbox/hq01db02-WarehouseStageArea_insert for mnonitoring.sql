update T
SET T.LastSuccessfulExtractionDatetime = '2010-01-01 00:00:00.0000000',
	T.[CurrentExtractionDateTime] = '2010-01-01 00:00:00.0000000'
FROM Integration.PackageExecutions AS T


select * 
from Integration.PackageExecutions AS T
where T.TableName not like '%Reference%'

create table #temp (
	TableName nvarchar(500) not null,
	UserName nvarchar(50) default 'oranta\bezvershuk_do'
	)

insert into #temp (TableName)
values(N'Uran.CommissarExaminations'), (N'Uran.PayableDetails'), (N'Uran.InsuranceObjects')



select 'exec Integration.sp_InsertTableForMonitoring @tableName = ''' + TableName
from #temp

exec Integration.sp_InsertTableForMonitoring @tableName = 'Uran.CommissarExaminations'
exec Integration.sp_InsertTableForMonitoring @tableName = 'Uran.PayableDetails'
exec Integration.sp_InsertTableForMonitoring @tableName = 'Uran.PayablePayments'


