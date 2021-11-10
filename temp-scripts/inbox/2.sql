
select 
Cs.*
from dbo.Calculations as C
inner join meta.CalculationTypes as CT on CT.gid = C.CalculationTypeGID
inner join dbo.Documents as D on D.gid = C.gid
inner join dbo.CasesDocuments as CD on CD.DocumentGID = D.gid
inner join dbo.Cases as Cs on Cs.gid = CD.CaseGID
inner join log.Calculations as L on L.LoggedEntityGID = C.gid
where Cs.Number like '21-23-41'

