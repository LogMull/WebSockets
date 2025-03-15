from flask import Flask, render_template
from flask_socketio import SocketIO, send
from flask_cors import CORS  # Import CORS

# Initialize the Flask app
app = Flask(__name__)

# Enable CORS for all domains (you can specify a list of allowed origins if needed)
CORS(app)

# Initialize SocketIO
socketio = SocketIO(app, async_mode='eventlet')

# Route for serving the HTML page
@app.route('/')
def index():
    return render_template('index.html')

# WebSocket event to handle messages
@socketio.on('message')
def handle_message(msg):
    print('Message received: ' + msg)
    send('Echo: ' + msg)

if __name__ == '__main__':
    # Run the app with SocketIO
    socketio.run(app, host='0.0.0.0', port=5000)
