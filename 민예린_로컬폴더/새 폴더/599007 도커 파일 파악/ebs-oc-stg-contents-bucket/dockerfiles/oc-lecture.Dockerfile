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
ENV JAVA_OPTS="-Xmx2g -Xms2g -javaagent:/whatap/whatap.agent-2.1.1.jar -Dwhatap.micro.enabled=true"
COPY ./lecture-0.0.1-SNAPSHOT.jar oc-lecture.jar
COPY ./configfiles/configfiles/lecture/* ./
COPY established/* /


RUN chmod 755 /established.sh
RUN sed -i -e 's/\r$//' /established.sh


RUN true
COPY ./whatap.conf /whatap
RUN true
COPY ./whatap.agent-2.1.1.jar /whatap
RUN true
COPY ./paramkey.txt /whatap
COPY ./CustomPool.x /whatap/plugin

# Timezone
RUN apk --no-cache add tzdata && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo "Asia/Seoul" > /etc/timezone


ENTRYPOINT nohup /established.sh & java $JAVA_OPTS -Dspring.profiles.active=${SERVER_ENV} -Drun.arguments=-namespace=${NAMESPACE} -Dspring.config.location=${CONFIG_NAME} -jar /oc-lecture.jar
