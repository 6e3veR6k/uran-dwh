CREATE TABLE [Reference].[InsuranceTypes] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](250) NOT NULL,
  [Code] [nvarchar](10) NOT NULL,
  [InsuranceScopeGID] [uniqueidentifier] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_InsuranceTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO