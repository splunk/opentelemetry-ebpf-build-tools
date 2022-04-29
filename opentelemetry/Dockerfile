# opentelemetry

ARG base_IMAGE_TAG
ARG grpc_cpp_IMAGE_TAG

FROM $grpc_cpp_IMAGE_TAG as build-grpc_cpp
FROM $base_IMAGE_TAG

WORKDIR $HOME
COPY opentelemetry-proto opentelemetry-proto
WORKDIR $HOME/opentelemetry-proto

COPY --from=build-grpc_cpp $HOME/install/bin/protoc /usr/local/bin/protoc
COPY --from=build-grpc_cpp $HOME/install/bin/grpc_cpp_plugin /usr/local/bin/protoc-gen-grpc-cpp

# generate c++ grpc client library

RUN PROTO_FILES=$(find ./opentelemetry -name '*.proto'); \
    for PROTO_FILE in ${PROTO_FILES}; do \
      DIR=$(dirname $PROTO_FILE); \
      mkdir -p $HOME/install/$DIR; \
      protoc -I . --cpp_out=$HOME/install ${PROTO_FILE}; \
    done

RUN PROTO_FILES=$(find ./opentelemetry -name '*service.proto'); \
    for PROTO_FILE in ${PROTO_FILES}; do \
      DIR=$(dirname $PROTO_FILE); \
      mkdir -p $HOME/install/$DIR; \
      protoc -I . --cpp_out=$HOME/install --grpc-cpp_out=$HOME/install ${PROTO_FILE}; \
    done
