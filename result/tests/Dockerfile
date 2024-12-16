# Use the official Node.js image as the base image
FROM node:8.9-slim

# Install necessary packages
RUN apt-get update -qq && apt-get install -qy \ 
    ca-certificates \
    bzip2 \
    curl \
    libfontconfig \
    --no-install-recommends

# Install PhantomJS globally using yarn
RUN yarn global add phantomjs-prebuilt

# Add the current directory to /app in the container
ADD . /app

# Set the working directory to /app
WORKDIR /app

# Run the tests script
CMD ["/app/tests.sh"]
