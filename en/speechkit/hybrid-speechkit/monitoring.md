# Monitoring {{ sk-hybrid-name }} with Prometheus

{{ sk-hybrid-name }} metrics are available at `{$IP}:17002/metrics/prometheus`.

## {{ sk-hybrid-name }} metric descriptions {#metrics}

* `synthesis_sps`: Seconds per second (SPS). The number of seconds of synthesized text generated per runtime second.
* `synthesis_latency_bucket`: The response time.
* `TYPE grpc_code_*`: The gRPC protocol response codes. See the [documentation](https://grpc.github.io/grpc/core/md_doc_statuscodes.html).

