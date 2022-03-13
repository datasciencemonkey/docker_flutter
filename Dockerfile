# Install Operating system and dependencies
FROM fischerscode/flutter-sudo
RUN sudo apt-get update && sudo apt-get install -y python3

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web


# Copy files to container and build
RUN sudo mkdir -p /app/
COPY . /app/
WORKDIR /app/
RUN sudo chown -R flutter:flutter /app/
RUN flutter build web

# Record the exposed port
EXPOSE 5000

# make server startup script executable and start the web server
RUN ["chmod", "+x", "/app/server/server.sh"]

ENTRYPOINT [ "/app/server/server.sh"]