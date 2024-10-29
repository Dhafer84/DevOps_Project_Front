# Étape 1: Utilisation d'une image de node pour construire l'application
FROM node:16 AS build

# Définit le répertoire de travail
WORKDIR /app

# Copie les fichiers de package
COPY package*.json ./

# Installe les dépendances
RUN npm install

# Copie le reste des fichiers de l'application
COPY . .

# Exécute la construction de l'application
RUN npm run build
RUN chmod -R 755 /app/dist

# Étape 2: Création de l'image finale
FROM nginx:alpine

# Copie les fichiers de build vers le répertoire de nginx
COPY --from=build /app/dist/summer-workshop-angular /usr/share/nginx/html

# Expose le port 80
EXPOSE 80

# Démarre nginx
CMD ["nginx", "-g", "daemon off;"]

