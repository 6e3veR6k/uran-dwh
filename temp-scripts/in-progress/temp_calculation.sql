select distinct CalculationTypeGID
from dbo.Calculations as C


select *
from meta.CalculationTypes
where gid in (select distinct CalculationTypeGID
from dbo.Calculations as C
)