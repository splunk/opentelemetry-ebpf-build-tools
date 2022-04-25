# libcurl and curlpp for querying AWS instance metadata

ARG base_IMAGE_TAG
ARG openssl_IMAGE_TAG

FROM $openssl_IMAGE_TAG as benv-openssl
FROM $base_IMAGE_TAG

ARG CMAKE_BUILD_TYPE
ARG CURL_LIBRARY

######################
# openssl dependency #
######################

COPY --from=benv-openssl $HOME/install/openssl $HOME/openssl

########
# curl #
########

WORKDIR $HOME
COPY curl curl
WORKDIR $HOME/build/curl

# note: HAVE_FILE_OFFSET_BITS is unset to avoid GLIBC_2.28 dependency on fcntl64
# in curlx_nonblock()
RUN nice cmake \
  -DCMAKE_INSTALL_PREFIX:PATH=$HOME/install \
	-DBUILD_CURL_EXE=OFF \
	-DBUILD_TESTING=OFF \
	-DCURL_STATICLIB=ON \
	-DHTTP_ONLY=ON \
	-DCMAKE_USE_OPENSSL:BOOL=ON \
	-DOPENSSL_ROOT_DIR:PATH=$HOME/openssl \
	-DCURL_DISABLE_CRYPTO_AUTH:BOOL=ON \
	-DCURL_CA_PATH=auto \
	-DCMAKE_USE_LIBSSH2:OFF=OFF \
	-DENABLE_MANUAL=OFF \
	-DUSE_UNIX_SOCKETS=ON \
	-DHAVE_FILE_OFFSET_BITS="" \
	-DCMAKE_C_FLAGS="-fPIC" \
	-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
	-DCMAKE_DEBUG_POSTFIX="" \
	$HOME/curl
RUN nice make -j$NPROC && nice make -j$NPROC install

##########
# curlpp #
##########

WORKDIR $HOME
COPY curlpp curlpp
WORKDIR $HOME/build/curlpp
RUN nice cmake \
  -DCMAKE_INSTALL_PREFIX:PATH=$HOME/install \
	-DCMAKE_PREFIX_PATH:PATH=$HOME/install \
	-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
	$HOME/curlpp
RUN nice make -j$NPROC && nice make -j$NPROC install
