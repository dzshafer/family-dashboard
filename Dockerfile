FROM nginx:alpine

# Copy the dashboard files
COPY index.html /usr/share/nginx/html/index.html
COPY manifest.json /usr/share/nginx/html/manifest.json

# Nginx config: serve with proper headers for ICS CORS + PWA
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
