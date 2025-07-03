# 1) Etapa de compilación con Maven + JDK17
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copia sólo el pom para cachear dependencias
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia el código y empaqueta la aplicación
COPY src ./src
RUN mvn clean package -DskipTests -B

# 2) Etapa de ejecución con JRE ligero
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copia cualquier JAR que esté en target/ como app.jar
COPY --from=build /app/target/*.jar app.jar

# Expón el puerto de la aplicación
EXPOSE 8080

# Punto de entrada
ENTRYPOINT ["java", "-jar", "app.jar"]
