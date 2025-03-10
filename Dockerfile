# Author: Qasim Shahid  
# Dockerfile for the survey app
# Uses nginx image, copies survey.html to the Nginx HTML directory as index.html and makes it available at port 80 on the container

# Uses the official Nginx image
FROM nginx:latest

# Copy the survey.html file to the Nginx HTML directory
COPY survey.html /usr/share/nginx/html/index.html

# Start listening for traffic to port 80
EXPOSE 80