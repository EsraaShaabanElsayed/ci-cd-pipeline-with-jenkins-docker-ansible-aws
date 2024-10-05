
FROM tomcat:9.0.91

#webapps/examples

COPY ./target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.war /usr/local/tomcat/webapps/petclinic.war

EXPOSE 8080

RUN catalina.sh run & sleep 5 && catalina.sh stop

COPY ./properties_configuration_mw/application.properties /usr/local/tomcat/webapps/petclinic/WEB-INF/classes/application.properties
COPY ./properties_configuration_mw/application-mysql.properties /usr/local/tomcat/webapps/petclinic/WEB-INF/classes/application-mysql.properties

CMD ["catalina.sh", "run"]

