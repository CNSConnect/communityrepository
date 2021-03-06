SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[sp_Suggestion_l] (
	@ShowCompleted bit = 0
)
AS BEGIN

SET NOCOUNT ON

SELECT UserName, s.*
FROM Suggestion s
INNER JOIN Users u
	ON s.User_ID=u.User_ID
WHERE @ShowCompleted = 1 OR s.COMPLETED_DATE IS NULL
ORDER BY CASE WHEN s.COMPLETED_DATE IS NULL THEN 0 ELSE 1 END, s.CREATED_DATE

IF @ShowCompleted=0 BEGIN
	SELECT COUNT(*) AS cnt FROM Suggestion
	WHERE COMPLETED_DATE IS NOT NULL
END

SET NOCOUNT OFF

END






GO
GRANT EXECUTE ON  [dbo].[sp_Suggestion_l] TO [web_user]
GO
