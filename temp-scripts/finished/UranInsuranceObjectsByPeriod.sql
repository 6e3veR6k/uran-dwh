DECLARE @LastExecutionDateTime DATETIME2 = ?;
DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.id,
       MainData.gid,
       MainData.ObjectCategory,
       MainData.InsuranceObjectTypeGID,
       MainData.Comment,
       MainData.ObjectTypeGID,
       MainData.Deleted,
       MainData.InsuranceSum,
       MainData.InsurancePayment,
       MainData.InsuranceRate,
       MainData.AuthorGID,
       MainData.ObjectGID,
       MainData.Name,
       MainData.CalculatedInsuranceRate,
       MainData.CalculatedPayment,
       MainData.ParentInsuranceObjectGID,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.ObjectCategory,
           src.InsuranceObjectTypeGID,
           src.Comment,
           src.ObjectTypeGID,
           src.Deleted,
           src.InsuranceSum,
           src.InsurancePayment,
           src.InsuranceRate,
           src.AuthorGID,
           src.ObjectGID,
           src.Name,
           src.CalculatedInsuranceRate,
           src.CalculatedPayment,
           src.ParentInsuranceObjectGID,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.InsuranceObjects AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.InsuranceObjects AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime
