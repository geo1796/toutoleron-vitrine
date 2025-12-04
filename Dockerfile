# Étape 1 : build Astro
FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Étape 2 : serveur Nginx statique
FROM nginx:1.27-alpine

# On remplace la conf par défaut
COPY nginx.conf /etc/nginx/conf.d/default.conf

# On copie le build Astro
COPY --from=build /app/dist /usr/share/nginx/html

# Nginx écoute déjà sur le port 80