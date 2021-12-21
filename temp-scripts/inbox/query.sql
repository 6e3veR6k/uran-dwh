	SELECT
		Pay.id AS PayablePaymentsId,
		Pay.PaymentNumber,
		B.BranchCode AS BranchCode,
		B.Name AS BranchName,
		C.Number AS CaseNumber,
		NULL AS IsDirectSettlement,
		D.Number AS PaymentActNumber,
		P.ActSignDate AS PaymentActSignDate,
		Pay.CompensationAmount AS CompensationAmount,
		Acts.SummAllActs AS CaseSumActsValues,
		P.DateTransferToAccounting AS AccountingTransferDate,
		Pay.CompensationDate AS CompensationDate,
		Pay.Amount AS PaymentValue,
		Prd.InsuredName AS InsuredName,
		Prd.Phone AS InsuredPhoneNumber,
		Prd.VictimName AS VictimName,
		Prd.VictimPhone AS VictimPhoneNumber,
		PD.RecipientName AS RecipientName,
		T.Name AS PaymentType,
		PD.RecipientIdentificationCode AS RecipientFaceID,
		PD.BankAccount AS RecipientBankAccountNumber,
		PD.PersonalAccount AS RecipientPersonalCardNumber,
		PD.RecipientBankName AS RecipientBankName,
		PD.PaymentPurpose AS RecipientPaymentPurpose
	FROM [Oberon].[dbo].[PayablePayments] AS Pay
	INNER JOIN Oberon.dbo.PayableDetails AS PD ON PD.gid = Pay.PayableDetailGID
	INNER JOIN Oberon.meta.PaymentTypes AS T ON T.gid = PD.PaymentTypeGID
	INNER JOIN Oberon.dbo.Payables AS P ON P.gid = Pay.PayableGID
	INNER JOIN Oberon.dbo.Documents AS D ON D.gid = P.gid AND D.Deleted = 0
	INNER JOIN Oberon.dbo.CasesDocuments AS CD ON CD.DocumentGID = D.gid AND CD.Deleted = 0
	LEFT JOIN (
	SELECT SUM(P.Amount) AS SummAllActs, CD.CaseGID
	FROM Oberon.dbo.Payables AS P
	INNER JOIN Oberon.dbo.Documents AS D ON D.gid = P.gid AND D.Deleted = 0
	INNER JOIN Oberon.dbo.CasesDocuments AS CD ON CD.DocumentGID = D.gid AND CD.Deleted = 0
	WHERE P.Deleted	= 0
	GROUP BY CD.CaseGID
	) AS Acts
		ON Acts.CaseGID = CD.CaseGID
	INNER JOIN Oberon.dbo.Cases AS C ON C.gid = CD.CaseGID AND C.Deleted = 0
	INNER JOIN Oberon.dbo.Branches AS B ON B.gid = C.BranchGID
	LEFT JOIN (
	SELECT
		COALESCE(
					NULLIF(TRIM(F.FullName), ''),
					COALESCE(F.Lastname, '') + ' ' + COALESCE(F.Firstname, '') + ' ' + COALESCE(F.Secondname, '')
				) AS InsuredName,
		COALESCE(NULLIF(F.MobilePhoneNumber, ''), NULLIF(F.PhoneNumber, ''), NULLIF(F.PhoneNumberAdditional, ''),  NULLIF(F.HomePhoneNumber, ''), NULLIF(F.WorkPhoneNumber, '')) AS Phone,
		COALESCE(
					NULLIF(TRIM(F2.FullName), ''),
					COALESCE(F2.Lastname, '') + ' ' + COALESCE(F2.Firstname, '') + ' ' + COALESCE(F2.Secondname, '')
				) AS VictimName,
		COALESCE(NULLIF(F2.MobilePhoneNumber, ''), NULLIF(F2.PhoneNumber, ''), NULLIF(F2.PhoneNumberAdditional, ''),  NULLIF(F2.HomePhoneNumber, ''), NULLIF(F2.WorkPhoneNumber, '')) AS VictimPhone,
		cD.CaseGID
	FROM Oberon.dbo.CasesDocuments AS cD
	INNER JOIN Oberon.dbo.Claims AS CL ON CL.gid = cD.DocumentGID
	INNER JOIN Oberon.dbo.Signers AS S ON S.gid = CL.InsurerGID
	INNER JOIN Oberon.dbo.Faces AS F ON F.gid = S.FaceGID	
	LEFT JOIN Oberon.dbo.ClaimParticipants AS Vic ON Vic.ClaimGID = Cl.gid AND Vic.Deleted = 0 AND EXISTS (SELECT 1 FROM Oberon.meta.ParticipantTypes AS T WHERE T.gid = Vic.TypeGid AND T.Name = 'Потерпілий')
	LEFT JOIN Oberon.dbo.Faces AS F2 ON F.gid = Vic.ObjectGID
	) AS Prd
		ON Prd.CaseGID = cd.CaseGID
	WHERE P.Deleted	= 0