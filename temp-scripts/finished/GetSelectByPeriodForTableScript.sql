DECLARE @Script as nvarchar(max) = ''
DECLARE @TableName as nvarchar(max) = 'Cases'
DECLARE @SchemaName as nvarchar(max) = 'dbo'

SELECT @Script = [Script1Part1] + '
' + Script1Part2  + TableSchema + '.' + [TableName] + Script1Part3 + [LogTableSchema] + '.' + [TableName] + [Script1Part4]
FROM [Oberon].[tmp].[IntegrationServicesInfo]
WHERE [TableName] = @TableName
print @Script	

SELECT 'src.' + COLUMN_NAME + ',
'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName AND TABLE_SCHEMA = @SchemaName
ORDER BY ORDINAL_POSITION


SELECT * 
FROM (
SELECT 'MainData.' + COLUMN_NAME + ',
' AS ColumnName
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName AND TABLE_SCHEMA = @SchemaName
) AS Main
UNION ALL
SELECT 	'MainData.LogCreateDate,' AS ColumnName
UNION ALL
SELECT 	'MainData.LogActionDate,' AS ColumnName
UNION ALL
SELECT 	'MainData.SourceIdentity,' AS ColumnName
UNION ALL
SELECT 	'MainData.LoadDatetime' AS ColumnName


