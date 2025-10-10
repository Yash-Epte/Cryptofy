import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler
import requests
import tensorflow as tf
from tensorflow import keras
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM, Dropout
from datetime import datetime, timedelta
from sklearn.metrics import r2_score
import matplotlib.pyplot as plt
from flask import Flask, jsonify, request
from flask import send_from_directory
import datetime



app = Flask(__name__)
#coin list 
@app.route('/coin_list', methods =['GET'])
def coin_list():  
    #api call
    url = "https://api.coingecko.com/api/v3/coins/list"
    response = requests.get(url)


    if response.status_code == 200:
        coin_name = response.json()
        return coin_name
    else:
        return "Error"


#monthly data
@app.route('/month', methods=['POST'])
def month():
    data = request.get_json()
    if not data or 'coin_id' not in data:
        return jsonify({'error': 'coin_id is required in JSON payload'}), 400
    coin_id = data['coin_id']
    
    url =f"https://api.coingecko.com/api/v3/coins/{coin_id}/market_chart?vs_currency=inr&days=30&interval=daily&precision=0"
    response = requests.get(url)
    
    if response.status_code == 200:
        coin_name = response.json()['prices']
        print("Lentgth is ",len(coin_name))
        return coin_name
    else:
        return "Error"

#daily data
@app.route('/daily', methods=['POST'])
def daily():
    data = request.get_json()
    if not data or 'coin_id' not in data:
        return jsonify({'error': 'coin_id is required in JSON payload'}), 400

    coin_id = data['coin_id']
    url = f"https://api.coingecko.com/api/v3/coins/{coin_id}/market_chart?vs_currency=inr&days=30"
    response = requests.get(url)
    data = response.json()

    if 'prices' in data:
        df = pd.DataFrame(data['prices'], columns=['timestamp', 'price'])
        df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
        df = df.set_index('timestamp')
        last_24_rows = df.tail(24)

        result = last_24_rows.reset_index().to_dict('records')        
        print("len is",len(result))
        return jsonify(result)
    else:
        return jsonify({'error': 'No data found'}), 404

    

#lstm prediction model
@app.route('/predict', methods=['POST'])
def prediction():

    def fetch_crypto_data():
        #getting data request
        data = request.get_json()
        if not data or 'coin_id' not in data:
            return jsonify({'error': 'coin_id is required in JSON payload'}), 400

        coin_id = data['coin_id']
        start = data['start']
        till = data['till']

        url = f"https://api.coingecko.com/api/v3/coins/{coin_id}/market_chart/range?vs_currency=inr&from={start}&to={till}"
        response = requests.get(url)
        data = response.json()['prices']
        print(data)

        # Convert data to a Pandas DataFrame
        crypto_data = pd.DataFrame(data, columns=['Date', 'Close'])
        crypto_data['Date'] = pd.to_datetime(crypto_data['Date'], unit='ms')
        crypto_data = crypto_data.set_index('Date')

        return crypto_data

    def preprocess_data(data):
        # which is a transformer that scales the data to a given range, typically [0, 1].
        scaler = MinMaxScaler()
        
        #This extracts the numerical values from the input data DataFrame or Series, and reshapes them into a 2D NumPy array with a single column
        scaled_data = scaler.fit_transform(data.values.reshape(-1, 1))

        #The scaled version of the input data, now in the range [0, 1]
        return scaled_data, scaler

    def create_dataset(data, look_back=1):
        X, Y = [], []
        #iterates over the indices of the input data, excluding the last
        for i in range(len(data) - look_back):
            X.append(data[i:(i + look_back), 0])
            Y.append(data[i + look_back, 0])
        X, Y = np.array(X), np.array(Y)
        #Reshape the data into a format compatible with LSTM layers
        X = np.reshape(X, (X.shape[0], X.shape[1], 1))
        return X, Y

    def build_lstm_model(input_shape):
        #creates a sequential model, which is a linear stack of layers
        model = Sequential()
        model.add(LSTM(units=50, return_sequences=True, input_shape=input_shape))#adds an LSTM layer to the mode
        model.add(Dropout(0.2)) #20% of the units will be randomly dropped during training) to prevent overfitting.
        model.add(LSTM(units=50, return_sequences=True)) #adds another LSTM layer with 50 units a
        model.add(Dropout(0.2))
        model.add(LSTM(units=50))
        model.add(Dropout(0.2))
        model.add(Dense(units=1))
        model.compile(optimizer='adam', loss='mean_squared_error')#compiles the model with the Adam optimizer and the mean squared error loss function
        return model

    def predict_next_24_hours(look_back=5, epochs=10, batch_size=32):
        # Fetch data for the last 30 days
        crypto_data = fetch_crypto_data()
        
        data, scaler = preprocess_data(crypto_data['Close'])

        # Split the data into training and testing sets
        train_size = int(len(data) * 0.8)
        train_data = data[:train_size]
        test_data = data[train_size:]

        # Create training and testing datasets
        X_train, Y_train = create_dataset(train_data, look_back)
        X_test, Y_test = create_dataset(test_data, look_back)

        input_shape = (X_train.shape[1], X_train.shape[2])
        model = build_lstm_model(input_shape)

        model.fit(X_train, Y_train, epochs=epochs, batch_size=batch_size, verbose=1)

        # Make predictions on the testing set
        test_predictions = model.predict(X_test)
        test_predictions = scaler.inverse_transform(test_predictions)
        Y_test = scaler.inverse_transform(Y_test.reshape(-1, 1))

        # Calculate the R-squared value
        r_squared = r2_score(Y_test, test_predictions)
        print(f'Accuracy : {r_squared:.2f}%')

        # Prepare data for prediction
        last_data = data[-look_back:]
        last_data = np.reshape(last_data, (1, look_back, 1))

        # Initialize predictions list
        predictions = []

        # Make predictions for the next 24 hours
        for _ in range(24):
            predicted_price = model.predict(last_data)
            last_data = np.roll(last_data, -1, axis=1)
            last_data[0, -1] = predicted_price
        

            # Inverse transform the predicted price
            predicted_price = scaler.inverse_transform(predicted_price)
            current_time = datetime.datetime.now()
            
             # Calculate the timestamp for the current prediction
            timestamp = current_time + datetime.timedelta(hours=_+1)

            # Append the prediction with timestamp to the predictions list
            predictions.append({
                'price': float(predicted_price[0, 0]),
                'timestamp': timestamp.strftime('%Y-%m-%d %H:%M:%S')
            })
            r_percentage = int(r_squared*100)
        return r_percentage, predictions

    # Get R-squared and predictions
    r_squared, predictions = predict_next_24_hours(look_back=5, epochs=10, batch_size=32)

    # Prepare JSON response
    response_data = {
       "predictions": predictions,
       "Accuracy ": r_squared
    }

    return jsonify(response_data)



if __name__ == '__main__':
    app.run(debug=True)