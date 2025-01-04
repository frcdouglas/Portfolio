-- Verificando se existem linhas duplicadas na tabela
WITH DuplicateRecords AS(
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		ROW_NUMBER() OVER(
			PARTITION BY CustomerID, ProductID, VisitDate, Action
			ORDER BY JourneyID
		) AS row_num
	FROM dbo.customer_journey
)

SELECT * 
FROM DuplicateRecords
WHERE row_num > 1
ORDER BY JourneyID

-- ***********************************************************************************************************************************

-- Seleciona apenas as linhas que não são duplicadas e preenche os campos NULL da coluna Duration com a média dos valores do mesmo dia
SELECT 
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE(Duration, avg_duration, global_avg_duration) AS Duration
FROM (
	--subquery para processar e limpar os dados
	SELECT 
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		UPPER(Stage) AS Stage, -- converte para maiusculo os valores de stage para consistencia nas analises
		Action,
		Duration,
		AVG(Duration) OVER(PARTITION BY VisitDate) AS avg_duration,
		AVG(Duration) OVER() AS global_avg_duration, -- Média global,
		ROW_NUMBER() OVER(
			PARTITION BY CustomerID, ProductID, VisitDate,UPPER(Stage), Action -- contagem de linhas por combinações unicas
			ORDER BY JourneyID
		) AS row_num
	FROM 
		[PortfolioProject_MarketingAnalytics].dbo.customer_journey
) AS subquery

WHERE 
	row_num = 1; -- mantem apenas as colunas que possuem 1 combinação unica

