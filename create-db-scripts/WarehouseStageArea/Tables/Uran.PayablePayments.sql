CREATE TABLE [Uran].[PayablePayments] (
  [id] [bigint] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [PayableGID] [uniqueidentifier] NOT NULL,
  [PayableDetailGID] [uniqueidentifier] NULL,
  [Amount] [decimal](18, 2) NULL,
  [CompensationAmount] [decimal](18, 2) NULL,
  [CompensationDate] [datetime] NULL,
  [PaymentNumber] [nvarchar](255) NULL,
  [OrderNumber] [nvarchar](255) NULL,
  [RefusalReason] [nvarchar](2000) NULL,
  [ReportDate] [datetime] NULL,
  [PaymentID] [nvarchar](255) NULL,
  [CreateDate] [datetime] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [PaymentPeriodGID] [uniqueidentifier] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_PayablePayments_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO