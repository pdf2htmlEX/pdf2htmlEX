# ---------- base system ----------
FROM debian:bookworm

ARG DEBIAN_FRONTEND=noninteractive

# Core packages needed only at build-time + runtime libs
RUN apt update && apt install -y \
    git curl wget make g++ pkg-config cmake \
    autoconf automake libtool dpkg-dev           \
    fontforge poppler-utils                      \
    libpng-dev zlib1g-dev libfreetype6-dev       \
    libjpeg-dev libopenjp2-7-dev                 \
    libxml2-dev gettext jq

WORKDIR /app

# ---------- build pdf2htmlEX ----------
RUN git clone https://github.com/pdf2htmlEX/pdf2htmlEX.git && \
    cd pdf2htmlEX && \
    \
    # 1) nuke all 'sudo ' strings (the scripts assume sudo)
    sed -i 's/sudo //g' buildScripts/* && \
    \
    # 2) drop the obsolete Java-8 dependency ­(not in Bookworm ARM64)
    sed -i '/openjdk-8-jre-headless/d' buildScripts/getBuildToolsApt && \
    \
    # 3) run their meta-build script as root
    ./buildScripts/buildInstallLocallyApt && \
    \
    # ---------- optional clean-up ----------
    # remove big build tool-chains to slim the final image
    apt purge -y \
        git curl wget make g++ pkg-config cmake \
        autoconf automake libtool dpkg-dev build-essential && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /root/.cache

# ---------- default command ----------
ENTRYPOINT ["pdf2htmlEX"]

