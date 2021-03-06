# demangle

ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

ARG CMAKE_BUILD_TYPE
ARG NPROC

WORKDIR $HOME
COPY demangle demangle
WORKDIR $HOME/demangle

RUN cmake "-DCMAKE_INSTALL_PREFIX=$HOME/install" -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE
RUN cmake --build . --target install -j $NPROC --config $CMAKE_BUILD_TYPE
