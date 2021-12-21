
SELECT
IIF(ISNUMERIC(P.PolisNumber)=1, NULL, LEFT(P.PolisNumber, 2)) AS [Серія]
, IIF(ISNUMERIC(P.PolisNumber)=1, P.PolisNumber, SUBSTRING(P.PolisNumber, 4, 7)) AS [Номер]
, SAT.Name AS [Тип договору]
, bD.Date AS [Дата початку дії]
, eD.Date AS [Дата кінця дії]
, rD.Date AS [Дата укладання]
, P.PValue AS [Плановий платіж]
, B.BranchCode AS [Код віділення]
, CAST(cast(PC.CancelDate AS nvarchar(250)) AS DATE) AS [Дата розриву договору]
, CAST(PC.ReturnSum AS DECIMAL(18,2)) AS [Сумма повернення]
, IIF(ISNUMERIC(P.BasePolisNumber)=1, NULL, LEFT(P.BasePolisNumber, 2)) AS [Серія договору на який зробленно переоформлення/дублікат]
, IIF(ISNUMERIC(P.BasePolisNumber)=1, P.BasePolisNumber, SUBSTRING(P.BasePolisNumber, 4, 7)) AS [Номер договору на який зробленно переоформлення/дублікат]
, BZ.BranchZone AS [Зона віділення]
, Tariff.TariffName AS [Тариф]
, IIF(F.PersonTypeID = 2, 'Ю', 'Ф') as [Тип особи Агента]
FROM DmartTest.Osago.Products AS P
LEFT JOIN DmartTest.Osago.ProductCancels AS PC ON PC.ProductId = P.ProductId AND PC.Deleted = 0
LEFT JOIN DmartTest.Osago.SupplementaryAgreementTypes AS SAT ON SAT.SupplementaryAgreementTypeId = P.SupplementaryAgreementTypeId
LEFT JOIN DmartTest.Dimension.Dates AS bD ON bD.DateKey = P.BeginingDate
LEFT JOIN DmartTest.Dimension.Dates AS rD ON rD.DateKey = P.RegisteredDate
LEFT JOIN DmartTest.Dimension.Dates AS eD ON eD.DateKey = P.EndingDate
INNER JOIN DmartTest.Dimension.ProgramTypes AS PT ON PT.ProgramTypeId = P.ProgramTypeId
INNER JOIN DmartTest.Dimension.Branches AS B ON P.WhBranchId = B.BranchWhId
LEFT JOIN OrantaSch.dbo.Products AS MP ON MP.id = P.ProductId AND MP.Deleted = 0
LEFT JOIN OrantaSch.dbo.Programs AS MPg ON MPg.ProductGid = MP.gid and MPg.id = P.ProgramId AND MPg.Deleted = 0
LEFT JOIN ServiceBase.dbo.BranchesZone AS BZ ON BZ.gid = B.BranchGID
INNER JOIN (SELECT 
				ap.Number as TariffName, 
				ppp.ProductGID 
			FROM 
				Callisto.dbo.AgentPermissions as ap
			inner join 
				OrantaSch.dbo.ProductPermissions as pp 
				on pp.AgentPermissionGID = ap.gid
			inner join 
				OrantaSch.dbo.ProductToProductPermissions as ppp 
				on ppp.ProductPermissionGID = pp.gid
			--WHERE ap.Number in
			--		('Базовий ФО',
			--		 'ЕП Базовий ФО',
			--		 'ЕП Дисконт',
			--		 'ЕП Стандарт 1М_3',
			--		 'ЕП Стандарт 2.1М_1',
			--		 'ЕП Стандарт 2М_1',
			--		 'ЕП Стандарт 2М_2',
			--		 'Стандарт 1М_3',
			--		 'Стандарт 1М_2',
			--		 'Стандарт 2М_2',
			--		 'Стандарт 1М_ФО',
			--		 'Стандарт 2М_ФО',
			--		 'Стандарт 2.1М_1',
			--		 'Стандарт 1М_3 ФО',
			--		 'ЕП Стандарт 1М_3 ФО',
			--		 'Стандарт 2М_1 ФО',
			--		 'ЕП Стандарт 2М_1 ФО',
			--		 'Стандарт 2М_2 ФО',
			--		 'ЕП Стандарт 2М_2 ФО')
	)as Tariff 
		on Tariff.ProductGid = MP.gid 
INNER JOIN OrantaSch.dbo.CommissionToPrograms AS C ON C.ProgramGID = MPG.gid AND C.Deleted	=0
INNER JOIN OrantaSch.dbo.Commissions AS CV ON CV.gid = C.CommissionGID AND CV.Deleted =0 AND CV.CommissionTypeGID='8CC6A11E-9E88-48A3-9C8C-3F3EC92E16AD'
INNER JOIN Metis.dbo.Faces AS F ON F.gid = CV.AgentGID
WHERE P.Deleted = 0
	AND P.BeginingDate	>= 20211101
  AND P.BeginingDate < 20211201
order by P.PolisNumber, P.BeginingDate asc