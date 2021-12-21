CREATE TABLE [Reference].[ProgramTypes] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](180) NOT NULL,
  [Description] [nvarchar](200) NULL,
  [InsuranceTypeGID] [uniqueidentifier] NOT NULL,
  [CoefficientCount] [int] NOT NULL,
  [IsOld] [bit] NOT NULL,
  [InitDate] [date] NOT NULL,
  [IssueDate] [date] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProgramTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO