FROM tomcat:8.5.47-jdk8-openjdk

WORKDIR /usr/local/tomcat/webapps

COPY ./target/vprofile-v2.war .

EXPOSE 8080