FROM alpine:3.8
MAINTAINER 'heavyflood@gsitm.com'
RUN apk update
RUN apk add --no-cache nginx
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

COPY nginx-player.conf /etc/nginx/nginx.conf
COPY . /www/
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]