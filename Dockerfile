From tomcat:8.0.20-jre8

RUN mkdir /usr/local/tomcat/webapps/myapp

COPY target/kubernetes-1.0.war /usr/local/tomcat/webapps/kubernetes-1.0.war
