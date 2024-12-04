FROM openjdk:8-jdk-alpine
MAINTAINER 'heavyflood@gsitm.com'
ENV TZ=Asia/Seoul
VOLUME /tmp
RUN mkdir -p /whatap/plugin
ARG NAMESPACE
ENV NAMESPACE ${NAMESPACE}
ARG SERVER_ENV
ENV SERVER_ENV ${SERVER_ENV}
ARG CONFIG_NAME
ENV CONFIG_NAME 'oc-auth.yml'
ENV JAVA_OPTS="-Xmx2048m -Xms2048m -javaagent:/whatap/whatap.agent-2.1.1.jar -Dwhatap.micro.enabled=true"
COPY ./auth-0.0.1-SNAPSHOT.jar oc-auth.jar
COPY ./oc-auth.yml oc-auth.yml
COPY ./whatap.conf /whatap
COPY ./whatap.agent-2.1.1.jar /whatap
COPY ./paramkey.txt /whatap
COPY ./CustomPool.x /whatap/plugin
# Timezone
RUN apk --no-cache add tzdata && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo "Asia/Seoul" > /etc/timezone
ENTRYPOINT exec java $JAVA_OPTS -Dspring.profiles.active=${SERVER_ENV} -Dspring.config.location=${CONFIG_NAME} -Drun.arguments=-namespace=${NAMESPACE} -jar /oc-auth.jar