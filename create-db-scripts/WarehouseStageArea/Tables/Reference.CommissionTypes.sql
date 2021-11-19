CREATE TABLE [Reference].[CommissionTypes] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Caption] [nvarchar](50) NOT NULL,
  [Code] [nvarchar](50) NOT NULL,
  [IsNullable] [bit] NOT NULL,
  [IsRequired] [bit] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_CommissionTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO