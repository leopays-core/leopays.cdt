FROM ubuntu:18.04

# Arguments that may be overridden by the user
ARG release=latest

# Install required packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    git openssl ca-certificates build-essential libbz2-dev zlib1g-dev libssl-dev \
    libgmp3-dev libicu-dev cmake bc jq curl wget net-tools unzip gnupg graphviz && \
    rm -rf /var/lib/apt/lists/*

# Install CDT from deb package
ADD install_deb.sh /
RUN /install_deb.sh $release && rm -f install_deb.sh

USER root
