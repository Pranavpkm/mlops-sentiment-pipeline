# MLOps Sentiment Analysis Pipeline

I built this to learn how AI services actually get 
deployed in production. Not just training a model 
and stopping there — but the whole thing. API, 
containers, Kubernetes, infrastructure as code, 
CI/CD. The works.

The idea is simple — you send text, it tells you 
if it's positive, negative, neutral, or mixed. 
Behind that simple idea is a full production setup.



## What problem does this solve?

Imagine you run a company and get thousands of 
customer reviews every day. You can't read all of 
them manually. You need something that reads them 
automatically and tells you which ones are angry, 
which ones are happy, and which ones need attention.

That's this.



## How it works

You send: {"text": "I love this product!"}
              ↓
FastAPI receives it
              ↓
Sends to Amazon Comprehend (AWS AI service)
              ↓
Comprehend analyzes it
              ↓
Returns: POSITIVE — 99.8% confidence

No model training needed. Amazon already trained 
Comprehend on billions of text samples. I just 
built the infrastructure around it.

---

## What I actually built

app/main.py          → FastAPI app with 3 endpoints
Dockerfile           → packages everything into a container
terraform/main.tf    → provisions AWS infrastructure as code
kubernetes/          → runs the app on Kubernetes
.github/workflows/   → auto deploys on every git push

---

## Tech stack

- FastAPI — Python web framework for the API
- Amazon Comprehend — AWS AI service for sentiment analysis
- Docker — containerizes the app
- AWS ECR — stores the Docker image
- Kubernetes — runs 2 pods with health checks and auto restart
- Terraform — creates AWS infrastructure with code not clicks
- GitHub Actions — builds and deploys automatically on push

---

## Try it yourself

Send a positive message:

curl -X POST http://YOUR_URL/analyze \
  -H "Content-Type: application/json" \
  -d '{"text": "I love building on AWS!"}'

Response:

{
  "text": "I love building on AWS!",
  "sentiment": "POSITIVE",
  "scores": {
    "Positive": 0.998,
    "Negative": 0.0002,
    "Neutral": 0.001,
    "Mixed": 0.0001
  }
}

Send a negative one and watch the scores flip.



## What I learned

- How to wrap an AI service in a real API
- How Terraform provisions infrastructure 
  without touching the AWS console
- How Kubernetes manages containers, 
  restarts failures, and runs health checks
- How to store secrets properly in Kubernetes 
  instead of hardcoding credentials
- How CI/CD connects everything so a git push 
  triggers the whole pipeline automatically



## Endpoints

GET  /         → confirms app is running
GET  /health   → Kubernetes uses this to check pod health
POST /analyze  → send text, get sentiment back

---

## Project structure

mlops-sentiment-pipeline/
├── app/
│   └── main.py          
├── terraform/
│   └── main.tf          
├── kubernetes/
│   └── deployment.yaml  
├── .github/
│   └── workflows/
│       └── deploy.yml   
├── Dockerfile           
└── requirements.txt     

---

## GitHub

github.com/Pranavpkm/mlops-sentiment-pipeline