FROM openjdk:8-jdk-alpine
MAINTAINER 'heavyflood@gsitm.com'
VOLUME /tmp
RUN mkdir -p /whatap
ARG SERVER_ENV
ENV SERVER_ENV ${SERVER_ENV}
ARG CONFIG_NAME
ENV CONFIG_NAME ${CONFIG_NAME}
ENV JAVA_OPTS="-XX:PermSize=1024m -XX:MaxPermSize=512m -Xmx4g -Xms2g -javaagent:/whatap/whatap.agent-2.0_29.jar -Dwhatap.micro.enabled=true"
COPY ./socketSever-0.0.1-SNAPSHOT.war oc-chat.war
COPY configfiles/configfiles/* ./
COPY ./whatap.conf /whatap
COPY ./whatap.agent-*.jar /whatap
# Timezone
RUN apk --no-cache add tzdata && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo "Asia/Seoul" > /etc/timezone
ENTRYPOINT exec java $JAVA_OPTS -Dspring.profiles.active=${SERVER_ENV} -Dspring.config.location=${CONFIG_NAME} -jar /oc-chat.war