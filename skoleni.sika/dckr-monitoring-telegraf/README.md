# Monitoring stack
TODO - prozkoumat, jak monitorovat docker via. https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker

Bacha na nastavení sítě:
* aktuálně mám nastaveno:192.168.5.154 (zjisteno via ipconfig, viz. Ethernet adapter Ethernet) 
* nastavuje se v ./telegraf.conf
* docker-compose.yml, viz. telegraf/extra_hosts
* grafana, v nastavení InfluxDB datovýho zdroje je URL

## Nástroje
* Grafana
* InfluxDB
* Telegraf

## Použití

### Docker Compose
$ docker-compose up -d --force-recreate
$ docker-compose ps << kontrola zda vše běží (pri compose up se vypisuji done per kontainer, ale jistota je si to ověřit)
$ docker-compose down

### Grafana
* http://localhost:3000
* najdi si Dashboard a uvidis, viz. telegraf-system-dashboard

### Telegraf
$ docker ps << a zjistíš název kontainer-u (bude to telegraf, viz. docker-compose.yml/influxdb/container_name)
$ docker container logs -f --since 10m telegraf << rychle zjistis problem v logu 
$ docker exec -it telegraf bash

#### Zdroje - telegraf
  -  https://docs.influxdata.com/telegraf/v1.17/administration/configuration/
  -  https://thenewstack.io/how-to-setup-influxdb-telegraf-and-grafana-on-docker-part-1/
  -  https://dev.to/project42/install-grafana-influxdb-telegraf-using-docker-compose-56e9 << telegraf v docker-compose + telegraf.conf
  -  https://towardsdatascience.com/get-system-metrics-for-5-min-with-docker-telegraf-influxdb-and-grafana-97cfd957f0ac << nastaveni grafana dashboardu (viz. screenshoty)
  -  https://www.influxdata.com/blog/configuring-the-docker-telegraf-input-plugin/ << docker monitoring - via telegraf plugin, nezkousel jsem!!
  -  https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker << docker monitoring - via telegraf plugin, nezkousel jsem!!

### InfluxDB
$ docker ps << a zjistíš název kontainer-u (bude to influxdb, viz. docker-compose.yml/influxdb/container_name)
$ docker container logs -f --since 10m influxdb << rychle zjistis problem v logu 
$ docker exec -it influxdb bash
$ influx
$ show databases << zobrazi internal a telegraf
$ select * from cpu limit 2; << zobrazi cpu
$ show measurements << zobrazi zdroje, ktere telegraf sleduje
$ select * from cpu limit 2; << zobrazi cpu

#### Zdroje - InfluxDB
  -  https://thenewstack.io/how-to-setup-influxdb-telegraf-and-grafana-on-docker-part-2/ << jak se podivat do InfluxDB - show databases
  -  https://lkhill.com/telegraf-influx-grafana-network-stats/ << sice rucni instalace/bez dockeru, ale inspirace - show measurements (zobrazi zdroje, kt. Telegraf sleduje a posila do InfluxDB) a pak vim co muzu selectovat, napr. select * from cpu limit 2 apod.