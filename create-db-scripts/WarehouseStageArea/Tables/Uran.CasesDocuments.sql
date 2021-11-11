CREATE TABLE [Uran].[CasesDocuments] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [CaseGID] [uniqueidentifier] NOT NULL,
  [DocumentGID] [uniqueidentifier] NOT NULL,
  [AddDate] [datetime] NOT NULL,
  [AddUserGID] [uniqueidentifier] NOT NULL,
  [ProcessingStatusGID] [uniqueidentifier] NULL,
  [StatusGID] [uniqueidentifier] NOT NULL,
  [IsAccepted] [bit] NOT NULL,
  [ParentGID] [uniqueidentifier] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [Deleted] [bit] NOT NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_CasesDocuments_Id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO