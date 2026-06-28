FROM golang:1.25.11-trixie AS builder

#RUN apt-get update && \
#    apt-get install -y --no-install-recommends \
#        git && \
#    apt-get clean && \
#    rm -rf /etc/apt/lists/*

WORKDIR /app
COPY go.mod main.go client.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o go-simple-chat

FROM scratch
COPY --from=builder /app/go-simple-chat /
EXPOSE 9999

ENTRYPOINT ["/go-simple-chat"]

