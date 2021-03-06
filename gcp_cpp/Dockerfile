# gcp_cpp

ARG base_IMAGE_TAG
ARG openssl_IMAGE_TAG
ARG curl_IMAGE_TAG
ARG grpc_cpp_IMAGE_TAG

FROM $openssl_IMAGE_TAG as benv-openssl
FROM $curl_IMAGE_TAG as benv-curl
FROM $grpc_cpp_IMAGE_TAG as benv-grpc_cpp
FROM $base_IMAGE_TAG

ARG NPROC
ARG CMAKE_BUILD_TYPE

##############
# googleapis #
##############

WORKDIR $HOME
COPY googleapis googleapis

###########################
# google-cloud-cpp-common #
###########################

WORKDIR $HOME
COPY google-cloud-cpp-common google-cloud-cpp-common
WORKDIR $HOME/build/google-cloud-cpp-common

COPY --from=benv-openssl $HOME/install/openssl $HOME/openssl
COPY --from=benv-curl $HOME/install $HOME/curl
COPY --from=benv-grpc_cpp $HOME/install $HOME/grpc_cpp

RUN nice cmake \
  -DCMAKE_INSTALL_PREFIX:PATH=$HOME/install \
  -DBUILD_TESTING=OFF \
  -DGOOGLE_CLOUD_CPP_ENABLE_GRPC_UTILS=OFF \
	-DCMAKE_C_FLAGS="-fPIC" \
  -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
	$HOME/google-cloud-cpp-common
RUN nice make -j$NPROC
RUN nice make -j$NPROC install

####################
# google-cloud-cpp #
####################

WORKDIR $HOME
COPY google-cloud-cpp google-cloud-cpp
WORKDIR $HOME/build/google-cloud-cpp

COPY --from=benv-openssl $HOME/install/openssl $HOME/openssl
COPY --from=benv-curl $HOME/install $HOME/curl
COPY --from=benv-grpc_cpp $HOME/install $HOME/grpc_cpp

RUN nice cmake \
  -DCMAKE_INSTALL_PREFIX:PATH=$HOME/install \
  -DBUILD_TESTING=OFF \
  -DGOOGLE_CLOUD_CPP_ENABLE_BIGTABLE=OFF \
  -DGOOGLE_CLOUD_CPP_ENABLE_STORAGE=OFF \
  -DGOOGLE_CLOUD_CPP_ENABLE_FIRESTORE=OFF \
  -DGOOGLE_CLOUD_CPP_ENABLE_GRPC_UTILS=OFF \
	-DCMAKE_C_FLAGS="-fPIC" \
  -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
	$HOME/google-cloud-cpp
RUN nice make -j$NPROC
#RUN nice make -j$NPROC install
