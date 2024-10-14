# Utilisation de l'image Node pour builder l'application Angular
FROM node:14 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Utilisation de l'image Nginx pour servir l'application Angular
FROM nginx:alpine
COPY --from=build /app/dist/votre-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

