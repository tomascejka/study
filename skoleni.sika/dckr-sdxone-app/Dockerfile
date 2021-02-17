#
# @see https://github.com/microsoft/java/tree/master/docker
#
FROM mcr.microsoft.com/java/jre-headless:15u1-zulu-alpine

#
# @see https://docs.microsoft.com/en-us/azure/developer/java/
#
LABEL maintainer="tomas.cejka@styrax.cz, Styrax"

ENV JBOSS_HOME=/opt/jboss/wildfly
ENV JBOSS_VERSION=21.0.1.Final

# Copy configuration files (zestihleni, zadny ssh v kontaineru nebude)
# @see https://docs.wildfly.org/22/Getting_Started_Guide.html#standalone-server-configurations
COPY tmp/w21/standalone-full.xml    /tmp/wildfly/standalone-full.xml
COPY tmp/init_container.sh          /bin/init_container.sh

#
# Zadny cgroups se vyhazovat nebudou
#
# @see https://man7.org/linux/man-pages/man7/cgroups.7.html
# @see https://www.linuxjournal.com/content/everything-you-need-know-about-linux-containers-part-i-linux-control-groups-and-process
# @see https://engineering.linkedin.com/blog/2016/08/don_t-let-linux-control-groups-uncontrolled
#
RUN wget -O /tmp/wildfly-${JBOSS_VERSION}.tar.gz https://download.jboss.org/wildfly/${JBOSS_VERSION}/wildfly-${JBOSS_VERSION}.tar.gz \
        && tar xvzf /tmp/wildfly-${JBOSS_VERSION}.tar.gz -C /tmp \
        && mkdir -p `dirname $JBOSS_HOME` \
        # Copy core Wildfly and the standalone configuration  
        && mv /tmp/wildfly-${JBOSS_VERSION} $JBOSS_HOME \
        && mv /tmp/wildfly/standalone-full.xml $JBOSS_HOME/standalone/configuration/standalone-full.xml

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND=true

EXPOSE 8080

ENTRYPOINT ["/bin/init_container.sh"]