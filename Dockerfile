# Stage 1: Build and run tests
FROM node:18-alpine AS build

# Create app directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy the rest of the application source
COPY . .

# Run unit tests
RUN npm run test

# Stage 2: Create the production image
FROM node:18-alpine

# Install necessary dependencies for Puppeteer and adjust permissions
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Create app directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci --omit=dev

# Copy the rest of the application source
COPY . .

# Create a new user with UID 10014
RUN addgroup -g 10014 choreo && \
    adduser --disabled-password --no-create-home --uid 10014 --ingroup choreo choreouser

RUN mkdir -p /usr/src/app/certificates && \
    chown -R 10014:10014 /usr/src/app/certificates && \
    chmod -R 777 /usr/src/app/certificates

# Set environment variable to use Chromium instead of Chrome
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Set a non-root user
USER 10014

# Expose the 8080 port
EXPOSE 8080

CMD [ "node", "index.mjs" ]
