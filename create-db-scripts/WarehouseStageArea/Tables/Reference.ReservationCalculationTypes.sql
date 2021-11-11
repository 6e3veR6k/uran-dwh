CREATE TABLE [Reference].[ReservationCalculationTypes] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [Name] [nvarchar](100) NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_ReservationCalculationTypes_Id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO