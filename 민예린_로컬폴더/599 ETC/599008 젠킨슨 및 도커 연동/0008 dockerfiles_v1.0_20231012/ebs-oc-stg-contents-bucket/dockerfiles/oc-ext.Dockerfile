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
ENV CONFIG_NAME ${CONFIG_NAME}
ENV JAVA_OPTS="-XX:PermSize=1024m -XX:MaxPermSize=512m -Xmx4g -Xms2g -javaagent:/whatap/whatap.agent-2.1.1.jar -Dwhatap.micro.enabled=true"
COPY ./ext-0.0.1-SNAPSHOT.jar oc-ext.jar
COPY ./configfiles/configfiles/ext/* ./
COPY ./whatap.conf /whatap
COPY ./whatap.agent-2.1.1.jar /whatap
COPY ./paramkey.txt /whatap
COPY ./CustomPool.x /whatap/plugin
# Timezone
RUN apk --no-cache add tzdata && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo "Asia/Seoul" > /etc/timezone
ENTRYPOINT exec java $JAVA_OPTS -Dspring.profiles.active=${SERVER_ENV} -Drun.arguments=-namespace=${NAMESPACE} -Dspring.config.location=${CONFIG_NAME} -jar /oc-ext.jar