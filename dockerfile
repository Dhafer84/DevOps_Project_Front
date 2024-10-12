# Étape 1 : Construire l'application Angular
FROM node:16 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de configuration
COPY package.json package-lock.json ./

# Installer les dépendances
RUN npm install

# Copier tout le reste des fichiers
COPY . .

# Construire l'application
RUN npm run build --prod

# Étape 2 : Servir l'application avec NGINX
FROM nginx:alpine

# Copier les fichiers construits dans le répertoire de NGINX
COPY --from=build /app/dist/ /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande pour démarrer NGINX
CMD ["nginx", "-g", "daemon off;"]

