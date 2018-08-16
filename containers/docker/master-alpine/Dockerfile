FROM alpine:3.7

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 --branch release/1.8 https://github.com/justchain/go-justchain && \
  (cd go-tstereum && make gtst) && \
  cp go-tstereum/build/bin/gtst /gtst && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /go-tstereum && rm -rf /var/cache/apk/*

EXPOSE 8545
EXPOSE 30303

ENTRYPOINT ["/gtst"]
