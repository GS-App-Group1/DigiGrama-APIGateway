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

# Set permissions
USER root
RUN chmod -R 777 /usr/src/app
USER 10014

# Grant permissions to create child processes
CMD [ "node", "--unhandled-rejections=strict", "--no-warnings", "index.mjs" ]
