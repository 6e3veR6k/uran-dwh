CREATE TABLE [Reference].[MetisDocumentTypes] (
  [GID] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](100) NOT NULL,
  [ValidationExpression] [nvarchar](255) NULL,
  [InputMessage] [nvarchar](50) NULL,
  [Form] [nvarchar](50) NULL,
  [INRegisteredDate] [bit] NULL,
  [INStartDate] [bit] NULL,
  [INEndDate] [bit] NULL,
  [IsIdentityDocument] [bit] NOT NULL,
  [IsAgentDocument] [bit] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_MetisDocumentTypes_GID] PRIMARY KEY CLUSTERED ([GID]) ON [DATA]
)
ON [DATA]
GO