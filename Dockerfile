FROM alpin:3.7
FROM openjdk:8

ADD countries-assembly-1.0.2.jar countries-assembly-1.0.2.jar

EXPOSE 8080

ENTRYPOINT [“java”, “-jar”, “countries-assembly-1.0.2.jar”]
