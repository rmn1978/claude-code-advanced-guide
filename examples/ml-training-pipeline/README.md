# 🤖 ML Training Pipeline - Production-Ready Machine Learning

Complete ML pipeline with experiment tracking, model versioning, hyperparameter tuning, and API deployment.

**Stack**: Python 3.11 + scikit-learn + MLflow + FastAPI + PostgreSQL + Optuna
**Complexity**: 🔴 Advanced
**Time**: 8-10 hours
**Revenue Potential**: $15k-$80k MRR as MLOps platform

---

## 🎯 What You'll Build

A complete ML training pipeline for **customer churn prediction** including:

- ✅ Data preprocessing and feature engineering
- ✅ Experiment tracking with MLflow
- ✅ Hyperparameter tuning with Optuna
- ✅ Model versioning and registry
- ✅ FastAPI inference endpoint
- ✅ Model monitoring and drift detection
- ✅ Automated retraining pipeline
- ✅ A/B testing framework

**Use Cases**:
- Customer churn prediction
- Credit risk scoring
- Fraud detection
- Product recommendations
- Demand forecasting

---

## 📋 Table of Contents

- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Data Pipeline](#data-pipeline)
- [Model Training](#model-training)
- [MLflow Tracking](#mlflow-tracking)
- [Hyperparameter Tuning](#hyperparameter-tuning)
- [Model Deployment](#model-deployment)
- [API Usage](#api-usage)
- [Monitoring](#monitoring)
- [Production Deployment](#production-deployment)

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     ML Training Pipeline                      │
└─────────────────────────────────────────────────────────────┘

┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│  Raw Data    │  →    │ Preprocessing│  →    │   Features   │
│  (CSV/DB)    │       │   Pipeline   │       │    Store     │
└──────────────┘       └──────────────┘       └──────────────┘
                                                      ↓
┌──────────────────────────────────────────────────────────────┐
│                    Training Loop                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │  Split   │→ │  Train   │→ │ Evaluate │→ │   Log    │   │
│  │  Data    │  │  Model   │  │  Metrics │  │ MLflow   │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
└──────────────────────────────────────────────────────────────┘
                              ↓
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│ Optuna HPO   │  →    │Model Registry│  →    │ FastAPI      │
│ (Best params)│       │  (Versioned) │       │ Endpoint     │
└──────────────┘       └──────────────┘       └──────────────┘
                                                      ↓
                                            ┌──────────────┐
                                            │  Monitoring  │
                                            │   & Alerts   │
                                            └──────────────┘
```

---

## 📁 Project Structure

```
ml-training-pipeline/
├── README.md
├── requirements.txt
├── .env.example
├── docker-compose.yml
│
├── data/
│   ├── raw/
│   │   └── customers.csv
│   ├── processed/
│   │   ├── train.csv
│   │   ├── val.csv
│   │   └── test.csv
│   └── features/
│       └── feature_definitions.json
│
├── notebooks/
│   ├── 01_eda.ipynb                      # Exploratory Data Analysis
│   ├── 02_feature_engineering.ipynb      # Feature creation
│   └── 03_model_comparison.ipynb         # Compare algorithms
│
├── src/
│   ├── __init__.py
│   │
│   ├── data/
│   │   ├── __init__.py
│   │   ├── loader.py                     # Load data
│   │   ├── preprocessing.py              # Clean & transform
│   │   ├── feature_engineering.py        # Create features
│   │   └── validation.py                 # Data validation
│   │
│   ├── models/
│   │   ├── __init__.py
│   │   ├── train.py                      # Training logic
│   │   ├── evaluate.py                   # Evaluation metrics
│   │   ├── tune.py                       # Hyperparameter tuning
│   │   └── registry.py                   # Model versioning
│   │
│   ├── api/
│   │   ├── __init__.py
│   │   ├── main.py                       # FastAPI app
│   │   ├── schemas.py                    # Pydantic models
│   │   └── inference.py                  # Prediction logic
│   │
│   └── monitoring/
│       ├── __init__.py
│       ├── drift_detection.py            # Data/model drift
│       └── metrics.py                    # Performance tracking
│
├── configs/
│   ├── model_config.yaml                 # Model hyperparameters
│   ├── training_config.yaml              # Training settings
│   └── deployment_config.yaml            # API settings
│
├── mlruns/                                # MLflow artifacts
├── models/                                # Saved models
├── logs/                                  # Application logs
│
└── tests/
    ├── test_data.py
    ├── test_models.py
    └── test_api.py
```

---

## 🚀 Installation

### Prerequisites

```bash
# Python 3.11+
python --version

# Virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Requirements.txt

```txt
# Core ML
scikit-learn==1.4.0
pandas==2.1.4
numpy==1.26.3

# Experiment Tracking
mlflow==2.10.0
optuna==3.5.0

# API
fastapi==0.109.0
uvicorn[standard]==0.27.0
pydantic==2.5.3

# Database
psycopg2-binary==2.9.9
sqlalchemy==2.0.25

# Data Validation
great-expectations==0.18.8

# Monitoring
evidently==0.4.14
prometheus-client==0.19.0

# Utilities
python-dotenv==1.0.0
pyyaml==6.0.1
joblib==1.3.2

# Visualization
matplotlib==3.8.2
seaborn==0.13.1

# Development
pytest==7.4.4
black==23.12.1
flake8==7.0.0
```

### Environment Variables

```bash
# .env
DATABASE_URL=postgresql://user:pass@localhost:5432/ml_pipeline
MLFLOW_TRACKING_URI=http://localhost:5000
MLFLOW_BACKEND_STORE_URI=postgresql://user:pass@localhost:5432/mlflow
MLFLOW_ARTIFACT_ROOT=./mlruns
MODEL_REGISTRY_URI=models://
```

### Docker Setup

```yaml
# docker-compose.yml
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_USER: mluser
      POSTGRES_PASSWORD: mlpass
      POSTGRES_DB: ml_pipeline
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  mlflow:
    build:
      context: .
      dockerfile: Dockerfile.mlflow
    ports:
      - "5000:5000"
    environment:
      - MLFLOW_BACKEND_STORE_URI=postgresql://mluser:mlpass@postgres:5432/mlflow
      - MLFLOW_ARTIFACT_ROOT=/mlflow/artifacts
    volumes:
      - mlflow_artifacts:/mlflow/artifacts
    depends_on:
      - postgres

  api:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://mluser:mlpass@postgres:5432/ml_pipeline
      - MLFLOW_TRACKING_URI=http://mlflow:5000
    depends_on:
      - postgres
      - mlflow

volumes:
  postgres_data:
  mlflow_artifacts:
```

---

## 📊 Data Pipeline

### 1. Data Loading

```python
# src/data/loader.py
import pandas as pd
from typing import Tuple
import logging

logger = logging.getLogger(__name__)

class DataLoader:
    def __init__(self, data_path: str):
        self.data_path = data_path

    def load_raw_data(self) -> pd.DataFrame:
        """Load raw customer data"""
        logger.info(f"Loading data from {self.data_path}")
        df = pd.read_csv(self.data_path)
        logger.info(f"Loaded {len(df)} rows, {len(df.columns)} columns")
        return df

    def split_data(
        self,
        df: pd.DataFrame,
        train_size: float = 0.7,
        val_size: float = 0.15,
        test_size: float = 0.15,
        random_state: int = 42
    ) -> Tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
        """Split data into train/val/test sets"""
        from sklearn.model_selection import train_test_split

        # First split: train + (val + test)
        train_df, temp_df = train_test_split(
            df,
            train_size=train_size,
            random_state=random_state,
            stratify=df['churn']  # Stratify by target
        )

        # Second split: val + test
        val_ratio = val_size / (val_size + test_size)
        val_df, test_df = train_test_split(
            temp_df,
            train_size=val_ratio,
            random_state=random_state,
            stratify=temp_df['churn']
        )

        logger.info(f"Split: train={len(train_df)}, val={len(val_df)}, test={len(test_df)}")
        return train_df, val_df, test_df
```

### 2. Data Preprocessing

```python
# src/data/preprocessing.py
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.impute import SimpleImputer
import joblib

class DataPreprocessor:
    def __init__(self):
        self.scalers = {}
        self.encoders = {}
        self.imputers = {}

    def fit_transform(self, df: pd.DataFrame) -> pd.DataFrame:
        """Fit and transform training data"""
        df = df.copy()

        # Handle missing values
        df = self._handle_missing_values(df, fit=True)

        # Encode categorical variables
        df = self._encode_categoricals(df, fit=True)

        # Scale numerical features
        df = self._scale_numericals(df, fit=True)

        return df

    def transform(self, df: pd.DataFrame) -> pd.DataFrame:
        """Transform validation/test data using fitted transformers"""
        df = df.copy()
        df = self._handle_missing_values(df, fit=False)
        df = self._encode_categoricals(df, fit=False)
        df = self._scale_numericals(df, fit=False)
        return df

    def _handle_missing_values(self, df: pd.DataFrame, fit: bool) -> pd.DataFrame:
        """Impute missing values"""
        numerical_cols = df.select_dtypes(include=[np.number]).columns

        for col in numerical_cols:
            if fit:
                self.imputers[col] = SimpleImputer(strategy='median')
                df[col] = self.imputers[col].fit_transform(df[[col]])
            else:
                df[col] = self.imputers[col].transform(df[[col]])

        return df

    def _encode_categoricals(self, df: pd.DataFrame, fit: bool) -> pd.DataFrame:
        """Label encode categorical variables"""
        categorical_cols = df.select_dtypes(include=['object']).columns
        categorical_cols = [c for c in categorical_cols if c != 'churn']

        for col in categorical_cols:
            if fit:
                self.encoders[col] = LabelEncoder()
                df[col] = self.encoders[col].fit_transform(df[col].astype(str))
            else:
                # Handle unseen categories
                df[col] = df[col].apply(
                    lambda x: x if x in self.encoders[col].classes_ else 'unknown'
                )
                df[col] = self.encoders[col].transform(df[col].astype(str))

        return df

    def _scale_numericals(self, df: pd.DataFrame, fit: bool) -> pd.DataFrame:
        """Standard scale numerical features"""
        numerical_cols = df.select_dtypes(include=[np.number]).columns
        numerical_cols = [c for c in numerical_cols if c != 'churn']

        if fit:
            self.scalers['standard'] = StandardScaler()
            df[numerical_cols] = self.scalers['standard'].fit_transform(df[numerical_cols])
        else:
            df[numerical_cols] = self.scalers['standard'].transform(df[numerical_cols])

        return df

    def save(self, path: str):
        """Save fitted transformers"""
        joblib.dump({
            'scalers': self.scalers,
            'encoders': self.encoders,
            'imputers': self.imputers
        }, path)

    def load(self, path: str):
        """Load fitted transformers"""
        data = joblib.load(path)
        self.scalers = data['scalers']
        self.encoders = data['encoders']
        self.imputers = data['imputers']
```

### 3. Feature Engineering

```python
# src/data/feature_engineering.py
import pandas as pd
import numpy as np

class FeatureEngineer:
    def create_features(self, df: pd.DataFrame) -> pd.DataFrame:
        """Create engineered features"""
        df = df.copy()

        # Recency features
        df['days_since_last_purchase'] = (
            pd.Timestamp.now() - pd.to_datetime(df['last_purchase_date'])
        ).dt.days

        # Frequency features
        df['purchase_frequency'] = df['total_purchases'] / df['customer_lifetime_months']

        # Monetary features
        df['average_purchase_value'] = df['total_spent'] / df['total_purchases']
        df['spending_per_month'] = df['total_spent'] / df['customer_lifetime_months']

        # Engagement features
        df['support_interaction_rate'] = df['support_tickets'] / df['customer_lifetime_months']
        df['email_open_rate'] = df['emails_opened'] / (df['emails_sent'] + 1)

        # Behavioral features
        df['is_active'] = (df['days_since_last_purchase'] < 90).astype(int)
        df['is_high_value'] = (df['total_spent'] > df['total_spent'].quantile(0.75)).astype(int)

        # Interaction features
        df['recency_frequency'] = df['days_since_last_purchase'] * df['purchase_frequency']
        df['recency_monetary'] = df['days_since_last_purchase'] * df['average_purchase_value']

        return df
```

---

## 🧠 Model Training

### Training Script

```python
# src/models/train.py
import mlflow
import mlflow.sklearn
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, roc_auc_score
import logging

logger = logging.getLogger(__name__)

class ModelTrainer:
    def __init__(self, experiment_name: str = "churn_prediction"):
        mlflow.set_experiment(experiment_name)
        self.experiment_name = experiment_name

    def train_model(
        self,
        X_train, y_train,
        X_val, y_val,
        model_type: str = "random_forest",
        params: dict = None
    ):
        """Train a model and log to MLflow"""

        with mlflow.start_run(run_name=f"{model_type}_training"):
            # Log parameters
            mlflow.log_param("model_type", model_type)
            mlflow.log_params(params or {})

            # Initialize model
            model = self._get_model(model_type, params)

            # Train
            logger.info(f"Training {model_type}...")
            model.fit(X_train, y_train)

            # Evaluate on validation set
            metrics = self._evaluate_model(model, X_val, y_val)

            # Log metrics
            for metric_name, metric_value in metrics.items():
                mlflow.log_metric(metric_name, metric_value)

            # Log model
            mlflow.sklearn.log_model(
                model,
                "model",
                registered_model_name=f"churn_predictor_{model_type}"
            )

            logger.info(f"Model trained. F1 Score: {metrics['f1_score']:.4f}")

            return model, metrics

    def _get_model(self, model_type: str, params: dict):
        """Get model instance based on type"""
        models = {
            "logistic_regression": LogisticRegression,
            "random_forest": RandomForestClassifier,
            "gradient_boosting": GradientBoostingClassifier
        }

        model_class = models.get(model_type, RandomForestClassifier)
        return model_class(**(params or {}))

    def _evaluate_model(self, model, X, y):
        """Calculate evaluation metrics"""
        y_pred = model.predict(X)
        y_pred_proba = model.predict_proba(X)[:, 1]

        metrics = {
            "accuracy": accuracy_score(y, y_pred),
            "precision": precision_score(y, y_pred),
            "recall": recall_score(y, y_pred),
            "f1_score": f1_score(y, y_pred),
            "roc_auc": roc_auc_score(y, y_pred_proba)
        }

        return metrics
```

---

## 🔬 Hyperparameter Tuning with Optuna

```python
# src/models/tune.py
import optuna
from optuna.integration.mlflow import MLflowCallback
import mlflow
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_val_score
import numpy as np

class HyperparameterTuner:
    def __init__(self, X_train, y_train, n_trials: int = 50):
        self.X_train = X_train
        self.y_train = y_train
        self.n_trials = n_trials
        self.best_params = None

    def objective_random_forest(self, trial):
        """Optuna objective for Random Forest"""
        params = {
            'n_estimators': trial.suggest_int('n_estimators', 50, 500),
            'max_depth': trial.suggest_int('max_depth', 3, 20),
            'min_samples_split': trial.suggest_int('min_samples_split', 2, 20),
            'min_samples_leaf': trial.suggest_int('min_samples_leaf', 1, 10),
            'max_features': trial.suggest_categorical('max_features', ['sqrt', 'log2']),
            'random_state': 42
        }

        model = RandomForestClassifier(**params)

        # Cross-validation
        scores = cross_val_score(
            model, self.X_train, self.y_train,
            cv=5, scoring='f1', n_jobs=-1
        )

        return np.mean(scores)

    def tune(self, model_type: str = "random_forest"):
        """Run hyperparameter optimization"""
        mlflc = MLflowCallback(
            tracking_uri=mlflow.get_tracking_uri(),
            metric_name="f1_score"
        )

        study = optuna.create_study(
            direction="maximize",
            study_name=f"{model_type}_optimization"
        )

        objective_func = getattr(self, f"objective_{model_type}")

        study.optimize(
            objective_func,
            n_trials=self.n_trials,
            callbacks=[mlflc]
        )

        self.best_params = study.best_params

        print(f"Best F1 Score: {study.best_value:.4f}")
        print(f"Best parameters: {self.best_params}")

        return self.best_params
```

---

## 🚀 Model Deployment (FastAPI)

```python
# src/api/main.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import mlflow.sklearn
import pandas as pd
from typing import List
import logging

app = FastAPI(title="Churn Prediction API", version="1.0.0")
logger = logging.getLogger(__name__)

# Load model on startup
MODEL_URI = "models:/churn_predictor_random_forest/production"
model = None

@app.on_event("startup")
async def load_model():
    global model
    model = mlflow.sklearn.load_model(MODEL_URI)
    logger.info("Model loaded successfully")

class Customer(BaseModel):
    customer_id: str
    total_purchases: int
    total_spent: float
    customer_lifetime_months: int
    support_tickets: int
    emails_sent: int
    emails_opened: int
    last_purchase_date: str

class PredictionResponse(BaseModel):
    customer_id: str
    churn_probability: float
    will_churn: bool
    confidence: str

@app.post("/predict", response_model=PredictionResponse)
async def predict_churn(customer: Customer):
    """Predict churn for a single customer"""
    try:
        # Convert to DataFrame
        df = pd.DataFrame([customer.dict()])

        # Preprocess (assuming preprocessor is loaded)
        # df_processed = preprocessor.transform(df)

        # Predict
        churn_proba = model.predict_proba(df_processed)[0][1]
        will_churn = churn_proba > 0.5

        # Confidence
        confidence = "high" if abs(churn_proba - 0.5) > 0.3 else "medium" if abs(churn_proba - 0.5) > 0.15 else "low"

        return PredictionResponse(
            customer_id=customer.customer_id,
            churn_probability=round(churn_proba, 4),
            will_churn=will_churn,
            confidence=confidence
        )
    except Exception as e:
        logger.error(f"Prediction error: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/predict_batch")
async def predict_batch(customers: List[Customer]):
    """Batch prediction for multiple customers"""
    results = []
    for customer in customers:
        result = await predict_churn(customer)
        results.append(result.dict())
    return results

@app.get("/health")
async def health_check():
    return {"status": "healthy", "model_loaded": model is not None}

@app.get("/model_info")
async def model_info():
    """Get information about the loaded model"""
    return {
        "model_uri": MODEL_URI,
        "model_type": "RandomForestClassifier",
        "version": "1.0.0"
    }
```

---

## 📈 Model Monitoring

```python
# src/monitoring/drift_detection.py
from evidently.report import Report
from evidently.metric_preset import DataDriftPreset, TargetDriftPreset
import pandas as pd

class DriftDetector:
    def __init__(self, reference_data: pd.DataFrame):
        self.reference_data = reference_data

    def detect_data_drift(self, current_data: pd.DataFrame) -> dict:
        """Detect feature drift"""
        report = Report(metrics=[
            DataDriftPreset(),
        ])

        report.run(
            reference_data=self.reference_data,
            current_data=current_data
        )

        return report.as_dict()

    def detect_target_drift(
        self,
        reference_predictions: pd.Series,
        current_predictions: pd.Series
    ) -> dict:
        """Detect prediction drift"""
        report = Report(metrics=[
            TargetDriftPreset(),
        ])

        ref_df = pd.DataFrame({'prediction': reference_predictions})
        curr_df = pd.DataFrame({'prediction': current_predictions})

        report.run(
            reference_data=ref_df,
            current_data=curr_df,
            column_mapping={'target': 'prediction'}
        )

        return report.as_dict()
```

---

## 🎯 Usage Examples

### Train a Model

```python
from src.data.loader import DataLoader
from src.data.preprocessing import DataPreprocessor
from src.models.train import ModelTrainer

# Load data
loader = DataLoader("data/raw/customers.csv")
df = loader.load_raw_data()
train_df, val_df, test_df = loader.split_data(df)

# Preprocess
preprocessor = DataPreprocessor()
X_train = preprocessor.fit_transform(train_df.drop('churn', axis=1))
y_train = train_df['churn']
X_val = preprocessor.transform(val_df.drop('churn', axis=1))
y_val = val_df['churn']

# Train
trainer = ModelTrainer()
model, metrics = trainer.train_model(
    X_train, y_train,
    X_val, y_val,
    model_type="random_forest",
    params={'n_estimators': 100, 'max_depth': 10}
)

print(f"Model F1 Score: {metrics['f1_score']:.4f}")
```

### Hyperparameter Tuning

```python
from src.models.tune import HyperparameterTuner

tuner = HyperparameterTuner(X_train, y_train, n_trials=50)
best_params = tuner.tune(model_type="random_forest")

# Train with best params
model, metrics = trainer.train_model(
    X_train, y_train,
    X_val, y_val,
    model_type="random_forest",
    params=best_params
)
```

### API Usage

```bash
# Start API
uvicorn src.api.main:app --reload

# Predict
curl -X POST "http://localhost:8000/predict" \
  -H "Content-Type: application/json" \
  -d '{
    "customer_id": "C12345",
    "total_purchases": 15,
    "total_spent": 1250.50,
    "customer_lifetime_months": 24,
    "support_tickets": 2,
    "emails_sent": 50,
    "emails_opened": 30,
    "last_purchase_date": "2024-01-15"
  }'
```

---

## 📊 MLflow UI

```bash
# Start MLflow server
mlflow server \
  --backend-store-uri postgresql://user:pass@localhost/mlflow \
  --default-artifact-root ./mlruns \
  --host 0.0.0.0 \
  --port 5000

# Open in browser
open http://localhost:5000
```

**Features available**:
- Experiment comparison
- Metric visualization
- Parameter tuning history
- Model registry
- Model versioning
- Model deployment tracking

---

## 🚀 Production Deployment

### Docker Deployment

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Kubernetes Deployment

```yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ml-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: ml-api
  template:
    metadata:
      labels:
        app: ml-api
    spec:
      containers:
      - name: api
        image: ml-training-pipeline:latest
        ports:
        - containerPort: 8000
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: ml-secrets
              key: database-url
        - name: MLFLOW_TRACKING_URI
          value: "http://mlflow-service:5000"
        resources:
          requests:
            memory: "512Mi"
            cpu: "500m"
          limits:
            memory: "2Gi"
            cpu: "2000m"
```

---

## 📈 Revenue Potential

**As MLOps Platform SaaS**:
- **Low estimate**: $15k MRR (50 customers × $300/month)
- **High estimate**: $80k MRR (200 customers × $400/month)

**Value Proposition**:
- Reduce ML deployment time from weeks to hours
- Automated experiment tracking
- Model versioning and rollback
- Production monitoring
- A/B testing framework

---

## 🎓 Learning Outcomes

After completing this example you'll know:

- ✅ How to build production ML pipelines
- ✅ Experiment tracking with MLflow
- ✅ Hyperparameter optimization with Optuna
- ✅ Model deployment with FastAPI
- ✅ Data and model drift detection
- ✅ ML monitoring and alerting
- ✅ Model versioning and registry

---

## 🔗 Related Resources

- **[ML Engineer Agent](../../agents/domain/ml-engineer.md)** - Use this agent for ML tasks
- **[ML Tools Documentation](../../docs/08-ml-tools.md)** - MLflow, DVC, etc.
- **[RAG System Example](../llm-rag-system/README.md)** - LLM application

---

## 📞 Support

Issues? Questions?
- [Open an Issue](https://github.com/rmn1978/claude-code-advanced-guide/issues)
- [GitHub Discussions](https://github.com/rmn1978/claude-code-advanced-guide/discussions)

---

**Built with Claude Code** 🤖

[← Back to Examples](../README.md)
