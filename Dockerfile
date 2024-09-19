ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

ARG GO_VERSION
ENV GO_VERSION=${GO_VERSION}

ARG PROJECT_NAME
ENV PROJECT_NAME=${PROJECT_NAME}

ARG FOLDER_NAME
ENV FOLDER_NAME=${FOLDER_NAME}

RUN apt-get update && apt-get install -y wget git gcc

RUN wget -P /tmp "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" \
    && tar -C /usr/local -xzf "/tmp/go${GO_VERSION}.linux-amd64.tar.gz" \
    && rm "/tmp/go${GO_VERSION}.linux-amd64.tar.gz"

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

WORKDIR /app

COPY ./${FOLDER_NAME} /app

RUN go build -o "/root/${PROJECT_NAME}" cmd/main.go

ENTRYPOINT ["/bin/sh"]
CMD ["-c", "echo 'Build completed. Binary available at /root/${PROJECT_NAME}'"]
