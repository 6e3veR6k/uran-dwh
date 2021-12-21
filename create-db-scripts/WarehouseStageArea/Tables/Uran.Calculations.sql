﻿CREATE TABLE [Uran].[Calculations] (
  [id] [int] NOT NULL,
  [gid] [uniqueidentifier] NOT NULL,
  [RecipientGID] [uniqueidentifier] NULL,
  [PrintDate] [datetime] NULL,
  [PrintUserGID] [uniqueidentifier] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [CommissarExaminationGID] [uniqueidentifier] NULL,
  [CostWork] [decimal] NULL,
  [Materials] [decimal](18, 2) NULL,
  [CostRepair] [decimal](18, 2) NULL,
  [DamageWear] [decimal](18, 2) NULL,
  [ObjectName] [nvarchar](255) NULL,
  [Parts] [decimal](18, 2) NULL,
  [DocumentStatus] [nvarchar](255) NULL,
  [OrganizationExpert] [nvarchar](255) NULL,
  [DamageAmount] [decimal](18, 2) NULL,
  [AgreementType] [nvarchar](255) NULL,
  [AgreementAmount] [decimal](18, 2) NULL,
  [CalculationTypeGID] [uniqueidentifier] NOT NULL,
  [ServiceStationGID] [uniqueidentifier] NULL,
  [ExpertAppraiserGID] [uniqueidentifier] NULL,
  [BranchGID] [uniqueidentifier] NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Calculations_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO