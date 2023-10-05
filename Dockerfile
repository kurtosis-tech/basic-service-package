FROM python:3.8.18-bookworm

COPY app /app

WORKDIR /app

RUN pip install  -r requirements.txt

ENTRYPOINT ["streamlit", "run", "service.py"]