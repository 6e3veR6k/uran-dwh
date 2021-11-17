DECLARE @LastExecutionDateTime DATETIME2 = ?; 
DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.id,
       MainData.gid,
       MainData.CaseGID,
       MainData.DocumentGID,
       MainData.AddDate,
       MainData.AddUserGID,
       MainData.ProcessingStatusGID,
       MainData.StatusGID,
       MainData.IsAccepted,
       MainData.ParentGID,
       MainData.AuthorGID,
       MainData.Deleted,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.CaseGID,
           src.DocumentGID,
           src.AddDate,
           src.AddUserGID,
           src.ProcessingStatusGID,
           src.StatusGID,
           src.IsAccepted,
           src.ParentGID,
           src.AuthorGID,
           src.Deleted,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.CasesDocuments AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.CasesDocuments AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime