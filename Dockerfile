FROM tomcat:9.0.91

# copy the main WAR file
COPY ./target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# expose port 8080
EXPOSE 8080

# run Tomcat for a short time and then stop it to initialize the application
RUN catalina.sh run & sleep 5 && catalina.sh stop


#
COPY ./properties_configuration_mw/application.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/application.properties
#
COPY ./properties_configuration_mw/application-mysql.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/application-mysql.properties
 
# start Tomcat
CMD ["catalina.sh", "run"]
