# Use the official Nginx image
FROM nginx:latest

# Copy the survey.html file to the Nginx HTML directory
COPY survey.html /usr/share/nginx/html/index.html

# Start listening for traffic to port 80
EXPOSE 80