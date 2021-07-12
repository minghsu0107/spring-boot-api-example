FROM openjdk:17 as builder
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
RUN java -Djarmode=layertools -jar app.jar extract

FROM openjdk:17-jdk-alpine3.14

ENV LANG en_US.UTF-8
ENV env_java_debug_enabled=false

WORKDIR /app
COPY docker-resources/run.sh ./
COPY --from=builder dependencies/ ./
COPY --from=builder spring-boot-loader/ ./
COPY --from=builder snapshot-dependencies/ ./
COPY --from=builder application/ ./

EXPOSE 8080
ENTRYPOINT ["sh", "./run.sh"]
CMD []