@echo off

REM
REM @see https://thenewstack.io/how-to-setup-influxdb-telegraf-and-grafana-on-docker-part-2/
REM
docker run --rm telegraf telegraf config | touch telegraf.conf
