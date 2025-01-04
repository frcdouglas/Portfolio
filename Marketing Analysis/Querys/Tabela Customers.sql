SELECT 
	c.CustomerID, -- seleciona identificador para o cliente
	c.CustomerName, -- seleciona o nome do cliente
	c.Age, -- seleciona a idade
	c.Gender, -- seleciona o genero
	c.Email, -- seleciona o email
	g.City, -- seleciona a sua cidade a partir da tabela geography
	g.Country -- seleciona o seu país a partir da tabela geography 

FROM
	[PortfolioProject_MarketingAnalytics].dbo.customers as c
	LEFT JOIN
	[PortfolioProject_MarketingAnalytics].dbo.geography as g
ON c.GeographyID = g.GeographyID;