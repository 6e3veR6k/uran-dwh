-- DECLARE @LastExecutionDateTime DATETIME2 = ?;
-- DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.gid,
       MainData.Name,
       MainData.id,
       MainData.AuthorGID,
       MainData.PersonTypeID,
       MainData.FullNameEnglish,
       MainData.IdentificationCode,
       MainData.Profession,
       MainData.Address,
       MainData.ActualAddress,
       MainData.PhoneNumber,
       MainData.Fax,
       MainData.AdditionalContactInfo,
       MainData.Email,
       MainData.PostAddressGID,
       MainData.PostActualAddressGID,
       MainData.ActivityGID,
       MainData.WebAddress,
       MainData.PhoneNumberAdditional,
       MainData.MobilePhoneNumber,
       MainData.HomePhoneNumber,
       MainData.WorkPhoneNumber,
       MainData.FullName,
       MainData.ParentGID,
       MainData.EDRPOU,
       MainData.IsResponsible,
       MainData.Firstname,
       MainData.Secondname,
       MainData.Lastname,
       MainData.IsMan,
       MainData.Birthdate,
       MainData.DriverFrom,
       MainData.GenitiveName,
       MainData.GenitivePost,
       MainData.Post,
       MainData.FaceID,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.gid,
           src.Name,
           src.id,
           src.AuthorGID,
           src.PersonTypeID,
           src.FullNameEnglish,
           src.IdentificationCode,
           src.Profession,
           src.Address,
           src.ActualAddress,
           src.PhoneNumber,
           src.Fax,
           src.AdditionalContactInfo,
           src.Email,
           src.PostAddressGID,
           src.PostActualAddressGID,
           src.ActivityGID,
           src.WebAddress,
           src.PhoneNumberAdditional,
           src.MobilePhoneNumber,
           src.HomePhoneNumber,
           src.WorkPhoneNumber,
           src.FullName,
           src.ParentGID,
           src.EDRPOU,
           src.IsResponsible,
           src.Firstname,
           src.Secondname,
           src.Lastname,
           src.IsMan,
           src.Birthdate,
           src.DriverFrom,
           src.GenitiveName,
           src.GenitivePost,
           src.Post,
           src.FaceID,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.Faces AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.Faces AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime
