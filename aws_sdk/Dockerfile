# AWS SDK

ARG openssl_IMAGE_TAG
ARG curl_IMAGE_TAG
ARG base_IMAGE_TAG

FROM $openssl_IMAGE_TAG as build-openssl
FROM $curl_IMAGE_TAG as build-curl
FROM $base_IMAGE_TAG

ARG CMAKE_BUILD_TYPE

COPY --from=build-curl $HOME/install $HOME/install
COPY --from=build-openssl $HOME/install/openssl $HOME/openssl
WORKDIR $HOME
COPY aws-sdk-cpp aws-sdk-cpp
WORKDIR $HOME/build/aws-sdk-cpp
RUN cmake \
	-G Ninja \
	-DCMAKE_INSTALL_PREFIX:PATH=$HOME/install \
	-DCMAKE_CXX_FLAGS="-Wno-redundant-move -Wno-deprecated-copy" \
	-DCUSTOM_MEMORY_MANAGEMENT=0 \
	-DBUILD_SHARED_LIBS=OFF \
	-DBUILD_ONLY="ec2;s3" \
	-DOPENSSL_ROOT_DIR:PATH=$HOME/openssl \
	-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
	$HOME/aws-sdk-cpp
RUN nice ninja && nice ninja install
