FROM python:3.9-slim 
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir  -r requirements.txt
COPY stock_app  .
ENTRYPOINT ["streamlit","run","stock_app.py"]
