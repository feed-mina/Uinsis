FROM node:lts-alpine as build-stage
WORKDIR /homepage
COPY package*.json ./
 
#ARG script 
RUN npm install
COPY . .
#RUN npm run $script
RUN npm run build

FROM alpine:3.8
RUN apk update
RUN apk add --no-cache nginx
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build-stage /homepage/dist /www/ 
#COPY --from=build-stage /homepage/dist/* /usr/share/nginx/html
EXPOSE 8081
CMD ["nginx", "-g", "daemon off;"]