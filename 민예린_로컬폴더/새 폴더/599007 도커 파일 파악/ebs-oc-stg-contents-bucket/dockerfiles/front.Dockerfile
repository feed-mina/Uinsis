#FROM node:14.15.4-alpine as build-stage
#WORKDIR /homepage
#COPY front/* ./
 
#ARG script
#RUN npm install -g vue-cli@2.9.6
#RUN npm install -g cross-env
#RUN apk add g++ make python
#RUN apk update && apk add dh-autoreconf
#RUN yarn add -D imagemin-gifsicle
#RUN npm install -g gifsicle
#RUN npm nuxt install
#RUN npm install
#RUN npm run build

#COPY . .
#RUN npm run $script

FROM alpine:3.8
RUN apk update
RUN apk add --no-cache nginx
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN chown -R www:www /var/tmp/nginx

COPY dist /www/
COPY nginx.conf /etc/nginx/nginx.conf
# COPY dist/* /www/
#COPY --from=build-stage /homepage/dist/* /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]