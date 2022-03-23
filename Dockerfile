FROM quay.io/prometheus/golang-builder:1.16-main as builder

ADD . /go/src/github.com/m-lab/prometheus-bigquery-exporter
WORKDIR /go/src/github.com/m-lab/prometheus-bigquery-exporter

RUN make

FROM debian:bullseye-slim

RUN \
    apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates curl

COPY --from=builder /go/bin/prometheus-bigquery-exporter /bin/prometheus-bigquery-exporter

EXPOSE 9348

ENTRYPOINT  [ "/bin/prometheus-bigquery-exporter" ]
