-- Oberon
declare @RetensionLimit decimal(18, 2) = 1500000.00;
declare @Scope nvarchar(500) = 'КАСКО';

update src
set RetentionLimit = @RetensionLimit
from Oberon.meta.ProgramTypeToClaimTypes as src
inner join Himalia.meta.ProgramTypes as PT on src.ProgramTypeGID = PT.gid
inner join Oberon.meta.ClaimTypes as CP on CP.gid = src.ClaimTypeGID
where CP.Name = @Scope


select src.*
from Oberon.meta.ProgramTypeToClaimTypes as src
inner join Himalia.meta.ProgramTypes as PT on src.ProgramTypeGID = PT.gid
inner join Oberon.meta.ClaimTypes as CP on CP.gid = src.ClaimTypeGID
where CP.Name = @Scope