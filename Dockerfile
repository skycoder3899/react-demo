# Step 1: Build React app
FROM node:14 AS build
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . ./
RUN yarn build

# Step 2: Serve the app
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
