# Python 3.11 base image optimized for Alpine Linux (smaller)
FROM python:3.11-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Set environment variable to identify the service (useful for debugging)
ENV SERVICE_NAME="inference-service"

# Expose the port that Uvicorn will run on
EXPOSE 8000

# Command to run the application (using Uvicorn to serve main.py)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]