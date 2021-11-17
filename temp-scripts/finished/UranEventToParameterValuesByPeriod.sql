DECLARE @LastExecutionDateTime DATETIME2 = ?;
DECLARE @CurentExecutionDateTime DATETIME2 = ?;



SELECT MainData.id,
       MainData.gid,
       MainData.EventGID,
       MainData.ParameterValue,
       MainData.ParameterGID,
       MainData.Deleted,
       MainData.AuthorGID,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.EventGID,
           src.ParameterValue,
           src.ParameterGID,
           src.Deleted,
           src.AuthorGID,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.EventToParameterValues AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.EventToParameterValues AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime

