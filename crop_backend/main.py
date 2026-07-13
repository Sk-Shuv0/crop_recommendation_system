from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pickle
import pandas as pd
import shap

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ==========================
# Load Model
# ==========================
model = pickle.load(open("model.pkl", "rb"))

# SHAP Explainer
explainer = shap.TreeExplainer(model)

# Feature names
feature_names = [
    "N",
    "P",
    "K",
    "temperature",
    "humidity",
    "ph",
    "rainfall"
]


# ==========================
# Input Schema
# ==========================
class Input(BaseModel):
    N: float
    P: float
    K: float
    temperature: float
    humidity: float
    ph: float
    rainfall: float


# ==========================
# Prediction API
# ==========================
@app.post("/predict")
def predict(data: Input):

    # DataFrame (feature names সহ)
    features = pd.DataFrame(
        [[
            data.N,
            data.P,
            data.K,
            data.temperature,
            data.humidity,
            data.ph,
            data.rainfall
        ]],
        columns=feature_names
    )

    # Prediction probabilities
    probs = model.predict_proba(features)[0]
    classes = model.classes_

    results = []

    for crop, prob in zip(classes, probs):
        results.append({
            "crop": str(crop),
            "confidence": round(float(prob), 4)
        })

    # Sort Top 3
    results.sort(
        key=lambda x: x["confidence"],
        reverse=True
    )

    top3 = results[:3]

    # ==========================
    # SHAP Explanation
    # ==========================

    shap_exp = explainer(features)

    values = shap_exp.values

    # Shape:
    # (samples, features) অথবা
    # (samples, features, classes)

    if values.ndim == 3:

        top_crop = top3[0]["crop"]
        class_index = list(classes).index(top_crop)

        feature_impacts = values[0, :, class_index]

    else:

        feature_impacts = values[0]

    explanation = []

    for feature, impact in zip(feature_names, feature_impacts):

        explanation.append({
            "feature": feature,
            "impact": round(float(abs(impact)), 6)
        })

    explanation.sort(
        key=lambda x: x["impact"],
        reverse=True
    )

    return {
        "results": top3,
        "explanation": explanation
    }