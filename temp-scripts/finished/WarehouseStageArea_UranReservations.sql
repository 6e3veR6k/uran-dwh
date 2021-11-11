USE WarehouseStageArea
GO

IF DB_NAME() <> N'WarehouseStageArea' SET NOEXEC ON

--
-- Create schemas for working tables
--
GO
CREATE SCHEMA Uran
GO
CREATE SCHEMA Jupiter
GO
CREATE SCHEMA Integration
GO
CREATE SCHEMA Reference
GO

/* ================================================================================================================================================================================= */
/* Create integration area */
/* ================================================================================================================================================================================= */

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Integration].[PackageExecutions]') AND type in (N'U'))
BEGIN
  ALTER TABLE [Integration].[PackageExecutions] SET ( SYSTEM_VERSIONING = OFF  )
  DROP TABLE [Integration].[PackageExecutions]
END
GO

/****** Object:  Table [Integration].[PackageExecutionsHistory]    Script Date: 11.11.2021 13:52:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Integration].[PackageExecutionsHistory]') AND type in (N'U'))
DROP TABLE [Integration].[PackageExecutionsHistory]
GO

/****** Object:  Table [Integration].[PackageExecutionsHistory]    Script Date: 11.11.2021 13:52:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Integration].[PackageExecutionsHistory](
	[PackageExecutionId] [int] NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[LastSuccessfulExtractionDatetime] [datetime2](7) NOT NULL,
	[CurrentExtractionDateTime] [datetime2](7) NOT NULL,
	[TableName] [nvarchar](255) NOT NULL,
	[Message] [nvarchar](255) NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [Integration].[PackageExecutions]    Script Date: 11.11.2021 13:52:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Integration].[PackageExecutions](
	[PackageExecutionId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[LastSuccessfulExtractionDatetime] [datetime2](7) NOT NULL,
	[CurrentExtractionDateTime] [datetime2](7) NOT NULL,
	[TableName] [nvarchar](255) NOT NULL,
	[Message] [nvarchar](255) NOT NULL,
	[ValidFrom] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[ValidTo] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_PackageExecutions_PackageExecutionId] PRIMARY KEY CLUSTERED 
(
	[PackageExecutionId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [Integration].[PackageExecutionsHistory] )
)
GO


/****** Object:  StoredProcedure [Integration].[sp_ClearStageTables]    Script Date: 11.11.2021 13:54:15 ******/
DROP PROCEDURE IF EXISTS [Integration].[sp_ClearStageTables]
GO

/****** Object:  StoredProcedure [Integration].[sp_ClearStageTables]    Script Date: 11.11.2021 13:54:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Integration].[sp_ClearStageTables]
AS
  BEGIN

    DECLARE @sqlCommand NVARCHAR(4000) = (SELECT 'TRUNCATE TABLE ' + P.TableName + ';' AS 'data()'
    FROM Integration.PackageExecutions AS P
    FOR XML PATH('')
    )

    EXECUTE sp_executesql @sqlCommand

  END


/****** Object:  StoredProcedure [Integration].[sp_InsertTableForMonitoring]    Script Date: 11.11.2021 13:55:56 ******/
DROP PROCEDURE IF EXISTS [Integration].[sp_InsertTableForMonitoring]
GO

