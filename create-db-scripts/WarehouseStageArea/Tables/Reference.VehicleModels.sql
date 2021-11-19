CREATE TABLE [Reference].[VehicleModels] (
  [GID] [uniqueidentifier] NOT NULL,
  [Name] [nvarchar](150) NOT NULL,
  [Code] [nvarchar](50) NOT NULL,
  [ManufacturerGID] [uniqueidentifier] NOT NULL,
  [VehicleTypeGID] [uniqueidentifier] NULL,
  [RegulatorID] [nvarchar](50) NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_VehicleModels_GID] PRIMARY KEY CLUSTERED ([GID]) ON [DATA]
)
ON [DATA]
GO