#
# @see https://hub.docker.com/r/jboss/wildfly
# @see https://blog.mikesir87.io/2015/12/creating-wildfly-docker-image-with-postgresql/ << pouziva alpine!
# @see https://aboullaite.me/protola-alpine-java/
# @see https://dev.to/l1x/small-alpine-linux-containers-with-java-13-63c << alpine a multistage build
# @see https://blog.developer.atlassian.com/minimal-java-docker-containers/
# @see https://blog.gilliard.lol/2018/11/05/alpine-jdk11-images.html << alpine slim per java module
# @see https://technology.amis.nl/continuous-delivery/containers/the-size-of-docker-images-containing-openjdk-11-0-6/ 
#     - anebo pouzit azul/zulu-openjdk-alpine:11.0.6-jre
#     - nebo adoptopenjdk/openjdk11:jre-11.0.6_10-alpine
#     - jsou tam i centos/jre!
#     - ale to jre to zmensi!!!
#
FROM jboss/wildfly:21.0.2.Final

#
# @see https://github.com/goldmann/wildfly-docker-deployment-example << simplest docker/widlfly example
#
COPY target/simplest.jaxws.war /opt/jboss/wildfly/standalone/deployments/

# mssql driver a module
# - https://registry.hub.docker.com/r/izone/wildfly/dockerfile
# - https://forums.docker.com/t/docker-jboss-wildfly-how-to-add-datasources-and-mysql-connector/15301
# - https://github.com/goldmann/wildfly-docker-configuration/tree/master/cli

#
# @see https://docs.wildfly.org/21/Admin_Guide.html#structure-of-the-webservices-subsystem
# @see https://github.com/wildfly/wildfly/blob/master/docs/src/main/asciidoc/_developer-guide/JAX_WS_Advanced_User_Guide.adoc#Published_WSDL_customization
#
# kvuli wsdl-host/wsdl-modify-address,
# aby xsd:import melo schemaLocation="http://localhost:8080/ a ne na 172.*.*.1)
# dale pridavam jdbc datasource/nmDS
COPY config/standalone.xml /opt/jboss/wildfly/standalone/configuration/
COPY config/modules /opt/jboss/wildfly/modules/

# @see https://github.com/pascalgrimaud/docker-jboss-as/blob/master/Dockerfile, jak resit konfiguraci via sed
# @see https://goldmann.pl/blog/2014/07/23/customizing-the-configuration-of-the-wildfly-docker-image/

# tohle funguje, localhost:8080, ale wsdl-host to neresi
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "--debug"]

#
# @see https://goldmann.pl/blog/2013/10/07/wildfly-cluster-using-docker-on-fedora/
#
# bacha musi mit unix radkovani
#ADD launch.sh /
#cls
#RUN chmod +x /launch.sh
# Run WildFly after the container boots
#ENTRYPOINT /launch.sh