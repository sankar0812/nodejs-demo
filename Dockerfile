# Stage 1: Build Stage
FROM node:latest as build

WORKDIR /usr/src/app

COPY nodeapp/package*.json ./
RUN npm install

COPY nodeapp/ .

# Build the application
RUN npm run build

# Stage 2: Production Stage
FROM node:latest

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist /usr/src/app/dist
#COPY --from=build /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=build /usr/src/app/package*.json /usr/src/app/

EXPOSE 3000

CMD ["npm", "start"]

