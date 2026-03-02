FROM node:16-alpine AS build
WORKDIR /app
RUN apk add --no-cache git
RUN git clone https://github.com/pelthepu/todo-ui.git .
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL
RUN npm install --legacy-peer-deps --no-audit --no-fund
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]