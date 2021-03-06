# support tooling that can't/mustn't be used from the base image's apt repo
# - valgrind

ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

ARG NPROC

# valgrind
WORKDIR $HOME
COPY valgrind valgrind
WORKDIR $HOME/valgrind
RUN ./autogen.sh
RUN ./configure --prefix=$HOME/install
RUN nice make -j$NPROC
RUN make -j$NPROC install
