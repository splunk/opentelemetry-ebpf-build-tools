# libuv

ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

ARG NPROC
ARG BUILD_CFLAGS

RUN apt remove -y libuv1
WORKDIR $HOME
COPY libuv libuv
WORKDIR $HOME/libuv
RUN ./autogen.sh
WORKDIR $HOME/build/libuv
RUN $HOME/libuv/configure --prefix=$HOME/install
RUN CFLAGS=`echo ${BUILD_CFLAGS} | sed 's/\\\\ / /g'`; nice make -j$NPROC && make install
