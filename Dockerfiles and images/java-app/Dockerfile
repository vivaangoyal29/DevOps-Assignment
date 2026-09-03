FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY src/Main.java ./src/Main.java

RUN javac src/Main.java

EXPOSE 8080

CMD ["java", "src.Main"]