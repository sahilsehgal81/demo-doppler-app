
# Use an official Node.js runtime as the base image
FROM node:22

# Create a non-root user for security
RUN useradd --user-group --create-home --shell /bin/false appuser

# Switch to the non-root user
USER appuser

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container for dependency installation
COPY --chown=appuser:appuser package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY --chown=appuser:appuser . .

# Expose the port the app runs on
EXPOSE 3000

# Set default environment variable for the app
ENV WEBTEXT="Hello World"

# (Optional) ARG for build-time environment variable
# ARG WEBTEXT

# Define the command to run your app
CMD ["npm", "start"]

