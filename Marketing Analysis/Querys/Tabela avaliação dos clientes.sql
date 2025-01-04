SELECT [ReviewID] -- identificador unico para o review
      ,[CustomerID] -- identificador do cliente
      ,[ProductID] -- identificador do produto
      ,[ReviewDate] -- data do review
      ,[Rating] -- classificador numerico
      ,REPLACE(ReviewText,'  ',' ') AS ReviewText -- substitui espaços duplos no texto por espaço simples
  FROM [PortfolioProject_MarketingAnalytics].[dbo].[customer_reviews]
