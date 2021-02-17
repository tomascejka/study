@echo off

REM
REM @see https://towardsdatascience.com/get-system-metrics-for-5-min-with-docker-telegraf-influxdb-and-grafana-97cfd957f0ac
REM
docker network create monitoring
docker volume create grafana-volume
docker volume create influxdb-volume