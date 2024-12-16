FROM node:10-slim

# Modify the sources.list to update the APT sources to use the Debian Archive. 
# The Debian Archive hosts older distributions, ensuring continued access to their packages. 
# This change allows `apt-get update` and subsequent `apt-get install` commands to function correctly for this older release.
RUN echo "deb http://archive.debian.org/debian/ stretch main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list

# Install curl for health checks
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Add Tini for proper signal handling
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

WORKDIR /app

# Install nodemon globally for local development
RUN npm install -g nodemon

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci \
 && npm cache clean --force \
 && mv /app/node_modules /node_modules

# Copy application code
COPY . .

# Set environment variable for the port
ENV PORT 80

# Expose the application port
EXPOSE 80

# Start the application using Tini as the init system
CMD ["/tini", "--", "node", "server.js"]
