DECLARE @LastExecutionDateTime DATETIME2 = ?;
DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.id,
       MainData.gid,
       MainData.RecipientGID,
       MainData.PrintDate,
       MainData.PrintUserGID,
       MainData.AuthorGID,
       MainData.CommissarExaminationGID,
       MainData.CostWork,
       MainData.Materials,
       MainData.CostRepair,
       MainData.DamageWear,
       MainData.ObjectName,
       MainData.Parts,
       MainData.DocumentStatus,
       MainData.OrganizationExpert,
       MainData.DamageAmount,
       MainData.AgreementType,
       MainData.AgreementAmount,
       MainData.CalculationTypeGID,
       MainData.ServiceStationGID,
       MainData.ExpertAppraiserGID,
       MainData.BranchGID,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.RecipientGID,
           src.PrintDate,
           src.PrintUserGID,
           src.AuthorGID,
           src.CommissarExaminationGID,
           src.CostWork,
           src.Materials,
           src.CostRepair,
           src.DamageWear,
           src.ObjectName,
           src.Parts,
           src.DocumentStatus,
           src.OrganizationExpert,
           src.DamageAmount,
           src.AgreementType,
           src.AgreementAmount,
           src.CalculationTypeGID,
           src.ServiceStationGID,
           src.ExpertAppraiserGID,
           src.BranchGID,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.Calculations AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.Calculations AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime
