FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    sudo \
    zip \
    libglib2.0-dev \
    libgio-2.0 \
    libxml2-dev

COPY . /app
WORKDIR /app

ENV UNATTENDED="-y"

RUN buildScripts/getBuildToolsApt
RUN buildScripts/buildInstallLocallyApt

ENTRYPOINT ["bash"]
