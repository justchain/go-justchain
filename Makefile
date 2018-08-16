# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gtst android ios gtst-cross swarm evm all test clean
.PHONY: gtst-linux gtst-linux-386 gtst-linux-amd64 gtst-linux-mips64 gtst-linux-mips64le
.PHONY: gtst-linux-arm gtst-linux-arm-5 gtst-linux-arm-6 gtst-linux-arm-7 gtst-linux-arm64
.PHONY: gtst-darwin gtst-darwin-386 gtst-darwin-amd64
.PHONY: gtst-windows gtst-windows-386 gtst-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

gtst:
	build/env.sh go run build/ci.go install ./cmd/gtst
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gtst\" to launch gtst."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gtst.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Gtst.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gtst-cross: gtst-linux gtst-darwin gtst-windows gtst-android gtst-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gtst-*

gtst-linux: gtst-linux-386 gtst-linux-amd64 gtst-linux-arm gtst-linux-mips64 gtst-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-*

gtst-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gtst
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep 386

gtst-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gtst
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep amd64

gtst-linux-arm: gtst-linux-arm-5 gtst-linux-arm-6 gtst-linux-arm-7 gtst-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep arm

gtst-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gtst
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep arm-5

gtst-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gtst
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep arm-6

gtst-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gtst
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep arm-7

gtst-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gtst
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep arm64

gtst-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gtst
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep mips

gtst-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gtst
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep mipsle

gtst-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gtst
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep mips64

gtst-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gtst
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gtst-linux-* | grep mips64le

gtst-darwin: gtst-darwin-386 gtst-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gtst-darwin-*

gtst-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gtst
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-darwin-* | grep 386

gtst-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gtst
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-darwin-* | grep amd64

gtst-windows: gtst-windows-386 gtst-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gtst-windows-*

gtst-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gtst
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-windows-* | grep 386

gtst-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gtst
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gtst-windows-* | grep amd64