/****** Object:  StoredProcedure [Integration].[sp_InsertTableForMonitoring]    Script Date: 11.11.2021 13:55:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		bezvershuk_do
-- Create date: 19.08.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Integration].[sp_InsertTableForMonitoring] 
	-- Add the parameters for the stored procedure here
	(
		@tableName NVARCHAR(50) = NULL,
		@userName NVARCHAR(50) = NULL
	)
AS
BEGIN
	SET NOCOUNT ON;


	MERGE [Integration].[PackageExecutions] AS tg
	USING (SELECT COALESCE(@userName, SUSER_SNAME()), CAST('20100101' AS DATETIME2(7)), CAST('20100101' AS DATETIME2(7)), @tableName, 'new') 
		AS src ([UserName], [LastSuccessfulExtractionDatetime], [CurrentExtractionDateTime], [TableName], [Message])
		ON (tg.TableName = src.TableName)
	WHEN MATCHED THEN
		UPDATE SET 
			[UserName] = src.[UserName],
			[LastSuccessfulExtractionDatetime] = src.[LastSuccessfulExtractionDatetime],
			[CurrentExtractionDateTime] = src.[CurrentExtractionDateTime], 
			[Message] = src.[Message]
	WHEN NOT MATCHED THEN
		INSERT ([UserName], [LastSuccessfulExtractionDatetime], [CurrentExtractionDateTime], [TableName], [Message])
		VALUES (src.UserName, src.LastSuccessfulExtractionDatetime, src.CurrentExtractionDateTime, src.TableName, src.[Message]);
END
GO


/****** Object:  StoredProcedure [Integration].[sp_GetExtractionPeriod]    Script Date: 11.11.2021 13:58:26 ******/
DROP PROCEDURE IF EXISTS [Integration].[sp_GetExtractionPeriod]
GO

/****** Object:  StoredProcedure [Integration].[sp_GetExtractionPeriod]    Script Date: 11.11.2021 13:58:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		bezvershuk_do
-- Create date: 19.08.2021
-- Description:	
-- =============================================
CREATE PROCEDURE [Integration].[sp_GetExtractionPeriod]
	-- Add the parameters for the stored procedure here
	@tableName NVARCHAR(50) = NULL
AS
  BEGIN
    SET NOCOUNT ON;
    DECLARE @sqlCommand NVARCHAR(MAX) = 'TRUNCATE TABLE ' + @tableName

    EXECUTE sp_executesql @sqlCommand

    UPDATE [Integration].[PackageExecutions] 
    --todo: change to curent timestamp  / CURRENT_TIMESTAMP
    SET CurrentExtractionDateTime = '20211111',
      UserName = SUSER_SNAME(),
      Message = 'in progress'
    WHERE  TableName = @tableName

    SELECT LastSuccessfulExtractionDatetime, CurrentExtractionDateTime
    FROM [Integration].[PackageExecutions]
    WHERE TableName = @tableName

  END

GO



/* ================================================================================================================================================================================= */
/* A list of main tables for reservations reports */
/* ================================================================================================================================================================================= */
--
-- Create table [Uran].[Claims]
--
PRINT (N'Create table [Uran].[Claims]')
GO
CREATE TABLE Uran.Claims (
  id int NOT NULL,
  gid uniqueidentifier NOT NULL,
  ClaimerGID uniqueidentifier NULL,
  TypeGID uniqueidentifier NOT NULL,
  DateWriting datetime NULL,
  Notes nvarchar(255) NULL,
  AuthorGID uniqueidentifier NULL,
  RiskGID uniqueidentifier NULL,
  InsurerGID uniqueidentifier NULL,
  InsuranceObjectGID uniqueidentifier NULL,
  RecipientGID uniqueidentifier NULL,
  ProgramTypeGID uniqueidentifier NOT NULL,
  OwnerPostAddressGID uniqueidentifier NULL,
  IsVipClient bit NOT NULL,
  InsuranceSum decimal(18, 2) NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Claims_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO


GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Claims]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Claims', @userName = 'oranta\bezvershuk_do'
GO  


