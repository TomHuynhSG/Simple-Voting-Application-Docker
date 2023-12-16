FROM node:10-slim

# Modify the sources.list to update the APT sources to use the Debian Archive. 
# The Debian Archive hosts older distributions, ensuring continued access to their packages. 
# This change allows `apt-get update` and subsequent `apt-get install` commands to function correctly for this older release.
RUN echo "deb http://archive.debian.org/debian/ stretch main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security/ stretch/updates main contrib non-free" >> /etc/apt/sources.list

# add curl for healthcheck
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Add Tini for proper init of signals
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

WORKDIR /app

# have nodemon available for local dev use (file watching)
RUN npm install -g nodemon

COPY package*.json ./

RUN npm ci \
 && npm cache clean --force \
 && mv /app/node_modules /node_modules

COPY . .

ENV PORT 80

EXPOSE 80

CMD ["/tini", "--", "node", "server.js"]
