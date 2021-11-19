

-- DECLARE @tableName NVARCHAR(250) = N'Uran.Products' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.Events' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.Reservations' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.ClaimToParameterValues' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.Faces' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.InsuranceObjects' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.EventToParameterValues' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.Payables' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.CommissarExaminations' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.PayableDetails' EXEC [Integration].[sp_GetExtractionPeriod] @tableName
-- DECLARE @tableName NVARCHAR(250) = N'Uran.PayablePayments' EXEC [Integration].[sp_GetExtractionPeriod] @tableName


-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.Products'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.Events'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.Reservations'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.ClaimToParameterValues'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.Faces'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.InsuranceObjects'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.EventToParameterValues'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.CommissarExaminations'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.PayableDetails'
-- UPDATE Integration.PackageExecutions SET LastSuccessfulExtractionDatetime = CurrentExtractionDateTime, Message = 'success' WHERE TableName = 'Uran.PayablePayments'

--   LastSuccessfulExtractionDatetime
--   CurrentExtractionDateTime



-- RecordSource
-- LoadDateTime
-- @@SERVERNAME AS SourceIdentity,
-- CURRENT_TIMESTAMP AS LoadDatetime


