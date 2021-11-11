SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

-- =============================================
-- Author:		oranta\bezvershuk_do
-- Create date: 01.11.2021
-- Description:	Uses for creating hub tables
-- =============================================
CREATE PROCEDURE [Integration].[sp_CreateHubByTableName] 
	-- Add the parameters for the stored procedure here
	@tableName nvarchar(500),
	@entryName nvarchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Query nvarchar(4000) = 'CREATE TABLE [Hub].[' + 
	@TableName +
	']([Hub' + 
	@EntryName + 'Id] [bigint] NOT NULL, [' + 
	@EntryName + 'Gid] [uniqueidentifier] NOT NULL, [SourceRecordId] [int] NOT NULL, [LoadDateTime] [datetime2](7) NOT NULL, CONSTRAINT [PK_' + 
	@TableName + '_Hub' + 
	@EntryName + 'Id] PRIMARY KEY CLUSTERED ([Hub' + 
	@EntryName + 'Id] DESC), CONSTRAINT [KEY_' + 
	@TableName + '_' + 
	@EntryName + 'Gid] UNIQUE NONCLUSTERED ([' +
	@EntryName + 'Gid] DESC))'

	EXECUTE sys.sp_executesql @query; 
END
GO