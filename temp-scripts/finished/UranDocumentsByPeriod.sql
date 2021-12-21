DECLARE @LastExecutionDateTime DATETIME2 = ?;
DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.id,
       MainData.gid,
       MainData.Name,
       MainData.Serial,
       MainData.Number,
       MainData.StartDate,
       MainData.EndDate,
       MainData.IssuedDate,
       MainData.IssuedBy,
       MainData.ObjectGID,
       MainData.TypeGID,
       MainData.Type,
       MainData.IsLockedOut,
       MainData.AddDate,
       MainData.AddUserGID,
       MainData.Deleted,
       MainData.AuthorGID,
       MainData.AutoGeneratNumbere,
       MainData.WorkflowGID,
       MainData.StatusGID,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.Name,
           src.Serial,
           src.Number,
           src.StartDate,
           src.EndDate,
           src.IssuedDate,
           src.IssuedBy,
           src.ObjectGID,
           src.TypeGID,
           src.Type,
           src.IsLockedOut,
           src.AddDate,
           src.AddUserGID,
           src.Deleted,
           src.AuthorGID,
           src.AutoGeneratNumbere,
           src.WorkflowGID,
           src.StatusGID,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.Documents AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.Documents AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime