# Base image
FROM alpine:3.17

# Install applications
RUN apk add --no-cache \
    ca-certificates \
    curl \
    git \
    jq \
    openssh

# Setup jenkins user
RUN /bin/ash -c 'adduser -h /home/jenkins -g jenkins -s /bin/ash -D -u 1000 jenkins;'
