CREATE TABLE [Reference].[DocumentParameterValues] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [DocumentParameterGID] [uniqueidentifier] NULL,
  [Value] [sql_variant] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_DocumentParameterValues_Id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO