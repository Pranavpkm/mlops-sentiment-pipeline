from fastapi import FastAPI
from pydantic import BaseModel
import boto3
import json

app = FastAPI()

comprehend = boto3.client('comprehend', region_name='us-east-1')

class TextInput(BaseModel):
    text: str

@app.get('/')
def home():
    return {'message': 'Sentiment Analysis API is running!'}

@app.get('/health')
def health():
    return {'status': 'healthy'}

@app.post('/analyze')
def analyze_sentiment(input: TextInput):
    response = comprehend.detect_sentiment(
        Text=input.text,
        LanguageCode='en'
    )
    return {
        'text': input.text,
        'sentiment': response['Sentiment'],
        'scores': response['SentimentScore']
    }