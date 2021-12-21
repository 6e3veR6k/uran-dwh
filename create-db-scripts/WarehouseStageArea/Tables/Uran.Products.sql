CREATE TABLE [Uran].[Products] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [ProductTypeGID] [uniqueidentifier] NULL,
  [PolisNumber] [nvarchar](50) NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [IsFromBlackWater] [bit] NOT NULL,
  [BeginingDate] [datetime] NULL,
  [EndingDate] [datetime] NULL,
  [RegisteredDate] [date] NULL,
  [IsReinsured] [bit] NULL,
  [ReinsurancePolisNumber] [nvarchar](50) NULL,
  [BranchGID] [uniqueidentifier] NULL,
  [ExternalGID] [uniqueidentifier] NULL,
  [InsuredGID] [uniqueidentifier] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Products_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO