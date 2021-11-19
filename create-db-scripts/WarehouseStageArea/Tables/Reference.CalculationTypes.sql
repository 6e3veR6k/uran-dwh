CREATE TABLE [Reference].[CalculationTypes] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](255) NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_CalculationTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO