# --- Stage 1: Build dependencies ---
FROM python:3.13-alpine AS builder

# Install required build dependencies
RUN apk add --no-cache \
    build-base \
    python3-dev \
    linux-headers \
    pcre-dev \
    openssl-dev

WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies in /install (to be copied later)
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# --- Stage 2: Final runtime image ---
FROM python:3.13-alpine

# Set environment variables
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install only essential runtime dependencies
RUN apk add --no-cache \
    pcre \
    openssl

# Copy installed dependencies from the builder stage
COPY --from=builder /install /usr/local

# Copy application source code
COPY /app /app

# Expose port 5000
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]
