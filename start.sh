#!/bin/bash

# Start PaperMC in the background
cd /app/server
java -Xms512M -Xmx512M -jar paper.jar nogui &

# Wait 10 seconds for the world to initialize
sleep 10

# Start BungeeCord in the foreground
cd /app/bungee
java -Xms256M -Xmx256M -jar BungeeCord.jar
