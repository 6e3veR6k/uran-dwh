CREATE TABLE [Stage].[Faces] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [PersonTypeID] [bigint] NOT NULL,
  [Name] [nvarchar](255) NOT NULL,
  [IdentificationCode] [nvarchar](15) NULL,
  [Profession] [nvarchar](255) NULL,
  [Address] [nvarchar](255) NULL,
  [ActualAddress] [nvarchar](255) NULL,
  [PhoneNumber] [nvarchar](30) NULL,
  [Fax] [nvarchar](30) NULL,
  [AdditionalContactInfo] [nvarchar](255) NULL,
  [Email] [nvarchar](130) NULL,
  [PostAddressGID] [uniqueidentifier] NULL,
  [PostActualAddressGID] [uniqueidentifier] NULL,
  [ActivityGID] [uniqueidentifier] NULL,
  [FullNameEnglish] [varchar](255) NULL,
  [WebAddress] [nvarchar](50) NULL,
  [PhoneNumberAdditional] [nvarchar](30) NULL,
  [MobilePhoneNumber] [nvarchar](30) NULL,
  [HomePhoneNumber] [nvarchar](30) NULL,
  [WorkPhoneNumber] [nvarchar](30) NULL,
  [FullName] [nvarchar](255) NULL,
  [ParentGID] [uniqueidentifier] NULL,
  [EDRPOU] [nvarchar](15) NULL,
  [IsResponsible] [bit] NULL,
  [Firstname] [nvarchar](50) NULL,
  [Secondname] [nvarchar](50) NULL,
  [Lastname] [nvarchar](50) NULL,
  [IsMan] [bit] NULL,
  [Birthdate] [datetime] NULL,
  [DriverFrom] [int] NULL,
  [GenitiveName] [nvarchar](255) NULL,
  [GenitivePost] [nvarchar](255) NULL,
  [Post] [nvarchar](255) NULL,
  [FaceID] [nvarchar](15) NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [IsSanction] [bit] NULL,
  [IsPEP] [bit] NULL,
  [RiskGroupID] [bigint] NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL
)
ON [PRIMARY]
GO