FROM tomcat:8.0-jre8

RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ROOT.war /usr/local/tomcat/webapps/ 

EXPOSE 8080
CMD ["catalina.sh", "run"]

