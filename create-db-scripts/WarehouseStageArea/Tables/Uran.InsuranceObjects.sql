CREATE TABLE [Uran].[InsuranceObjects] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [ObjectCategory] [nvarchar](50) NULL,
  [InsuranceObjectTypeGID] [uniqueidentifier] NULL,
  [Comment] [nvarchar](255) NULL,
  [ObjectTypeGID] [uniqueidentifier] NULL,
  [Deleted] [bit] NOT NULL,
  [InsuranceSum] [decimal](18, 2) NULL,
  [InsurancePayment] [decimal](18, 2) NULL,
  [InsuranceRate] [decimal](18, 10) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [ObjectGID] [uniqueidentifier] NULL,
  [Name] [nvarchar](900) NULL,
  [CalculatedInsuranceRate] [decimal](18, 10) NULL,
  [CalculatedPayment] [decimal](18, 2) NULL,
  [ParentInsuranceObjectGID] [uniqueidentifier] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_InsuranceObjects_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO