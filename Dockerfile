#Compile stage
FROM golang:1.14-alpine3.11 AS build-env
ENV CGO_ENABLED 0
RUN apk add --no-cache git
ADD . /go/src/revelapp

# Install revel framework
RUN go get -u github.com/revel/revel
RUN go get -u github.com/revel/cmd/revel
#build revel app
RUN revel build revelapp app dev

# Final stage
FROM alpine:3.8
EXPOSE 9000
WORKDIR /
COPY --from=build-env /go/app /
ENTRYPOINT /run.sh
