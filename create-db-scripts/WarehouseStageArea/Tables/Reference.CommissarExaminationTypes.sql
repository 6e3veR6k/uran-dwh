CREATE TABLE [Reference].[CommissarExaminationTypes] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [Name] [nvarchar](255) NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_CommissarExaminationTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO