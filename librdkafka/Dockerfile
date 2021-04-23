# librdkafka

ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

ARG CONFIGURE_DEBUG
ARG NPROC

WORKDIR $HOME
COPY librdkafka librdkafka
WORKDIR $HOME/librdkafka
RUN ./configure --prefix=$HOME/install \
    ${CONFIGURE_DEBUG} \
    --enable-static \
    --enable-zstd \
    --disable-devel \
    --disable-valgrind \
    --disable-refcnt-debug \
    --disable-lz4 \
    --disable-ssl \
    --disable-sasl
RUN nice make -j$NPROC && make install
