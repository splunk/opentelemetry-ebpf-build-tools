# compile our own bcc

ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

ARG CMAKE_BUILD_TYPE
ARG RESTRICTED_NPROC=1

RUN apt-get install --no-install-recommends -y zip

WORKDIR $HOME
COPY bcc bcc
WORKDIR $HOME/build/bcc

RUN cmake \
  -G Ninja \
  -DCMAKE_INSTALL_PREFIX:PATH=$HOME/install \
  -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
  -DENABLE_LLVM_SHARED=OFF \
  $HOME/bcc
RUN nice ninja -j $RESTRICTED_NPROC && ninja -j $RESTRICTED_NPROC install
