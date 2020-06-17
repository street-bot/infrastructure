FROM alpine

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

EXPOSE 3478

RUN apk update && \
    apk add --no-cache bind-tools coturn

RUN cp turnserver.conf /etc/turnserver.conf

CMD ["/usr/bin/turnserver"]