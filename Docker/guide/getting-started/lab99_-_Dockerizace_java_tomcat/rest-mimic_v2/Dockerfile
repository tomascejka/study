FROM tomcat:8.5.41-jre8-alpine

# version of builded war file (eg. app-1.0-SNAPSHOT.war)
ENV APP_VERSION 2.0
ENV APP_NAME restmimic
# build dir at host filesystem (where maven saves result of package/install goal)
ENV BUILD_DIR target
# deployment dir at container filesystem (where war gonna be stored)
ENV DEPLOYMENT_DIR ${CATALINA_HOME}/webapps

# deployement of build (host) war file into (container) tomcat webapps directory
COPY ./${BUILD_DIR}/${APP_NAME}-${APP_VERSION}.war ${DEPLOYMENT_DIR}