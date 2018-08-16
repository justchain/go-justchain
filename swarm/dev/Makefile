.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/justchain/go-justchain/cmd/swarm
	go build -o bin/gtst     github.com/justchain/go-justchain/cmd/gtst
	go build -o bin/bootnode github.com/justchain/go-justchain/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/justchain/go-justchain/swarm/...
