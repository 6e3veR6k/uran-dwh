declare @date dateTime = getdate()
EXEC [dbo].[sp_GetReservationsOnDate] @UserGid = NULL, @OnDate = @date

exec sp_describe_first_result_set N'[dbo].[sp_GetReservationsOnDate]'
