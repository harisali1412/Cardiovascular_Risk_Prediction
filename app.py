from flask import Flask, request, jsonify
from joblib import load
import numpy as np
from flask_cors import CORS

# Load the Random Forest model
model = load('random_forest.joblib')

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        if 'features' not in data:
            return jsonify({'error': 'No features provided'}), 400

        input_features = np.array(data['features']).reshape(1, -1)
        prediction = model.predict(input_features)
        prediction_prob = model.predict_proba(input_features)

        # Return prediction with labeled probabilities
        response = {
            'prediction': int(prediction[0]),
            'probabilities': {
                'Class 0': prediction_prob[0][0],
                'Class 1': prediction_prob[0][1]
            }
        }
        return jsonify(response)
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
