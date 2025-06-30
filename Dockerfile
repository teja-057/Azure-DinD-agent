#
# Ubuntu Bionic + Docker
#

FROM ubuntu:bionic

# Install required packages for HTTPS repositories
RUN apt-get update && apt-get install --no-install-recommends -y \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg-agent \
       software-properties-common

# Update CA certificates (optional but recommended)
RUN update-ca-certificates

# Add Docker GPG key using --insecure curl to bypass SSL issues in testing
RUN curl -fsSL --insecure https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Verify Docker key fingerprint (optional)
RUN apt-key fingerprint 0EBFCD88

# Add Docker repo with trusted=yes to bypass apt signature check
RUN echo "deb [arch=amd64 trusted=yes] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Disable apt's HTTPS certificate verification globally (for testing only)
RUN echo 'Acquire::https::Verify-Peer "false";' > /etc/apt/apt.conf.d/99verify-peer.conf && \
    echo 'Acquire::https::Verify-Host "false";' >> /etc/apt/apt.conf.d/99verify-peer.conf

# Update package lists and install Docker packages
RUN apt-get update && apt-get install --no-install-recommends -y docker-ce docker-ce-cli containerd.io

# Optional: Upgrade system and install extra utilities you want
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y curl git jq libicu60

# Architecture environment variable
ENV TARGETARCH="linux-x64"

WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT ["/azp/start.sh"]
