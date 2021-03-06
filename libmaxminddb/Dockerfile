# libmaxminddb

ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

ARG CONFIGURE_ENABLE_DEBUG
ARG NPROC

WORKDIR $HOME
COPY libmaxminddb libmaxminddb
WORKDIR $HOME/libmaxminddb
RUN ./bootstrap
RUN ./configure ${CONFIGURE_ENABLE_DEBUG} --prefix=$HOME/install \
    --enable-static
RUN nice make -j$NPROC && make install
