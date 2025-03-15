# Use the official Python image as the base image
FROM python:3.13-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask app code into the container
COPY /app /app

# Expose port 5000 for the Flask app
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
