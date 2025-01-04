SELECT [EngagementID]
      ,[ContentID]
      ,[ProductID]
      ,[CampaignID]
	  ,UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType -- substitui Socialmedia por Social Media
	  ,LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined)-1) AS Views -- Extrai o número de visualizações dee ViewsClicksCombined
	  ,RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Cliques -- Extrai o numero de cliques de ViewsClicksCombined
      ,[Likes]
	  ,FORMAT (CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate -- convertendo o formato de data para dd.mm.yyyy
  FROM 
	[PortfolioProject_MarketingAnalytics].[dbo].[engagement_data]
  WHERE
	ContentType != 'Newsletter'; -- Filtra a coluna por valores que não sejam Newsletter por ser irrelevante para nossa analise