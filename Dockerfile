# # Dockerfile example
# FROM node:18

# WORKDIR /Capsule

# COPY package*.json ./
# RUN npm install

# COPY . .

# EXPOSE 3130  
# CMD ["npm", "start"]


# Use an official Node.js image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port your app runs on
EXPOSE 3130

# Start the application
CMD ["npm", "start"]
