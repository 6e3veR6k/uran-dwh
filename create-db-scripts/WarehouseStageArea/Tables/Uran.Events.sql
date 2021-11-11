CREATE TABLE [Uran].[Events] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [Date] [datetime] NULL,
  [CountryGID] [uniqueidentifier] NOT NULL,
  [PostAddressGID] [uniqueidentifier] NULL,
  [Address] [nvarchar](255) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [Comment] [nvarchar](255) NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Events_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO