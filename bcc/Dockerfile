# compile our own bcc

ARG llvm_IMAGE_TAG
FROM $llvm_IMAGE_TAG

ARG CMAKE_BUILD_TYPE
ARG RESTRICTED_NPROC=1

WORKDIR $HOME
COPY bcc bcc
WORKDIR $HOME/build/bcc

# remove reallocarray from stdlib.h, to avoid dependency on GLIBC_2.26
RUN cat /usr/include/stdlib.h | perl -pe 'BEGIN{undef $/;} s/#ifdef __USE_GNU[^#]*reallocarray.*?#endif//smg' > /tmp/stdlib.h && cp /tmp/stdlib.h /usr/include

RUN cmake \
  -G Ninja \
  -DLLVM_DIR:PATH=$HOME/install/lib/cmake/llvm \
	-DCMAKE_INSTALL_PREFIX:PATH=$HOME/install \
	-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
	$HOME/bcc
RUN nice ninja -j $RESTRICTED_NPROC && ninja -j $RESTRICTED_NPROC install
