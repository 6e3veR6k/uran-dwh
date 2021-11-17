DECLARE @LastExecutionDateTime DATETIME2 = ?;
DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.gid,
       MainData.RegistrationNumber,
       MainData.id,
       MainData.AuthorGID,
       MainData.ModelGID,
       MainData.ManufacturerGID,
       MainData.ColorGID,
       MainData.ColorTypeGID,
       MainData.OwnerGID,
       MainData.BodyNumber,
       MainData.ProducedDate,
       MainData.RegistrationCertificate,
       MainData.RegistrationDate,
       MainData.Cost,
       MainData.NumberOfSeats,
       MainData.AnticreepDevice,
       MainData.AdditionalEquipment,
       MainData.AuthorizedToManage,
       MainData.SpecialConditions,
       MainData.RegistrationPlace,
       MainData.Mileage,
       MainData.Capacity,
       MainData.TechDocModel,
       MainData.SettlementGID,
       MainData.BodyTypeGID,
       MainData.EngineTypeGID,
       MainData.TransmissionTypeGID,
       MainData.TypeGID,
       MainData.EngineNumber,
       MainData.ChasisNumber,
       MainData.PostAddressGID,
       MainData.Address,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.gid,
           src.RegistrationNumber,
           src.id,
           src.AuthorGID,
           src.ModelGID,
           src.ManufacturerGID,
           src.ColorGID,
           src.ColorTypeGID,
           src.OwnerGID,
           src.BodyNumber,
           src.ProducedDate,
           src.RegistrationCertificate,
           src.RegistrationDate,
           src.Cost,
           src.NumberOfSeats,
           src.AnticreepDevice,
           src.AdditionalEquipment,
           src.AuthorizedToManage,
           src.SpecialConditions,
           src.RegistrationPlace,
           src.Mileage,
           src.Capacity,
           src.TechDocModel,
           src.SettlementGID,
           src.BodyTypeGID,
           src.EngineTypeGID,
           src.TransmissionTypeGID,
           src.TypeGID,
           src.EngineNumber,
           src.ChasisNumber,
           src.PostAddressGID,
           src.Address,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.Vehicles AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.Vehicles AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime

