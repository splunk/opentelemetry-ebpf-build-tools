# c++ grpc, protobuf

ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

ARG BUILD_CFLAGS 
ARG NPROC

WORKDIR $HOME
COPY grpc grpc
WORKDIR $HOME/grpc
# for warnings, see https://github.com/grpc/grpc/issues/15576
RUN REALCFLAGS=`echo ${BUILD_CFLAGS} | sed 's/\\\\ / /g'`; \
	nice make prefix=$HOME/install \
	CXXFLAGS="\${REALCFLAGS} -Wno-error=class-memaccess -Wno-error=ignored-qualifiers -Wno-error=stringop-truncation" \
	CFLAGS="\${REALCFLAGS} -Wno-error=class-memaccess -Wno-error=ignored-qualifiers -Wno-error=stringop-truncation" \
	static install-static install-headers plugins install-plugins

# Also install protobuf (compiler & library)
WORKDIR $HOME/grpc/third_party/protobuf
RUN CFLAGS=`echo ${BUILD_CFLAGS} | sed 's/\\\\ / /g'`; nice make -j$NPROC prefix=$HOME/install install
