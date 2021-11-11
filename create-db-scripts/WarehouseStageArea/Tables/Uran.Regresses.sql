CREATE TABLE [Uran].[Regresses] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [IncomingNumber] [nvarchar](255) NULL,
  [IncomingDate] [datetime] NULL,
  [OutgoingNumber] [nvarchar](255) NULL,
  [OutgoingDate] [datetime] NULL,
  [Amount] [decimal](18, 2) NULL,
  [IsProperty] [bit] NOT NULL,
  [InsuranceCompanyGID] [uniqueidentifier] NULL,
  [AuthorGID] [uniqueidentifier] NOT NULL,
  [Deleted] [bit] NOT NULL,
  [PayableGID] [uniqueidentifier] NULL,
  [DamagedProperty] [nvarchar](255) NULL,
  [Notes] [nvarchar](255) NULL,
  [BranchGID] [uniqueidentifier] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Regresses_Id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO