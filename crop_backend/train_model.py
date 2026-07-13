import pandas as pd
from sklearn.ensemble import RandomForestClassifier
import pickle

# CSV load
df = pd.read_csv("../assets/Crop_recommendation.csv")

# Features & label
X = df.drop("label", axis=1)
y = df["label"]

# Model
model = RandomForestClassifier(n_estimators=100)
model.fit(X, y)

# Save model
pickle.dump(model, open("model.pkl", "wb"))

print("Model trained & saved as model.pkl")