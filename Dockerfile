# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies that might be needed by Python libraries
RUN apt-get update && apt-get install -y \
    build-essential \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code into the container
COPY . .

# Expose the port the app runs on (Flask's default is 5000)
EXPOSE 5000

# Define the command to run your application using Gunicorn, a production web server
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
