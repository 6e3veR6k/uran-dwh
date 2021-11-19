CREATE TABLE [Reference].[ActTypes] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](50) NULL,
  [IsVisible] [bit] NULL,
  [IsAgentInfoUsed] [bit] NULL,
  [TemplateName] [nvarchar](50) NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ActTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO