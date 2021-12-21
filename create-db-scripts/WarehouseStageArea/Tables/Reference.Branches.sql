SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Reference].[Branches] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [hid] [hierarchyid] NULL,
  [Name] [nvarchar](255) NOT NULL,
  [BranchCode] [nvarchar](50) NULL,
  [ParentGID] [uniqueidentifier] NULL,
  [ControlBlanks] [bit] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [BranchCodeLen] AS (len([BranchCode])) PERSISTED,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Branches_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO