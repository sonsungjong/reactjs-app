# 리액트 빌드
# FROM node:alpine3.18 as build
FROM node:20-alpine3.21 AS build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Nginx 로 서버 실행
FROM nginx:1.25-alpine
# SPA(리액트 라우터)면 아래 conf 필요합니다. 아니면 이 줄 삭제.
# COPY nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/dist .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]