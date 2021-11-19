CREATE TABLE [Reference].[VehicleManufacturers] (
  [GID] [uniqueidentifier] NOT NULL ROWGUIDCOL,
  [Name] [nvarchar](100) NOT NULL,
  [Code] [nvarchar](50) NOT NULL,
  [RegulatorID] [nvarchar](50) NULL,
  [RecordSource] [nvarchar](128) NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_VehicleManufacturers_GID] PRIMARY KEY CLUSTERED ([GID]) ON [DATA]
)
ON [DATA]
GO