DECLARE @LastExecutionDateTime DATETIME2 = ?; 
DECLARE @CurentExecutionDateTime DATETIME2 = ?;

SELECT MainData.id,
       MainData.gid,
       MainData.ProductTypeGID,
       MainData.PolisNumber,
       MainData.AuthorGID,
       MainData.IsFromBlackWater,
       MainData.BeginingDate,
       MainData.EndingDate,
       MainData.RegisteredDate,
       MainData.IsReinsured,
       MainData.ReinsurancePolisNumber,
       MainData.BranchGID,
       MainData.ExternalGID,
       MainData.InsuredGID,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.ProductTypeGID,
           src.PolisNumber,
           src.AuthorGID,
           src.IsFromBlackWater,
           src.BeginingDate,
           src.EndingDate,
           src.RegisteredDate,
           src.IsReinsured,
           src.ReinsurancePolisNumber,
           src.BranchGID,
           src.ExternalGID,
           src.InsuredGID,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.Products AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.Products AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime
