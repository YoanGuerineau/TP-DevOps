FROM node:latest

WORKDIR /tp/2

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8080

CMD [ "node", "index.js" ]
