# define go image, smaller=more performant
FROM golang:1.21-alpine AS builder

# set necessary env variables
ENV CGO_ENABLED=0 GOOS=linux

# set working directory
WORKDIR /app

# gopy the go.mod and go.sum files and download dependencies
COPY go.mod .
COPY go.sum .
RUN go mod download

# copy the rest of the source code
COPY . .

# build the Go app 
RUN go build -ldflags="-s -w" -o /go-aggregator-service .

# instantiate a "scratch" image (smallest possible image) for final runtime container
FROM scratch

# copy the binary that was built during the builder stage
COPY --from=builder /go-aggregator-service /go-aggregator-service

# run the app
ENTRYPOINT ["/go-aggregator-service"]