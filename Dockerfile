#FROM tomcat:9.0.21-jdk11-openjdk
FROM debian:10-slim AS build

RUN apt-get update && apt-get install -y default-jdk maven ca-certificates-java  git
WORKDIR /usr/local/

COPY ./ /
RUN ls -la /usr/local/
RUN git submodule init
RUN git submodule update

COPY ../../Vitro Vitro
COPY ../../VIVO VIVO
COPY ./project-installer project-installer
COPY ./project-settings-local.xml project-settings-local.xml

RUN ls -la /usr/local/

WORKDIR /usr/local/VIVO/

RUN ls -la ./
RUN ls -la /usr/local/VIVO/
RUN ls -la /usr/local/Vitro
RUN ls -la /usr/local/project-installer/

RUN mvn clean install -DskipTests -Dcheckstyle.skip -s ../project-settings-local.xml -f pom.xml

FROM tomcat:9.0.21-jdk11-openjdk
COPY --from=build /usr/local/VIVO /usr/local/VIVO
RUN mkdir -p /usr/local/data
#COPY --from=build /usr/local/project-installer/webapp/target/arl112 /usr/local/tomcat/webapps/arl112

COPY --from=build /usr/local/tomcat/webapps/*.war /usr/local/tomcat/webapps

# clean up
RUN rm -r /usr/local/tomcat/webapps/docs
RUN rm -r /usr/local/tomcat/webapps/examples

WORKDIR /usr/local/data/home/config

COPY ./dockercompose.runtime.properties runtime.properties
COPY ./example.applicationSetup.n3 applicationSetup.n3

RUN chmod ugo+w -R /usr/local/tomcat/temp
RUN chmod ugo+w -R /usr/local/data/home

#FROM tomcat:9.0.21-jdk11-openjdk
RUN export CATALINA_OPTS="-Xms512m -Xmx1024m -XX:MaxPermSize=128m"
EXPOSE 8080
CMD ["catalina.sh", "run"]
