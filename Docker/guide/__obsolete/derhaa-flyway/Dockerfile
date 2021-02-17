FROM rsmoorthy/mssql

MAINTAINER tomascejka "github/tomascejka"

LABEL description="Provides flyway+mssql for playground"

ADD http://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/3.2.1/flyway-commandline-3.2.1.zip /flyway.zip

RUN unzip /flyway.zip && rm /flyway.zip && mv /flyway-3.2.1 /flyway && ln -s /flyway/flyway /usr/local/bin/flyway

WORKDIR /flyway
ENTRYPOINT ["flyway"]
CMD ["--help"]