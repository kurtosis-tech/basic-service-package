FROM python:3.8.18-bookworm

ADD app /app/

WORKDIR /app

CMD pip install -r requirements.txt

ENTRYPOINT ["streamlit", "run", "dashboard_home.py"]