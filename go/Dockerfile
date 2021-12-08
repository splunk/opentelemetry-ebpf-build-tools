# Golang: grpc, grpc-gateway
ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

# GO grpc and grpc-gateway
RUN /usr/local/go/bin/go get -u \
  google.golang.org/grpc \
  golang.org/x/sys/unix \
  github.com/golang/protobuf/protoc-gen-go

# use v1 branch of grpc-gateway
RUN mkdir -p $HOME/go/src/github.com/grpc-ecosystem && \
  cd $HOME/go/src/github.com/grpc-ecosystem && \
  git clone https://github.com/grpc-ecosystem/grpc-gateway && \
  cd grpc-gateway && git checkout v1 && \
  /usr/local/go/bin/go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
  /usr/local/go/bin/go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

# staticheck linter
RUN /usr/local/go/bin/go get -u honnef.co/go/tools/cmd/staticcheck
