CREATE TABLE [Uran].[EventToParameterValues] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [EventGID] [uniqueidentifier] NOT NULL,
  [ParameterValue] [sql_variant] NOT NULL,
  [ParameterGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_EventToParameterValues_Id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO