CREATE TABLE [Reference].[ProgramTypeToClaimTypes] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [ClaimTypeGID] [uniqueidentifier] NOT NULL,
  [ProgramTypeGID] [uniqueidentifier] NOT NULL,
  [ProductTypeGID] [uniqueidentifier] NOT NULL,
  [Reserve] [decimal](18, 2) NULL,
  [RegulationCost] [decimal](18, 2) NULL,
  [RetentionLimit] [decimal](18, 2) NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProgramTypeToClaimTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO