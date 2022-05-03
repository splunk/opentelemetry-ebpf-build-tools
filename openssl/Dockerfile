# OpenSSL
ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

ARG CONFIGURE_RELEASE_DEBUG
ARG NPROC

WORKDIR $HOME
COPY openssl openssl
WORKDIR $HOME/openssl

# remove getentropy() from crypto/rand/rand_unix.c to avoid dependency on GLIBC_2.25
RUN cat crypto/rand/rand_unix.c | perl -pe 'BEGIN{undef $/;} s/extern int getentropy.*?#  endif/\n#  endif/smg' > /tmp/rand_unix.c && cp /tmp/rand_unix.c crypto/rand

RUN ./Configure linux-x86_64 \
	--prefix=$HOME/install/openssl \
	--openssldir=$HOME/install/openssl \
	${CONFIGURE_RELEASE_DEBUG} \
	no-comp no-capieng no-cms no-dgram no-dso no-dynamic-engine \
	enable-ec_nistp_64_gcc_128 no-gost no-psk \
	no-shared no-srp no-srtp no-threads no-ts \
	no-ssl no-ssl3 no-tls1 no-tls1_1 no-dtls \
	no-bf no-blake2 no-camellia no-cast no-idea no-md4 \
	no-mdc2 no-ocb no-rc2 no-rmd160 no-scrypt no-whirlpool
# would also want 	--api=1.1.0  but AWS CLI is built on 1.0.2 API
# no-ui, no-sock conflict with curl
RUN nice make -j$NPROC
RUN nice make install
