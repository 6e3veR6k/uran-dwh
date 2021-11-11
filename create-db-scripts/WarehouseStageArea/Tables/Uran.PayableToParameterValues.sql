CREATE TABLE [Uran].[PayableToParameterValues] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [PayableGID] [uniqueidentifier] NOT NULL,
  [ParameterValue] [sql_variant] NOT NULL,
  [ParameterGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PayableToParameterValues_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO