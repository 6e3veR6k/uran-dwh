/*
TODO: убрать селекты из селекта полей 
*/
	
  
  SELECT
		Ex.Id,
		C.Number as [Номер справи],
		NULL AS [Тип пошкодженого майна],
		Ex.ObjectName as [Найменування пошкодженого майна],
		(select T.Name from Oberon.meta.CommissarExaminationTypes as T where T.gid = Ex.TypeGID) as [Вид огляду],
		(select V.Value from Oberon.meta.DocumentParameterValues as V where V.gid = ExParamsValues.[Адреса огляду]) as [Адреса огляду],
		case ExParamsValues.[Огляд не потрібен]
			when 0 then 'ні'
			when 1 then 'так'
		else NULL end as [Огляд не потрібен],
		(select V.Value from Oberon.meta.DocumentParameterValues as V where V.gid = ExParamsValues.[Ознака планового огляду]) as [Ознака планового огляду],
		Ex.Date as [Дата планового огляду],
		tmp.GetPostAddress(Ex.PostAddressGID) AS [Місце планового огляду],
		Ex.Address AS [Адреса планового огляду],
		(select V.Value from Oberon.meta.DocumentParameterValues as V where V.gid = ExParamsValues.[Факт огляду]) as [Факт огляду],
		MobileCommissar.FaceName AS [ПІБ аваркома],
		CASE Ex.IsFinished 
			when 0 then 'ні'
			when 1 then 'так'
		else NULL end AS [Огляд проведено, як і заплановано],
		(select V.Value from Oberon.meta.DocumentParameterValues as V where V.gid = ExParamsValues.[Ознака огляду]) as [Ознака огляду],
		Ex.ActualDate AS [Дата огляду],
		tmp.GetPostAddress(Ex.ActualPostAddressGID) AS [Місце фактичного огляду],
		Ex.ActualAddress AS	[Фактична адреса],
		(select V.Value from Oberon.meta.DocumentParameterValues as V where V.gid = ExParamsValues.[Індекс папки огляду]) as [Індекс папки огляду],
		Ex.Notes AS [Коментар огляду],
		(SELECT B.Code + ' ' + B.Name FROM dbo.Branches AS B WHERE B.gid = C.BranchGID) AS [Регіон призначення огляду],
		CASE ExParamsValues.[Ознака передачі огляду на інший регіон]
			when 0 then 'ні'
			when 1 then 'так'
		else NULL end AS [Ознака передачі огляду на інший регіон],
		(SELECT B.Code + ' ' + B.Name FROM dbo.Branches AS B WHERE B.gid = Ex.BranchGID) AS [Передано на регіон],
		Ex.CreateDate AS [Дата створення]
	from dbo.CommissarExaminations as Ex
	OUTER APPLY (
	SELECT
		COALESCE(F.Lastname, '') + ' ' + COALESCE(F.Firstname, '') + ' ' + COALESCE(F.Secondname, '') AS FaceName
	FROM dbo.Users AS F
	WHERE F.gid = Ex.MobileCommissarGID
	) as MobileCommissar
	left join (
		select *
		from(
		select
			Params.CommissarExaminationGID,
			Params.ParameterValue,
			ParamsNames.Name as ParameterName
		from dbo.CommissarExaminationToParameterValues as Params
		inner join Oberon.meta.DocumentParameters as ParamsNames on ParamsNames.gid = Params.ParameterGID
		) as src
		pivot (
		max(src.ParameterValue) for src.ParameterName in (
									[Cтупінь вини страхувальника (ЦКП)],
									[Адреса огляду],
									[Виконавець (ЦКП)],
									[Дата (ЦКП)],
									[Дата запиту (надати ТЗ на огляд)],
									[Дата попереднього рішення про ступінь вини (ЦКП)],
									[Індекс папки огляду],
									[Огляд не потрібен],
									[Ознака огляду],
									[Ознака передачі огляду на інший регіон],
									[Ознака планового огляду],
									[Тип схеми],
									[Факт огляду],
									[Факт прийняття попереднього рішення],
									[Факт прийняття рішення]
									)
		) as pv
	) as ExParamsValues
		on ExParamsValues.CommissarExaminationGID = Ex.gid
	INNER JOIN Oberon.dbo.Cases AS C ON C.gid = Ex.CaseGID	AND C.Deleted = 0
	INNER JOIN Oberon.meta.CommissarExaminationStatuses AS St ON St.gid = Ex.StatusGID
	WHERE Ex.Deleted = 0
		AND EXISTS (SELECT 1 FROM meta.CommissarExaminationSecurityTypes AS ST WHERE  Ex.SecurityTypeGID = ST.gid AND St.Name = 'Огляд')
		--AND C.Number = '21-08-181'	

