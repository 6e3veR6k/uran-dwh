﻿CREATE TABLE [Uran].[Vehicles] (
  [gid] [uniqueidentifier] NOT NULL,
  [RegistrationNumber] [nvarchar](50) NULL,
  [id] [bigint] NOT NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [ModelGID] [uniqueidentifier] NOT NULL,
  [ManufacturerGID] [uniqueidentifier] NOT NULL,
  [ColorGID] [uniqueidentifier] NULL,
  [ColorTypeGID] [uniqueidentifier] NULL,
  [OwnerGID] [uniqueidentifier] NULL,
  [BodyNumber] [nvarchar](50) NULL,
  [ProducedDate] [int] NULL,
  [RegistrationCertificate] [nvarchar](20) NULL,
  [RegistrationDate] [datetime] NULL,
  [Cost] [decimal](18, 2) NULL,
  [NumberOfSeats] [int] NULL,
  [AnticreepDevice] [nvarchar](250) NULL,
  [AdditionalEquipment] [nvarchar](250) NULL,
  [AuthorizedToManage] [nvarchar](250) NULL,
  [SpecialConditions] [nvarchar](250) NULL,
  [RegistrationPlace] [nvarchar](100) NULL,
  [Mileage] [decimal](18, 2) NULL,
  [Capacity] [decimal](18, 2) NULL,
  [TechDocModel] [nvarchar](250) NULL,
  [SettlementGID] [uniqueidentifier] NULL,
  [BodyTypeGID] [uniqueidentifier] NULL,
  [EngineTypeGID] [uniqueidentifier] NULL,
  [TransmissionTypeGID] [uniqueidentifier] NULL,
  [TypeGID] [uniqueidentifier] NULL,
  [EngineNumber] [nvarchar](50) NULL,
  [ChasisNumber] [nvarchar](50) NULL,
  [PostAddressGID] [uniqueidentifier] NULL,
  [Address] [nvarchar](255) NULL,
  [LogCreateDateTime] [datetime2] NOT NULL,
  [LogActionDateTime] [datetime2] NOT NULL,
  [RecordSource] [nvarchar](10) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Vehicles_Id] PRIMARY KEY CLUSTERED ([id]) ON [DATA]
)
ON [DATA]
GO