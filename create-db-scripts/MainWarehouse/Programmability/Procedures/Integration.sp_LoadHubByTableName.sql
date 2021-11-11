SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


-- =============================================
-- Author:		oranta\bezvershuk_do
-- Create date: 01.11.2021
-- Description:	Uses for loading hub tables
-- =============================================
CREATE PROCEDURE [Integration].[sp_LoadHubByTableName] 
	-- Add the parameters for the stored procedure here
	@tableName nvarchar(500),
	@entryName nvarchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Query nvarchar(4000) = 'INSERT INTO Hub.' + 
	@TableName +
	'(Hub' + 
	@EntryName + 'Id,' + 
	@EntryName + 'GID, SourceRecordId, LoadDateTime) SELECT src.id, src.gid, src.SourceRecordId, src.LoadDateTime FROM Stage.' + 
	@TableName + ' AS src WHERE NOT EXISTS (SELECT 1 FROM Hub.' + 
	@TableName + ' AS trg WHERE trg.Hub' + 
	@EntryName + 'Id = src.id AND trg.' + 
	@EntryName + 'GID = src.gid)'

	EXECUTE sys.sp_executesql @query; 
END
GO