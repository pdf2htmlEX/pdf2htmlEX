FROM amazoncorretto
FROM ubuntu:20.04

RUN echo $ECR_IMAGE_TAG_NONPROD
RUN echo $ARTIFACTORY_USER_NAME
RUN echo $ARTIFACTORY_PASSWORD
RUN echo $BUILD_CHEGG_ENV
RUN echo $SVC_AWS_ACCESS_KEY_ID
RUN echo $SVC_AWS_SECRET_ACCESS_KEY
RUN echo $SVC_AWS_DEFAULT_REGION

RUN echo $CI_PROJECT_DIR
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --configure -a
RUN apt-get clean
RUN apt-get update 
RUN apt-get install -f -y python3
RUN apt-get install dialog apt-utils -y
RUN apt-get install -f -y python3-pip 
RUN apt-get install -f -y python3-setuptools 
RUN apt-get install -f -y wget 
RUN apt-get install -f -y poppler-utils
RUN apt-get install -f -y jq 
RUN apt-get install -f -y zip unzip
RUN apt-get install -f -y ffmpeg
RUN DEBIAN_FRONTEND=noninteractive apt-get install -f -y pdftk-java
RUN apt install -f -y ghostscript
RUN pip3 install --upgrade pip \
    && apt-get clean
RUN pip3 --no-cache-dir install --upgrade awscli

RUN wget https://www.imagemagick.org/download/ImageMagick.tar.gz && \
    tar -xf ImageMagick.tar.gz && \
    cd ImageMagick* && \
    ./configure && \
    make && \
    make install && \
    ldconfig /usr/local/lib

WORKDIR /tmp

COPY . .

RUN ./buildScripts/travisLinuxDoItAll