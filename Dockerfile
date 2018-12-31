FROM golang:1.9.0 as goimage
ENV SRC=/go/src/
RUN mkdir -p /go/src/
WORKDIR /go/src/go-docker
COPY main.go /go/src/go-docker
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep init && dep ensure
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/go-docker


# Start a new build
FROM alpine:latest as baseimagealp
RUN apk add --no-cache bash
RUN apk --no-cache add ca-certificates

ENV WORK_DIR=/docker/bin
WORKDIR $WORK_DIR
COPY --from=goimage /go/src/go-docker/bin/ ./
ENTRYPOINT /docker/bin/go-docker
EXPOSE 3001
