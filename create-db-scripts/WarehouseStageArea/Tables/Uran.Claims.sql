CREATE TABLE [Uran].[Claims] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [ClaimerGID] [uniqueidentifier] NULL,
  [TypeGID] [uniqueidentifier] NOT NULL,
  [DateWriting] [datetime] NULL,
  [Notes] [nvarchar](255) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [RiskGID] [uniqueidentifier] NULL,
  [InsurerGID] [uniqueidentifier] NULL,
  [InsuranceObjectGID] [uniqueidentifier] NULL,
  [RecipientGID] [uniqueidentifier] NULL,
  [ProgramTypeGID] [uniqueidentifier] NOT NULL,
  [OwnerPostAddressGID] [uniqueidentifier] NULL,
  [IsVipClient] [bit] NOT NULL,
  [InsuranceSum] [decimal](18, 2) NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Claims_Id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO