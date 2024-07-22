FROM node:18 AS build

WORKDIR /app

COPY package.json ./
COPY scripts/ ./scripts/

RUN npm install

COPY . .

ARG ENV=dev
RUN npm run build:$ENV

FROM nginx:alpine AS final

WORKDIR /usr/share/nginx/html

COPY --from=build /app/dist/$ENV .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

