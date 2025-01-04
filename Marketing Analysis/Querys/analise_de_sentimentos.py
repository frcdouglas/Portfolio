import pandas as pd
import nltk
from nltk.sentiment import SentimentIntensityAnalyzer

# baixando a ferramenta VADER para realizar a analise
nltk.download('vader_lexicon')

# acessando a base de dados extraida em .csv
df = pd.read_csv("tabela_avaliacao.csv", delimiter=";", encoding="utf-8")


def calculate_sentiment(review):

    # simplificando a biblioteca SentimentIntensityAnalyzer
    sia = SentimentIntensityAnalyzer()
    # analisando o texto
    sentiment_score = sia.polarity_scores(review)
    return sentiment_score['compound']


def categorize_sentiment(rating_value, sentiment_score):
    if sentiment_score > 0.05:
        if rating_value > 3:
            return 'Positivo'
        elif rating_value == 3:
            return 'Misto positivo'
        else:
            return 'Misto negativo'
    elif sentiment_score < -0.05:
        if rating_value > 3:
            return 'Misto positivo'
        elif rating_value == 3:
            return 'Misto Negativo'
        else:
            return 'Negativo'
    else:
        if rating_value > 3:
            return 'Positivo'
        elif rating_value == 3:
            return 'Neutro'
        else:
            return 'Negativo'


def sentiment_bucket(score):
    if score >= 0.5:
        return '0.5 ate 1.0'
    elif 0.0 <= score < 0.5:
        return '0.0 ate 0.49'
    elif -0.5 <= score < 0.0:
        return '-0.5 ate 0.0'
    else:
        return '-1.0 ate -0.5'


# cria a coluna SentimentScore utilizando a função calculate_sentiment usando como base a coluna ReviewText
df['SentimentScore'] = df['ReviewText'].apply(calculate_sentiment)

# cria a coluna SentimentCategory utilizando a função categorize_sentiment que recebe como parametros a coluna Rating
# e a coluna SentimentScore calculada anteriormente
df['SentimentCategory'] = df.apply(lambda row: categorize_sentiment(row['Rating'], row['SentimentScore']), axis=1)

# criar a coluna intervalo_sentimento baseada nos intervalos da função
df['SentimentBucket'] = df['SentimentScore'].apply(sentiment_bucket)

print(df.head())

# salva as alterações realizadas e as colunas criadas em um novo arquivo
df.to_csv('tavela_avaliacao_com_sentimentos.csv', index=False)
