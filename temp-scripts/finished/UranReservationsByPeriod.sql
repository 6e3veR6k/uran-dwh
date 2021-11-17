DECLARE @LastExecutionDateTime DATETIME2 = ?; 
DECLARE @CurentExecutionDateTime DATETIME2 = ?;



SELECT MainData.id,
       MainData.gid,
       MainData.Amount,
       MainData.PreviousDamageAmount,
       MainData.CreateUserGID,
       MainData.CreateDate,
       MainData.CalculationTypeGID,
       MainData.CurrencyTypeGID,
       MainData.AmountHRN,
       MainData.AmountEuro,
       MainData.CaseGID,
       MainData.AuthorGID,
       MainData.ClaimDate,
       MainData.EndingDate,
       MainData.ParentGID,
       MainData.DocumentGID,
       MainData.ParentDocumentGID,
       MainData.LastModifiedDate,
       MainData.LastModifiedAuthorGID,
       MainData.ExportDate,
       MainData.DoNotExport,
       MainData.Deleted,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.Amount,
           src.PreviousDamageAmount,
           src.CreateUserGID,
           src.CreateDate,
           src.CalculationTypeGID,
           src.CurrencyTypeGID,
           src.AmountHRN,
           src.AmountEuro,
           src.CaseGID,
           src.AuthorGID,
           src.ClaimDate,
           src.EndingDate,
           src.ParentGID,
           src.DocumentGID,
           src.ParentDocumentGID,
           src.LastModifiedDate,
           src.LastModifiedAuthorGID,
           src.ExportDate,
           src.DoNotExport,
           src.Deleted,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.Reservations AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.Reservations AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime
