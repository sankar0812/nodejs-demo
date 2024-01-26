# Stage 1: Build Stage
FROM node:16-alpine as builder
WORKDIR /usr/src/app
COPY nodeapp/* /
RUN npm install
EXPOSE 3000
CMD [ "npm","start" ]

