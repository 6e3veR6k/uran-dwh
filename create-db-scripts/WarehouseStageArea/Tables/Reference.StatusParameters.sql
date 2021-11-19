CREATE TABLE [Reference].[StatusParameters] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](50) NOT NULL,
  [ValueTypeGID] [uniqueidentifier] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_StatusParameters_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO