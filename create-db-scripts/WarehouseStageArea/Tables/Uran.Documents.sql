CREATE TABLE [Uran].[Documents] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [Name] [nvarchar](255) NOT NULL,
  [Serial] [nvarchar](50) NULL,
  [Number] [nvarchar](255) NOT NULL,
  [StartDate] [datetime] NULL,
  [EndDate] [datetime] NULL,
  [IssuedDate] [date] NULL,
  [IssuedBy] [nvarchar](200) NULL,
  [ObjectGID] [uniqueidentifier] NULL,
  [TypeGID] [uniqueidentifier] NULL,
  [Type] [nvarchar](255) NULL,
  [IsLockedOut] [bit] NOT NULL,
  [AddDate] [datetime] NOT NULL,
  [AddUserGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [AutoGeneratNumbere] [bigint] NULL,
  [WorkflowGID] [uniqueidentifier] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Documents_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO