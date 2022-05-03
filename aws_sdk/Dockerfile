# AWS SDK

ARG openssl_IMAGE_TAG
ARG curl_IMAGE_TAG
ARG base_IMAGE_TAG
ARG CMAKE_BUILD_TYPE

FROM $openssl_IMAGE_TAG as build-openssl
FROM $curl_IMAGE_TAG as build-curl
FROM $base_IMAGE_TAG

WORKDIR $HOME

COPY aws-sdk-cpp aws-sdk-cpp

COPY --from=build-curl $HOME/install $HOME/curl
COPY --from=build-openssl $HOME/install/openssl $HOME/openssl

WORKDIR $HOME/build/aws-sdk-cpp

RUN cmake \
  -DCUSTOM_MEMORY_MANAGEMENT=0 \
  -DBUILD_SHARED_LIBS=OFF \
  -DBUILD_ONLY="ec2;s3" \
  -DFORCE_CURL=ON \
  -DUSE_OPENSSL=ON \
  -DENABLE_TESTING=OFF \
  -DOPENSSL_ROOT_DIR:PATH=$HOME/openssl \
  -DCMAKE_PREFIX_PATH="$HOME/curl" \
  -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
  -DCMAKE_INSTALL_PREFIX:PATH=$HOME/install \
  $HOME/aws-sdk-cpp

RUN nice make -j$NPROC
RUN nice make install
