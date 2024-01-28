FROM redis:4.0.10

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

MAINTAINER martin114@foxmail.com

# Set the working directory to /app
WORKDIR /app

# Copy the custom Redis configuration file into the container at /app
COPY redis.conf /app/redis.conf

# Expose Redis port
EXPOSE 6379

# Start Redis server with custom configuration file
CMD ["redis-server", "/app/redis.conf"]

