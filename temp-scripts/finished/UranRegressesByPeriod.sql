DECLARE @LastExecutionDateTime DATETIME2 = ?; 
DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.id,
       MainData.gid,
       MainData.IncomingNumber,
       MainData.IncomingDate,
       MainData.OutgoingNumber,
       MainData.OutgoingDate,
       MainData.Amount,
       MainData.IsProperty,
       MainData.InsuranceCompanyGID,
       MainData.AuthorGID,
       MainData.Deleted,
       MainData.PayableGID,
       MainData.DamagedProperty,
       MainData.Notes,
       MainData.BranchGID,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.IncomingNumber,
           src.IncomingDate,
           src.OutgoingNumber,
           src.OutgoingDate,
           src.Amount,
           src.IsProperty,
           src.InsuranceCompanyGID,
           src.AuthorGID,
           src.Deleted,
           src.PayableGID,
           src.DamagedProperty,
           src.Notes,
           src.BranchGID,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.Regresses AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.Regresses AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime

