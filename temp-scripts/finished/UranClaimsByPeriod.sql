DECLARE @LastExecutionDateTime DATETIME2 = ?; 
DECLARE @CurentExecutionDateTime DATETIME2 = ?;

SELECT
	MainData.id,
	MainData.gid,
	MainData.ClaimerGID,
	MainData.TypeGID,
	MainData.DateWriting,
	MainData.Notes,
	MainData.AuthorGID,
	MainData.RiskGID,
	MainData.InsurerGID,
	MainData.InsuranceObjectGID,
	MainData.RecipientGID,
	MainData.ProgramTypeGID,
	MainData.OwnerPostAddressGID,
	MainData.IsVipClient,
	MainData.InsuranceSum,
	MainData.LogCreateDate,
	MainData.LogActionDate,
	MainData.SourceIdentity,
	MainData.LoadDatetime
FROM
	(SELECT
		src.id,
		src.gid,
		src.ClaimerGID,
		src.TypeGID,
		src.DateWriting,
		src.Notes,
		src.AuthorGID,
		src.RiskGID,
		src.InsurerGID,
		src.InsuranceObjectGID,
		src.RecipientGID,
		src.ProgramTypeGID,
		src.OwnerPostAddressGID,
		src.IsVipClient,
		src.InsuranceSum,
		COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate], 
		COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
		@@SERVERNAME AS SourceIdentity,
		CURRENT_TIMESTAMP AS LoadDatetime
	FROM dbo.Claims AS src
	OUTER APPLY 
		(SELECT 
			MIN(L.ActionDate) AS [_CreateDate], 
			MAX(L.ActionDate) AS [_ActionDate]
		FROM log.Claims AS L
		WHERE L.LoggedEntityGID = src.gid 
		GROUP BY L.LoggedEntityGID) AS lg
	) AS MainData
WHERE 
	MainData.[LogCreateDate] > @LastExecutionDateTime 
	AND MainData.[LogActionDate] <= @CurentExecutionDateTime

