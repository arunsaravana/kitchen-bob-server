FROM openjdk:8-jre-alpine
COPY target/kitchenbob-*.jar kitchenbob.jar
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=test", "kitchenbob.jar"]
