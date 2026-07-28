# Build stage - installs dependencies in a clean environment
FROM node:20-lts-alphine as build

WORKDIR /app

COPY package*.json ./
RUN npm install --production


COPY . .


# Runtime stage - copies only what's needed to run the app, not the build tooling
FROM node:20-lts-alphine

WORKDIR /app

COPY --from=build /app ./

EXPOSE 8080

CMD ["node", "server.js"]