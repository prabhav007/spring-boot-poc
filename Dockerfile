FROM azul/zulu-openjdk:17-latest as builder
WORKDIR application
ARG JAR_FILE
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM azul/zulu-openjdk:17-jre-latest
WORKDIR application
COPY --from=builder application/dependencies/ application/snapshot-dependencies/ application/spring-boot-loader/ application/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]