--
-- Create table [Uran].[Cases]
--
PRINT (N'Create table [Uran].[Cases]')
GO
CREATE TABLE Uran.Cases (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL,
  Number nvarchar(255) NOT NULL,
  InnerNumber nvarchar(50) NOT NULL,
  ClaimTypeGID uniqueidentifier NOT NULL,
  StatusGID uniqueidentifier NOT NULL,
  ResponsibleGID uniqueidentifier NOT NULL,
  Year int NOT NULL,
  EventGID uniqueidentifier NOT NULL,
  BranchGID uniqueidentifier NULL,
  IsRegressPossible bit NULL,
  AddDate datetime NOT NULL,
  AddUserGID uniqueidentifier NOT NULL,
  PinCode nvarchar(7) NULL,
  Executor nvarchar(255) NULL,
  ForumTopicGID uniqueidentifier NULL,
  AuthorGID uniqueidentifier NULL,
  WorkflowGID uniqueidentifier NULL,
  PolisNumber nvarchar(max) NULL,
  InsuredName nvarchar(max) NULL,
  InsuredObjectName nvarchar(max) NULL,
  ParticipantFaceNames nvarchar(max) NULL,
  ParticipantObjectNames nvarchar(max) NULL,
  LastModifiedAuthorGID uniqueidentifier NULL,
  LastModifiedDate datetime NULL,
  Deleted bit NOT NULL,
  CreateDate datetime NOT NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Cases_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Cases]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Cases', @userName = 'oranta\bezvershuk_do'
GO  

--
-- Create table [Uran].[Products]
--
PRINT (N'Create table [Uran].[Products]')
GO
CREATE TABLE Uran.Products (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL ROWGUIDCOL,
  ProductTypeGID uniqueidentifier NULL,
  PolisNumber nvarchar(50) NOT NULL,
  AuthorGID uniqueidentifier NULL,
  IsFromBlackWater bit NOT NULL,
  BeginingDate datetime NULL,
  EndingDate datetime NULL,
  RegisteredDate date NULL,
  IsReinsured bit NULL,
  ReinsurancePolisNumber nvarchar(50) NULL,
  BranchGID uniqueidentifier NULL,
  ExternalGID uniqueidentifier NULL,
  InsuredGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Products_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Products]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Products', @userName = 'oranta\bezvershuk_do'
GO  

--
-- Create table [Uran].[Events]
--
PRINT (N'Create table [Uran].[Events]')
GO
CREATE TABLE Uran.Events (
  id int NOT NULL,
  gid uniqueidentifier NOT NULL,
  Date datetime NULL,
  CountryGID uniqueidentifier NOT NULL,
  PostAddressGID uniqueidentifier NULL,
  Address nvarchar(255) NULL,
  AuthorGID uniqueidentifier NULL,
  Comment nvarchar(255) NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Events_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Events]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Events', @userName = 'oranta\bezvershuk_do'
GO  

--
-- Create table [Uran].[Reservations]
--
PRINT (N'Create table [Uran].[Reservations]')
GO
CREATE TABLE Uran.Reservations (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL,
  Amount decimal(18, 2) NOT NULL,
  PreviousDamageAmount decimal(18, 2) NULL,
  CreateUserGID uniqueidentifier NOT NULL,
  CreateDate datetime NOT NULL,
  CalculationTypeGID uniqueidentifier NOT NULL,
  CurrencyTypeGID uniqueidentifier NOT NULL,
  AmountHRN decimal(18, 2) NULL,
  AmountEuro decimal(18, 2) NULL,
  CaseGID uniqueidentifier NOT NULL,
  AuthorGID uniqueidentifier NULL,
  ClaimDate datetime NULL,
  EndingDate datetime NULL,
  ParentGID uniqueidentifier NULL,
  DocumentGID uniqueidentifier NULL,
  ParentDocumentGID uniqueidentifier NULL,
  LastModifiedDate datetime NULL,
  LastModifiedAuthorGID uniqueidentifier NULL,
  ExportDate datetime NULL,
  DoNotExport bit NOT NULL,
  Deleted bit NOT NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Reservations_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Reservations]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Reservations', @userName = 'oranta\bezvershuk_do'
GO  

