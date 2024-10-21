FROM tomcat:9.0.91

# copy the main WAR file
COPY ./target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# expose port 8080
EXPOSE 8080

# run Tomcat for a short time and then stop it to initialize the application
RUN catalina.sh run & sleep 5 && catalina.sh stop

<<<<<<< HEAD

#
COPY ./properties_configuration_mw/application.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/application.properties
#
COPY ./properties_configuration_mw/application-mysql.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/application-mysql.properties

RUN catalina.sh run & sleep 5 && catalina.sh stop

 
=======
# copy application.properties if it exists
RUN if [ -f ./properties_configuration_mw/application.properties ]; then \
        cp ./properties_configuration_mw/application.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/application.properties; \
    fi
# copy application-mysql.properties if it exists
RUN if [ -f ./properties_configuration_mw/application-mysql.properties ]; then \
        cp ./properties_configuration_mw/application-mysql.properties /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/application-mysql.properties; \
    fi
>>>>>>> 49e4e1011d5e98806e7214eb9d8a692b82b8ee96
# start Tomcat
CMD ["catalina.sh", "run"]
