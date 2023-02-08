# Golang: grpc, grpc-gateway
ARG base_IMAGE_TAG
FROM $base_IMAGE_TAG

# protoc-gen-go
RUN /usr/local/go/bin/go install github.com/golang/protobuf/protoc-gen-go@v1.5.2

# protoc-gen-grpc-gateway and protoc-gen-swagger
# use v1 branch of grpc-gateway
RUN mkdir -p $HOME/go/src/github.com/grpc-ecosystem && \
  cd $HOME/go/src/github.com/grpc-ecosystem && \
  git clone https://github.com/grpc-ecosystem/grpc-gateway && \
  cd grpc-gateway && git checkout v1 && \
  /usr/local/go/bin/go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
  /usr/local/go/bin/go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

# staticheck linter
RUN /usr/local/go/bin/go install honnef.co/go/tools/cmd/staticcheck@2023.1
