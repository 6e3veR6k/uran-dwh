CREATE TABLE [Reference].[DocumentParameterValues] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [DocumentParameterGID] [uniqueidentifier] NULL,
  [Value] [nvarchar](4000) NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_DocumentParameterValues_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO