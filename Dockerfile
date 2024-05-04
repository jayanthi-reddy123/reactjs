# Use official Node.js image as base
FROM node:14-alpine as build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build

# Use lightweight Node.js image for serving
FROM node:14-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy build output from the previous stage
COPY --from=build /usr/src/app/build ./build

# Expose the port the app runs on
EXPOSE 4000

# Command to run the application
CMD ["npm", "run", "start"]
