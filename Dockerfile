FROM labbsr0x/bb-promster:latest

ENV PILOT_VERSION ""
ADD alert-rules.yml.tmpl /etc/prometheus


FROM golang:alpine as builder
RUN mkdir /build 
ADD ./main.go /build/
WORKDIR /build
RUN apk update
RUN go build -o main .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .
FROM scratch
COPY --from=builder /build/main /app/
WORKDIR /app
CMD ["./main"]