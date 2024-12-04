FROM alpine:3.8
RUN apk update
RUN apk add --no-cache nginx
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN chown -R www:www /var/tmp/nginx

# COPY dist /www/
COPY dist/index.html /www/index.html
COPY nginx.conf /etc/nginx/nginx.conf
COPY robots.txt /www/robots.txt

CMD ["nginx", "-g", "daemon off;"]