--
-- Create table [Uran].[ClaimToParameterValues]
--
PRINT (N'Create table [Uran].[ClaimToParameterValues]')
GO
CREATE TABLE Uran.ClaimToParameterValues (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL,
  ClaimGID uniqueidentifier NOT NULL,
  ParameterValue sql_variant NOT NULL,
  ParameterGID uniqueidentifier NOT NULL,
  Deleted bit NOT NULL,
  AuthorGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_ClaimToParameterValues_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[ClaimToParameterValues]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.ClaimToParameterValues', @userName = 'oranta\bezvershuk_do'
GO  


--
-- Create table [Uran].[Faces]
--
PRINT (N'Create table [Uran].[Faces]')
GO
CREATE TABLE Uran.Faces (
  gid uniqueidentifier NOT NULL,
  Name nvarchar(255) NOT NULL,
  id bigint NOT NULL,
  AuthorGID uniqueidentifier NULL,
  PersonTypeID bigint NOT NULL,
  FullNameEnglish nvarchar(255) NULL,
  IdentificationCode nvarchar(15) NULL,
  Profession nvarchar(255) NULL,
  Address nvarchar(255) NULL,
  ActualAddress nvarchar(255) NULL,
  PhoneNumber nvarchar(30) NULL,
  Fax nvarchar(30) NULL,
  AdditionalContactInfo nvarchar(255) NULL,
  Email nvarchar(130) NULL,
  PostAddressGID uniqueidentifier NULL,
  PostActualAddressGID uniqueidentifier NULL,
  ActivityGID uniqueidentifier NULL,
  WebAddress nvarchar(50) NULL,
  PhoneNumberAdditional nvarchar(30) NULL,
  MobilePhoneNumber nvarchar(30) NULL,
  HomePhoneNumber nvarchar(30) NULL,
  WorkPhoneNumber nvarchar(30) NULL,
  FullName nvarchar(255) NULL,
  ParentGID uniqueidentifier NULL,
  EDRPOU nvarchar(15) NULL,
  IsResponsible bit NULL,
  Firstname nvarchar(50) NULL,
  Secondname nvarchar(50) NULL,
  Lastname nvarchar(50) NULL,
  IsMan bit NULL,
  Birthdate datetime NULL,
  DriverFrom int NULL,
  GenitiveName nvarchar(255) NULL,
  GenitivePost nvarchar(255) NULL,
  Post nvarchar(255) NULL,
  FaceID nvarchar(15) NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Faces_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Faces]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Faces', @userName = 'oranta\bezvershuk_do'
GO  

--
-- Create table [Uran].[InsuranceObjects]
--
PRINT (N'Create table [Uran].[InsuranceObjects]')
GO
CREATE TABLE Uran.InsuranceObjects (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL ROWGUIDCOL,
  ObjectCategory nvarchar(50) NULL,
  InsuranceObjectTypeGID uniqueidentifier NULL,
  Comment nvarchar(255) NULL,
  ObjectTypeGID uniqueidentifier NULL,
  Deleted bit NOT NULL,
  InsuranceSum decimal(18, 2) NULL,
  InsurancePayment decimal(18, 2) NULL,
  InsuranceRate decimal(18, 10) NULL,
  AuthorGID uniqueidentifier NULL,
  ObjectGID uniqueidentifier NULL,
  Name nvarchar(900) NULL,
  CalculatedInsuranceRate decimal(18, 10) NULL,
  CalculatedPayment decimal(18, 2) NULL,
  ParentInsuranceObjectGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_InsuranceObjects_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[InsuranceObjects]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.InsuranceObjects', @userName = 'oranta\bezvershuk_do'
GO  


--
-- Create table [Uran].[EventToParameterValues]
--
PRINT (N'Create table [Uran].[EventToParameterValues]')
GO
CREATE TABLE Uran.EventToParameterValues (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL ROWGUIDCOL,
  EventGID uniqueidentifier NOT NULL,
  ParameterValue sql_variant NOT NULL,
  ParameterGID uniqueidentifier NOT NULL,
  Deleted bit NOT NULL,
  AuthorGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_EventToParameterValues_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[EventToParameterValues]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.EventToParameterValues', @userName = 'oranta\bezvershuk_do'
GO 


--
-- Create table [Uran].[Payables]
--
PRINT (N'Create table [Uran].[Payables]')
GO
CREATE TABLE Uran.Payables (
  id int NOT NULL,
  gid uniqueidentifier NOT NULL,
  MFO nvarchar(255) NULL,
  PaymentAccount nvarchar(255) NULL,
  RecipientGID uniqueidentifier NULL,
  AmountUAH decimal(18, 2) NULL,
  Commission money NULL,
  DateTransferToAccounting datetime NULL,
  PaymentDate datetime NULL,
  Notes nvarchar(255) NULL,
  Deleted bit NOT NULL,
  AmountEuro money NULL,
  Amount money NULL,
  CurrencyTypeGID uniqueidentifier NULL,
  CalculationGID uniqueidentifier NULL,
  AccountStatusGID uniqueidentifier NULL,
  AccountPurposeGID uniqueidentifier NULL,
  AddUserGID uniqueidentifier NULL,
  FolderNumber int NOT NULL,
  ActSignDate datetime NULL,
  IsExported bit NOT NULL,
  ActNumber nvarchar(50) NULL,
  AuthorGID uniqueidentifier NULL,
  RefusalDate datetime NULL,
  RefusalLetterNumber nvarchar(50) NULL,
  RefusalReason nvarchar(2000) NULL,
  RequirementStatusGID uniqueidentifier NULL,
  PaymentPurpose nvarchar(2000) NULL,
  TransferNumber nvarchar(255) NULL,
  CalculationDate datetime NULL,
  ExportDate datetime NULL,
  ExportSuccessDate datetime NULL,
  OrderAccepted bit NOT NULL,
  OrderDate datetime NULL,
  OrderNumber nvarchar(50) NULL,
  PaymentPeriodsCount int NULL,
  PaymentPeriodDate datetime NULL,
  PaymentPeriodAmountFirst decimal(18, 2) NULL,
  PaymentPeriodAmount decimal(18, 2) NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Payables_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Payables]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Payables', @userName = 'oranta\bezvershuk_do'
GO 



--
-- Create table [Reference].[ReservationCalculationTypes]
--
PRINT (N'Create table [Reference].[ReservationCalculationTypes]')
GO
CREATE TABLE Reference.ReservationCalculationTypes (
  id int NOT NULL,
  gid uniqueidentifier NOT NULL,
  Name nvarchar(100) NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_ReservationCalculationTypes_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Reference].[ReservationCalculationTypes]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Reference.ReservationCalculationTypes', @userName = 'oranta\bezvershuk_do'
GO 



--
-- Create table [Reference].[ProgramTypeToClaimTypes]
--
PRINT (N'Create table [Reference].[ProgramTypeToClaimTypes]')
GO
CREATE TABLE Reference.ProgramTypeToClaimTypes (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL ROWGUIDCOL,
  ClaimTypeGID uniqueidentifier NOT NULL,
  ProgramTypeGID uniqueidentifier NOT NULL,
  ProductTypeGID uniqueidentifier NOT NULL,
  Reserve decimal(18, 2) NULL,
  RegulationCost decimal(18, 2) NULL,
  RetentionLimit decimal(18, 2) NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_ProgramTypeToClaimTypes_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Reference].[ProgramTypeToClaimTypes]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Reference.ProgramTypeToClaimTypes', @userName = 'oranta\bezvershuk_do'
GO 

--
-- Create table [Uran].[Vehicles]
--
PRINT (N'Create table [Uran].[Vehicles]')
GO
CREATE TABLE Uran.Vehicles (
  gid uniqueidentifier NOT NULL,
  RegistrationNumber nvarchar(50) NULL,
  id bigint NOT NULL,
  AuthorGID uniqueidentifier NULL,
  ModelGID uniqueidentifier NOT NULL,
  ManufacturerGID uniqueidentifier NOT NULL,
  ColorGID uniqueidentifier NULL,
  ColorTypeGID uniqueidentifier NULL,
  OwnerGID uniqueidentifier NULL,
  BodyNumber nvarchar(50) NULL,
  ProducedDate int NULL,
  RegistrationCertificate nvarchar(20) NULL,
  RegistrationDate datetime NULL,
  Cost decimal(18, 2) NULL,
  NumberOfSeats int NULL,
  AnticreepDevice nvarchar(250) NULL,
  AdditionalEquipment nvarchar(250) NULL,
  AuthorizedToManage nvarchar(250) NULL,
  SpecialConditions nvarchar(250) NULL,
  RegistrationPlace nvarchar(100) NULL,
  Mileage decimal(18, 2) NULL,
  Capacity decimal(18, 2) NULL,
  TechDocModel nvarchar(250) NULL,
  SettlementGID uniqueidentifier NULL,
  BodyTypeGID uniqueidentifier NULL,
  EngineTypeGID uniqueidentifier NULL,
  TransmissionTypeGID uniqueidentifier NULL,
  TypeGID uniqueidentifier NULL,
  EngineNumber nvarchar(50) NULL,
  ChasisNumber nvarchar(50) NULL,
  PostAddressGID uniqueidentifier NULL,
  Address nvarchar(255) NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Vehicles_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Vehicles]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Vehicles', @userName = 'oranta\bezvershuk_do'
GO 

--
-- Create table [Uran].[Regresses]
--
PRINT (N'Create table [Uran].[Regresses]')
GO
CREATE TABLE Uran.Regresses (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL ROWGUIDCOL,
  IncomingNumber nvarchar(255) NULL,
  IncomingDate datetime NULL,
  OutgoingNumber nvarchar(255) NULL,
  OutgoingDate datetime NULL,
  Amount decimal(18, 2) NULL,
  IsProperty bit NOT NULL,
  InsuranceCompanyGID uniqueidentifier NULL,
  AuthorGID uniqueidentifier NOT NULL,
  Deleted bit NOT NULL,
  PayableGID uniqueidentifier NULL,
  DamagedProperty nvarchar(255) NULL,
  Notes nvarchar(255) NULL,
  BranchGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Regresses_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Regresses]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Regresses', @userName = 'oranta\bezvershuk_do'
GO 

--
-- Create table [Uran].[CasesDocuments]
--
PRINT (N'Create table [Uran].[CasesDocuments]')
GO
CREATE TABLE Uran.CasesDocuments (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL ROWGUIDCOL,
  CaseGID uniqueidentifier NOT NULL,
  DocumentGID uniqueidentifier NOT NULL,
  AddDate datetime NOT NULL,
  AddUserGID uniqueidentifier NOT NULL,
  ProcessingStatusGID uniqueidentifier NULL,
  StatusGID uniqueidentifier NOT NULL,
  IsAccepted bit NOT NULL,
  ParentGID uniqueidentifier NULL,
  AuthorGID uniqueidentifier NULL,
  Deleted bit NOT NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_CasesDocuments_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[CasesDocuments]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.CasesDocuments', @userName = 'oranta\bezvershuk_do'
GO 

--
-- Create table [Uran].[Documents]
--
PRINT (N'Create table [Uran].[Documents]')
GO
CREATE TABLE Uran.Documents (
  id int NOT NULL,
  gid uniqueidentifier NOT NULL,
  Name nvarchar(255) NOT NULL,
  Serial nvarchar(50) NULL,
  Number nvarchar(255) NOT NULL,
  StartDate datetime NULL,
  EndDate datetime NULL,
  IssuedDate date NULL,
  IssuedBy nvarchar(200) NULL,
  ObjectGID uniqueidentifier NULL,
  TypeGID uniqueidentifier NULL,
  Type nvarchar(255) NULL,
  IsLockedOut bit NOT NULL,
  AddDate datetime NOT NULL,
  AddUserGID uniqueidentifier NOT NULL,
  Deleted bit NOT NULL,
  AuthorGID uniqueidentifier NULL,
  AutoGeneratNumbere bigint NULL,
  WorkflowGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Documents_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Documents]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Documents', @userName = 'oranta\bezvershuk_do'
GO 


--
-- Create table [Uran].[PayableToParameterValues]
--
PRINT (N'Create table [Uran].[PayableToParameterValues]')
GO
CREATE TABLE Uran.PayableToParameterValues (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL,
  PayableGID uniqueidentifier NOT NULL,
  ParameterValue sql_variant NOT NULL,
  ParameterGID uniqueidentifier NOT NULL,
  Deleted bit NOT NULL,
  AuthorGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_PayableToParameterValues_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[PayableToParameterValues]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.PayableToParameterValues', @userName = 'oranta\bezvershuk_do'
GO 


--
-- Create table [Uran].[Calculations]
--
PRINT (N'Create table [Uran].[Calculations]')
GO
CREATE TABLE Uran.Calculations (
  id int NOT NULL,
  gid uniqueidentifier NOT NULL,
  RecipientGID uniqueidentifier NULL,
  PrintDate datetime NULL,
  PrintUserGID uniqueidentifier NULL,
  AuthorGID uniqueidentifier NULL,
  CommissarExaminationGID uniqueidentifier NULL,
  CostWork decimal NULL,
  Materials decimal(18, 2) NULL,
  CostRepair decimal(18, 2) NULL,
  DamageWear decimal(18, 2) NULL,
  ObjectName nvarchar(255) NULL,
  Parts decimal(18, 2) NULL,
  DocumentStatus nvarchar(255) NULL,
  OrganizationExpert nvarchar(255) NULL,
  DamageAmount decimal(18, 2) NULL,
  AgreementType nvarchar(255) NULL,
  AgreementAmount decimal(18, 2) NULL,
  CalculationTypeGID uniqueidentifier NOT NULL,
  ServiceStationGID uniqueidentifier NULL,
  ExpertAppraiserGID uniqueidentifier NULL,
  BranchGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_Calculations_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[Calculations]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.Calculations', @userName = 'oranta\bezvershuk_do'
GO 


--
-- Create table [Uran].[CalculationToParameterValues]
--
PRINT (N'Create table [Uran].[CalculationToParameterValues]')
GO
CREATE TABLE Uran.CalculationToParameterValues (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL,
  CalculationGID uniqueidentifier NOT NULL,
  ParameterValue sql_variant NOT NULL,
  ParameterGID uniqueidentifier NOT NULL,
  Deleted bit NOT NULL,
  AuthorGID uniqueidentifier NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_CalculationToParameterValues_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]
GO

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Uran].[CalculationToParameterValues]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Uran.CalculationToParameterValues', @userName = 'oranta\bezvershuk_do'
GO 

--
-- Create table [Reference].[DocumentParameterValues]
--
PRINT (N'Create table [Reference].[DocumentParameterValues]')
GO
CREATE TABLE Reference.DocumentParameterValues (
  id bigint NOT NULL,
  gid uniqueidentifier NOT NULL,
  DocumentParameterGID uniqueidentifier NULL,
  Value sql_variant NULL,
  LogCreateDateTime datetime2 NOT NULL,
  LogActionDateTime datetime2 NOT NULL,
  RecordSource nvarchar(10) NOT NULL,
  LoadDateTime datetime2 NOT NULL,
  CONSTRAINT PK_DocumentParameterValues_Id PRIMARY KEY CLUSTERED (Id)
)
ON [PRIMARY]

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Reference].[DocumentParameterValues]') AND type in (N'U'))
  EXEC [Integration].[sp_InsertTableForMonitoring] @tableName = 'Reference.DocumentParameterValues', @userName = 'oranta\bezvershuk_do'
GO 

GO
SET NOEXEC OFF
GO
/* ================================================================================================================================================================================= */
/* ================================================================================================================================================================================= */


