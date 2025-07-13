FROM python:3.10-slim

# System packages required for LLM, FAISS, Streamlit
RUN apt-get update && apt-get install -y \
    libglib2.0-0 libsm6 libxrender1 libxext6 git

WORKDIR /app

# Copy code into the container
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run ingestion at build time (optional if data/pdfs is stable)
RUN python ingest.py

# Expose Streamlit port
EXPOSE 8501

# Launch the Streamlit chatbot
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.enableCORS=false"]