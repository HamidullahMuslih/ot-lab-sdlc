FROM tomcat:9.0.87-jdk8-corretto
COPY ./target/vprofile-v2.war /usr/local/tomcat/webapps/root.war
EXPOSE 8080