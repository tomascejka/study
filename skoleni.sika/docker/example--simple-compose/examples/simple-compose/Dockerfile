# FROM python:3.7-slim
# WORKDIR /app
# COPY requirements.txt .
# RUN pip install -r requirements.txt
# COPY . .
# CMD ["python", "app.py"]
# EXPOSE 80


FROM python:3.9-slim
# pracovni adresar - aplikace, defaultne je to /root
# slouzi to pracovni adresar pro aplikaci
WORKDIR /app

# aplikacni nastaveni tech. stack-u
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
CMD ["python", "app.py"]
EXPOSE 80

#
# Presentace pouziti z ruky
#
# docker build -t counter .
# docker network create counter
# docker run --name redis -d --net counter redis
# docker run --name counter -d --net counter -p 8000:80 counter
# docker stop counter redis
# docker rm counter redis
# docker network rm counter
# viz. https://github.com/ondrejsika/docker-training/issues/108

#
# To vse resit via compose up/down
#