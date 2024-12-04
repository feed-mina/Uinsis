FROM openjdk:8-jdk-alpine
ARG SERVER_ENV
ENV SERVER_ENV ${SERVER_ENV}
ENV JAVA_OPTS="-Xmx256m -Xms256m"
COPY ./oc-edu-0.0.1-SNAPSHOT.jar oc-edu.jar

# Timezone
RUN apk --no-cache add tzdata && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo "Asia/Seoul" > /etc/timezone
ENTRYPOINT exec java $JAVA_OPTS -Dspring.profiles.active=${SERVER_ENV} -jar /oc-edu.jar