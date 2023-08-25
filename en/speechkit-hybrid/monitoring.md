# Monitoring {{ sk-hybrid-name }} services

{{ sk-hybrid-name }} collects and stores metrics in [Prometheus](https://prometheus.io/) format. For more information about metric types, see the [Prometheus documentation](https://prometheus.io/docs/concepts/metric_types/).

{{ sk-hybrid-name }} service metrics are available at the URL:

```text
<IP address>:17002/metrics/prometheus
```

Where:

* `<IP address>`: IP address of the {{ sk-hybrid-name }} service in your network.

## Common {{ sk-hybrid-name }} metrics {#metrics}

| Metric | Type | Description |
|:--------------|:--------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `grpc_code_*` | COUNTER | Number of responses with a certain gRPC status code. Each code refers to a separate metric: `grpc_code_ok`, `grpc_code_canceled`, etc. For a list of codes, see the [gRPC documentation](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) |

## Speech synthesis metrics {#tts-metrics}

| Metric | Type | Description |
|:--------------------|:----------|:-------------------------------------------------------------------------------------------------------|
| `synthesis_sps` | GAUGE | Number of seconds of synthesized text generated in a second at {{ sk-hybrid-name }} runtime |
| `synthesis_latency` | HISTOGRAM | Service response time histogram in milliseconds |

## Speech recognition metrics {#stt-metrics}

| Metric | Type | Description |
|:---------------------|:----------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `in_flight_requests` | GAUGE | Number of active sessions |
| `recognize_sps` | GAUGE | Number of seconds of recognized speech processed in a second at {{ sk-hybrid-name }} runtime |
| `recognize_rtf` | HISTOGRAM | Distribution histogram of a [Real Time Factor](https://devopedia.org/speech-recognition) value that is equal to the ratio of recognition time to the duration of recognized speech expressed as a percentage |

## Performance monitoring {#productivity-monitor}

To monitor {{ sk-hybrid-name }} performance, set the target metric values:

* `synthesis_sps`: Required number of seconds of synthesized text generated in a second.
* `recognize_sps`: Required number of milliseconds of recognized speech generated in a second.
* `synthesis_latency`: Allowed speech synthesis app response delay.
* `recognize_rtf`: Allowed ratio of the time it takes to recognize text to the length of the text itself expressed as a percentage. The recommended value is `100`, as a larger value means that a server cannot handle the stream of requests.

Set up metric monitoring to track their deviation for the worse from the set target values:

* Decrease for SPS metrics.
* Excess for other metrics.
