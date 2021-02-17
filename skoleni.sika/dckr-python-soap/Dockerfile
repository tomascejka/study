#
# @see https://hub.docker.com/_/python
# @see https://hub.docker.com/r/jsorah/python-zeep-docker
#

# basic-version
FROM python:3.6
# alpine version
#FROM python:3.6-alpine

LABEL maintainer="tomas.cejka@styrax.cz (shaman), Styrax"

#
# @see https://github.com/jsorah/python-zeep-docker/blob/master/Dockerfile
# adresa v github odkazu http://www.webservicex.com/geoipservice.asmx?WSDL nefunguje nahradil jsem jinou
#
# usage: docker run -it --rm python-zeep-docker python -m zeep http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso?WSDL

# basic-version
RUN apt-get update && apt-get install -y \
    libxml2-dev libxmlsec1-dev libxmlsec1-openssl

# alpine version, 
# - https://pkgs.alpinelinux.org/contents?branch=v3.4&name=xmlsec-dev&arch=armhf&repo=community
# - https://xmlsec.readthedocs.io/en/latest/install.html
#RUN apk add --update --no-cache g++ gcc libxslt-dev libxml2-dev xmlsec-dev

RUN pip install zeep[xmlsec]

# Copy file
# @see https://runnable.com/docker/python/dockerize-your-python-application
# COPY client.py    /
COPY ./client.py    /

CMD [ "python", "./client.py" ]