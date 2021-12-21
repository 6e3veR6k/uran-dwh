CREATE TABLE [Reference].[BlankTypes] (
  [GID] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](50) NOT NULL,
  [Code] [nvarchar](50) NOT NULL,
  [LetterCount] [int] NOT NULL,
  [NumberCount] [int] NOT NULL,
  [Form] [nvarchar](50) NULL,
  [ContractBlank] [bit] NOT NULL,
  [PolisBlank] [bit] NOT NULL,
  [DefaultSeriesGID] [uniqueidentifier] NULL,
  [IsAutogeneration] [bit] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_BlankTypes_Id] PRIMARY KEY CLUSTERED ([GID]) ON [DATA]
)
ON [DATA]
GO