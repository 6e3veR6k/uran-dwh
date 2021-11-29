CREATE TABLE [Hub].[
  Cases
  ]([Hub
  Case
  Id] [bigint] NOT NULL, [
    Case
  Gid] [uniqueidentifier] NOT NULL, [SourceRecordId] [int] NOT NULL, [LoadDateTime] [datetime2](7) NOT NULL, CONSTRAINT [PK_
  Cases
  _Hub
  Case
  Id]	PRIMARY KEY CLUSTERED	([Hub
  Case
  Id] ASC)	ON [DATA], CONSTRAINT [KEY_
  Cases
  _
  Case
  Gid]	UNIQUE NONCLUSTERED	([
    Case
  Gid] ASC)	ON [INDEX]) ON [DATA]




Claims
Cases
Products
Events
Reservations
ClaimToParameterValues
Faces
InsuranceObjects
EventToParameterValues
Payables
Vehicles
Regresses
CasesDocuments
Documents
PayableToParameterValues
Calculations
CalculationToParameterValues
CommissarExaminations
PayableDetails
PayablePayments
CommissarExaminationToParameterValues