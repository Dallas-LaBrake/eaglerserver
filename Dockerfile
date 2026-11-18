FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Install curl and unzip
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

# Create folders for the Minecraft server and BungeeCord proxy
RUN mkdir -p /app/server /app/bungee/plugins

# 1. Download PaperMC 1.8.8 (The actual Minecraft world)
RUN curl -o /app/server/paper.jar https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar
RUN echo "eula=true" > /app/server/eula.txt

# 2. Download BungeeCord (The proxy)
RUN curl -o /app/bungee/BungeeCord.jar https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar

# 3. Copy configuration files and startup script
COPY server.properties /app/server/server.properties
COPY bungee-config.yml /app/bungee/config.yml
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose the WebSocket port
EXPOSE 8081

CMD ["/app/start.sh"]
