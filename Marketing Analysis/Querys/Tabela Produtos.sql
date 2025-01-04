SELECT 
	  [ProductID], -- seleciona um identificador para cada produto
      [ProductName], -- seleciona o nome do produto 
      --[Category] -- seleciona as categorias correspondentes de cada produto
      [Price], -- seleciona os pre�os para cada produto

	CASE -- categoriza os produtos de acordo com o seu pre�o em: baixo, m�dio e alto
		WHEN Price < 50 THEN 'Baixo'
		WHEN Price BETWEEN 50 AND 200 THEN 'M�dio'
		ELSE 'Alto'
	END AS Categoria_de_preco
	
  FROM [PortfolioProject_MarketingAnalytics].[dbo].[products]
