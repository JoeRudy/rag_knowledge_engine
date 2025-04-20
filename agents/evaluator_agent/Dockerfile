# Start from an official lightweight Python image
FROM python:3.11-slim

# Set environment variables
# Prevents writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
# Logs output immediately
ENV PYTHONUNBUFFERED=1

# Set working directory
# All commands will run inside /app folder
WORKDIR /app

# Copy local code to the container
# Copy everything from local folder to container
COPY . .

# Install system dependencies
# Updates the package list inside the container
# Installs essential system-level libraries needed to build Python packages 
# (especially those using Postgres or compiled dependencies)
# Without it, you would often get errors when trying to install things like psycopg2, 
# asyncpg, or even compiling some deep LLM libraries.
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Installs GNU Compiler Collection (needed to compile some Python libraries like psycopg2)
    gcc \
    # Installs Postgres client libraries needed by Postgres drivers (e.g., asyncpg, psycopg2)
    libpq-dev \
    # Cleans up cache files to make the final Docker image smaller
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose the service port (8005 for evaluator agent)
EXPOSE 8005

# Command to run the application
# Start the FastAPI app server
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8005"]
