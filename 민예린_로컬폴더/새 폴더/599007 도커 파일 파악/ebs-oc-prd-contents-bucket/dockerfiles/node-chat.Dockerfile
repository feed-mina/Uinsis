FROM node:12

WORKDIR /usr/src/app
ARG SERVER_ENV
ENV SERVER ${SERVER_ENV}
COPY package*.json ./
RUN npm install
COPY . ./
#COPY ./package.json .
EXPOSE 8080
CMD ["node", "app.js"]
# CMD ["npm", "run", "start"]