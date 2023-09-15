# Require Maven version 3.9 installed

# Build the backend-gateway-client image
cd ./backend-gateway-client && mvn spring-boot:build-image -Dmodule.image.name=backend-gateway-client && cd ..

# Build the backend-resources
cd ./backend-resources && mvn spring-boot:build-image -Dmodule.image.name=backend-resources && cd ..

# Build the frontend-react, require NodeJS version 16 installed
cd ./frontend-react && npm install && npm run build && cd ..

# Launch the docker-compose
docker compose up -d
