DECLARE @LastExecutionDateTime DATETIME2 = ?;
DECLARE @CurentExecutionDateTime DATETIME2 = ?;

SELECT
	MainData.id,
	MainData.gid,
	MainData.Number,
	MainData.InnerNumber,
	MainData.ClaimTypeGID,
	MainData.StatusGID,
	MainData.ResponsibleGID,
	MainData.Year,
	MainData.EventGID,
	MainData.BranchGID,
	MainData.IsRegressPossible,
	MainData.AddDate,
	MainData.AddUserGID,
	MainData.PinCode,
	MainData.Executor,
	MainData.ForumTopicGID,
	MainData.AuthorGID,
	MainData.WorkflowGID,
	MainData.PolisNumber,
	MainData.InsuredName,
	MainData.InsuredObjectName,
	MainData.ParticipantFaceNames,
	MainData.ParticipantObjectNames,
	MainData.LastModifiedAuthorGID,
	MainData.LastModifiedDate,
	MainData.Deleted,
	MainData.CreateDate,
	MainData.LogCreateDate,
	MainData.LogActionDate,
	MainData.SourceIdentity,
	MainData.LoadDatetime
FROM
	(SELECT 
		src.id,
		src.gid,
		src.Number,
		src.InnerNumber,
		src.ClaimTypeGID,
		src.StatusGID,
		src.ResponsibleGID,
		src.Year,
		src.EventGID,
		src.BranchGID,
		src.IsRegressPossible,
		src.AddDate,
		src.AddUserGID,
		src.PinCode,
		src.Executor,
		src.ForumTopicGID,
		src.AuthorGID,
		src.WorkflowGID,
		src.PolisNumber,
		src.InsuredName,
		src.InsuredObjectName,
		src.ParticipantFaceNames,
		src.ParticipantObjectNames,
		src.LastModifiedAuthorGID,
		src.LastModifiedDate,
		src.Deleted,
		src.CreateDate,
		COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate], 
		COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
		@@SERVERNAME AS SourceIdentity,
		CURRENT_TIMESTAMP AS LoadDatetime
	FROM dbo.Cases AS src
	OUTER APPLY 
		(SELECT 
			MIN(L.ActionDate) AS [_CreateDate], 
			MAX(L.ActionDate) AS [_ActionDate]
		FROM log.Cases AS L
		WHERE L.LoggedEntityGID = src.gid 
		GROUP BY L.LoggedEntityGID) AS lg
	) AS MainData
WHERE 
	MainData.[LogCreateDate] > @LastExecutionDateTime 
	AND MainData.[LogActionDate] <= @CurentExecutionDateTime
