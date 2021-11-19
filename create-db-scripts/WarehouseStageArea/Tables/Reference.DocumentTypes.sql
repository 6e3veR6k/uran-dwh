CREATE TABLE [Reference].[DocumentTypes] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](255) NOT NULL,
  [TemplateName] [nvarchar](50) NULL,
  [ValidationExpression] [nvarchar](255) NULL,
  [InputMessage] [nvarchar](50) NULL,
  [Note] [nvarchar](255) NULL,
  [CanBeAttachedToCase] [bit] NOT NULL,
  [CanBePrinted] [bit] NOT NULL,
  [IsRegulationCost] [bit] NOT NULL,
  [CalculationTypeGID] [uniqueidentifier] NULL,
  [PayableTypeGID] [uniqueidentifier] NULL,
  [IsRegress] [bit] NOT NULL,
  [IsReinsurance] [bit] NOT NULL,
  [IsLetter] [bit] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_DocumentTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO