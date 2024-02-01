#Dockerfile to build a pdf2htmlEx image

FROM ubuntu

#
#Install git and all dependencies
#
RUN apt update \
	&& apt -y install -qq git cmake autotools-dev libopenjp2-7-dev libtiff5-dev libpng-dev libgif-dev libxt-dev autoconf automake libtool bzip2 libxml2-dev libuninameslist-dev libspiro-dev python-dev libpango1.0-dev libcairo-dev chrpath uuid-dev uthash-dev software-properties-common libpoppler-private-dev libpoppler-glib-dev wget

RUN add-apt-repository ppa:fontforge/fontforge \
	&& apt update \
	&& apt install -y fontforge libfontforge-dev 

RUN wget https://poppler.freedesktop.org/poppler-0.81.0.tar.xz \
	&& tar xvf poppler-0.81.0.tar.xz \
	&& cd poppler-0.81.0 \
	&& mkdir build \
	&& cd build \
	&& cmake \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=/usr \ 
		-DTESTDATADIR=$PWD/testfiles \ 
		-DENABLE_UNSTABLE_API_ABI_HEADERS=ON \
		.. \
	&& make \
	&& make install \
	&& cd ../..

#
#Clone and install the pdf2htmlEX git repo
#
RUN git clone git://github.com/pdf2htmlEX/pdf2htmlEX.git \
	&& cd pdf2htmlEX \
	&& cmake . \
	&& make \
	&& make install

VOLUME /pdf
WORKDIR /pdf

CMD ["pdf2htmlEX"]
