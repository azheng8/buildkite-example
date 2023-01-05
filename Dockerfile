# Build the manager binary
FROM golang:1.18-alpine

# what is this? to enable foreign functions in c?
ENV CGO_ENABLED=0
RUN mkdir -p /go/src/github.com/playground/buildkite-example
# sets the working directory of the container?
WORKDIR /go/src/github.com/playground/buildkite-example

# necessary for the go build statement?
COPY go.mod .
COPY go.sum .

# Install deps for install tools + deps
RUN apk add gcc bash

# Install deps
# why install as such? to make it more cache friendly when building the program?
RUN go mod download

### Here is where we should separate cached builder from runner

# Copy source
# useful to have the source code? or needed because of the build
# why copy everything? - just easier and not expensive?
COPY . .

# Build
RUN go build -v -o buildkite-example cmd/buildkite-example/main.go

# what does this environment variable do?
# is it overwriteen by other builds?
ENV ENVIRONMENT=local

EXPOSE 8080

# run command??
CMD ["./buildkite-example"]

