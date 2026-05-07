FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
# Forzamos la descarga de dependencias y empaquetado
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
# El asterisco asegura que encuentre el JAR sin importar el nombre exacto
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]