FROM tomcat:9.0.55-jdk8-corretto
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/
EXPOSE 8080
