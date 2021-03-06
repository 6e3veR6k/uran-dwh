CREATE TABLE [Stage].[Products] (
  [Id] [bigint] NOT NULL,
  [GID] [uniqueidentifier] NOT NULL,
  [ProductTypeGID] [uniqueidentifier] NOT NULL,
  [PolisNumber] [nvarchar](50) NOT NULL,
  [BranchGID] [uniqueidentifier] NOT NULL,
  [ResponsibleGID] [uniqueidentifier] NOT NULL,
  [Number] [nvarchar](50) NULL,
  [IsProlonged] [bit] NULL,
  [IsAction] [bit] NULL,
  [BeginingDate] [datetime] NOT NULL,
  [EndingDate] [datetime] NOT NULL,
  [RegisteredDate] [date] NOT NULL,
  [DurationUnitGID] [uniqueidentifier] NULL,
  [AgentReportDate] [datetime] NULL,
  [AgentReportNumber] [nvarchar](50) NULL,
  [InsurerGID] [uniqueidentifier] NOT NULL,
  [InsuranceSumUkr] [decimal](18, 2) NULL,
  [Comment] [nvarchar](255) NULL,
  [Deleted] [bit] NOT NULL,
  [SupplementaryAgreementTypeGID] [uniqueidentifier] NULL,
  [BaseProductGID] [uniqueidentifier] NULL,
  [ContractGID] [uniqueidentifier] NULL,
  [SourceTypeGID] [uniqueidentifier] NOT NULL,
  [StatusGID] [uniqueidentifier] NOT NULL,
  [IsEditable] [bit] NULL,
  [IsFull] [bit] NOT NULL,
  [LastModifiedAuthorGID] [uniqueidentifier] NULL,
  [ProductActionGID] [uniqueidentifier] NULL,
  [ProductPartnerActionGID] [uniqueidentifier] NULL,
  [CreatorUserGID] [uniqueidentifier] NULL,
  [AuthorGID] [uniqueidentifier] NULL,
  [CreateDate] [datetime] NULL,
  [LastModifiedDate] [datetime] NULL,
  [SalesChannelGID] [uniqueidentifier] NULL,
  [EntranceIntoForceGID] [uniqueidentifier] NULL,
  [IsInwardsReinsurance] [bit] NOT NULL,
  [BasePayment] [decimal](18, 2) NULL,
  [IsReinsured] [bit] NULL,
  [ReinsurancePolisNumber] [nvarchar](50) NULL,
  [SelectDate] [datetime] NULL,
  [OnSaveDate] [datetime] NULL,
  [WorkflowGID] [uniqueidentifier] NULL,
  [OwnerGID] [uniqueidentifier] NULL,
  [DealGID] [uniqueidentifier] NULL,
  [SubSalesChannelGID] [uniqueidentifier] NULL,
  [BasedOnProductGID] [uniqueidentifier] NULL,
  [InsurerFaceGID] [uniqueidentifier] NOT NULL,
  [InsurerFacePersonTypeID] [bigint] NOT NULL,
  [InsurerFaceName] [nvarchar](255) NOT NULL,
  [_CreateDateTime] [datetime2] NOT NULL,
  [_ActionDateTime] [datetime2] NOT NULL,
  [SourceRecordId] [int] NOT NULL,
  [LoadDateTime] [datetime2] NOT NULL,
  CONSTRAINT [PK_Products_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO