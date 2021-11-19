DECLARE @LastExecutionDateTime DATETIME2 = ?;
DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.id,
       MainData.gid,
       MainData.CaseGID,
       MainData.Number,
       MainData.DATE,
       MainData.PostAddressGID,
       MainData.Address,
       MainData.MobileCommissarGID,
       MainData.ActualDate,
       MainData.IsFinished,
       MainData.Notes,
       MainData.BackToDirectionDate,
       MainData.AttachedToCaseDate,
       MainData.SentToAccountsCenterDate,
       MainData.AuthorGID,
       MainData.TypeGID,
       MainData.StatusGID,
       MainData.ActualPostAddressGID,
       MainData.ActualAddress,
       MainData.ObjectName,
       MainData.ObjectGID,
       MainData.SecurityTypeGID,
       MainData.ServiceStationGID,
       MainData.BranchGID,
       MainData.Deleted,
       MainData.ExpertAppraiserGID,
       MainData.CreateDate,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.CaseGID,
           src.Number,
           src.DATE,
           src.PostAddressGID,
           src.Address,
           src.MobileCommissarGID,
           src.ActualDate,
           src.IsFinished,
           src.Notes,
           src.BackToDirectionDate,
           src.AttachedToCaseDate,
           src.SentToAccountsCenterDate,
           src.AuthorGID,
           src.TypeGID,
           src.StatusGID,
           src.ActualPostAddressGID,
           src.ActualAddress,
           src.ObjectName,
           src.ObjectGID,
           src.SecurityTypeGID,
           src.ServiceStationGID,
           src.BranchGID,
           src.Deleted,
           src.ExpertAppraiserGID,
           src.CreateDate,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.CommissarExaminations AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.CommissarExaminations AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime