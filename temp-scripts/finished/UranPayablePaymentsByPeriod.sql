DECLARE @LastExecutionDateTime DATETIME2 = ?;
DECLARE @CurentExecutionDateTime DATETIME2 = ?;


SELECT MainData.id,
       MainData.gid,
       MainData.PayableGID,
       MainData.PayableDetailGID,
       MainData.Amount,
       MainData.CompensationAmount,
       MainData.CompensationDate,
       MainData.PaymentNumber,
       MainData.OrderNumber,
       MainData.RefusalReason,
       MainData.ReportDate,
       MainData.PaymentID,
       MainData.CreateDate,
       MainData.AuthorGID,
       MainData.PaymentPeriodGID,
       MainData.LogCreateDate,
       MainData.LogActionDate,
       MainData.SourceIdentity,
       MainData.LoadDatetime
FROM
(
    SELECT src.id,
           src.gid,
           src.PayableGID,
           src.PayableDetailGID,
           src.Amount,
           src.CompensationAmount,
           src.CompensationDate,
           src.PaymentNumber,
           src.OrderNumber,
           src.RefusalReason,
           src.ReportDate,
           src.PaymentID,
           src.CreateDate,
           src.AuthorGID,
           src.PaymentPeriodGID,
           COALESCE(lg.[_CreateDate], CONVERT(DATETIME, '20100101', 112)) AS [LogCreateDate],
           COALESCE(lg.[_ActionDate], CONVERT(DATETIME, '20100101', 112)) AS [LogActionDate],
           @@SERVERNAME AS SourceIdentity,
           CURRENT_TIMESTAMP AS LoadDatetime
    FROM dbo.PayablePayments AS src
    OUTER APPLY
    (
        SELECT MIN(L.ActionDate) AS [_CreateDate],
               MAX(L.ActionDate) AS [_ActionDate]
        FROM log.PayablePayments AS L
        WHERE L.LoggedEntityGID = src.gid
        GROUP BY L.LoggedEntityGID
    ) AS lg
) AS MainData
WHERE MainData.[LogCreateDate] > @LastExecutionDateTime
      AND MainData.[LogActionDate] <= @CurentExecutionDateTime
