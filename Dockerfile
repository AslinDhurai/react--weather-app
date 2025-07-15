# Stage 1: Build Node.js application
FROM node:latest AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build # Or your specific build command for static assets

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html # Copy built static files
COPY nginx.conf /etc/nginx/conf.d/default.conf # Copy custom Nginx configuration
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
