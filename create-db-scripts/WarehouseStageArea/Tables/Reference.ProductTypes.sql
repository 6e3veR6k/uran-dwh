CREATE TABLE [Reference].[ProductTypes] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Code] [nvarchar](50) NULL,
  [Name] [nvarchar](255) NOT NULL,
  [Description] [nvarchar](200) NULL,
  [IsOld] [bit] NOT NULL,
  [InitDate] [date] NOT NULL,
  [IssueDate] [date] NOT NULL,
  [TemplateName] [nvarchar](50) NULL,
  [ProductTypeGroupGID] [uniqueidentifier] NULL,
  [IsAvailableForPartners] [bit] NOT NULL,
  [IsProlongationAllowed] [bit] NOT NULL,
  [ProductTypeScopeGID] [uniqueidentifier] NULL,
  [IsAvailableForOffice] [bit] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ProductTypes_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO