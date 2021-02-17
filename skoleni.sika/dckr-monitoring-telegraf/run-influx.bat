@echo off

REM
REM @see https://towardsdatascience.com/get-system-metrics-for-5-min-with-docker-telegraf-influxdb-and-grafana-97cfd957f0ac
REM
docker run --rm ^
  -e INFLUXDB_DB=telegraf -e INFLUXDB_ADMIN_ENABLED=true ^
  -e INFLUXDB_ADMIN_USER=admin ^
  -e INFLUXDB_ADMIN_PASSWORD=tc ^
  -e INFLUXDB_USER=telegraf -e INFLUXDB_USER_PASSWORD=tc ^
  -v influxdb-volume:/var/lib/influxdb ^
  influxdb /init-influxdb.sh