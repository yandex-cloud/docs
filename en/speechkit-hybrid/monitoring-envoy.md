# Envoy service monitoring

Envoy services is a collective name of the Envoy and License server {{ sk-hybrid-name }} components For more information about the {{ sk-hybrid-name }} components, see [{#T}](architecture.md).

Envoy services collect and store metrics in Prometheus format. For more information about metric types, see the [Prometheus documentation](https://prometheus.io/docs/concepts/metric_types/).

## License server metrics {#license-metrics}

License server metrics are available at the URL:

```text
<IP address>:<port>
```

Where:

* `<IP address>`: IP address of the License server {{ sk-hybrid-name }} component in your network.
* `<port>`: Prometheus port. The default port is `8003`, you can change it in {{ sk-hybrid-name }} settings.

### Common metrics {#metrics-common}

| Metric | Type | Description | Labels |
|:------------------------|:----------|:----------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `active_services` | GAUGE | Number of running {{ sk-hybrid-name }} services  | `type`, service type: `stt`/`tts`. |
| `log4j2_appender_total` | COUNTER | Number of logs with this level. | `level`, the [logging level](operations/logging.md). |
| `grpc_statuses` | COUNTER | GRPC method status | `app` (application), `method` (GRPC method), `status` (query status). To track the connection with Yandex Billing, in the `method` label, specify the values: `yandex.cloud.ds.billing.BillingService/Register`, `yandex.cloud.ds.billing.BillingService/SendBillingData`. |
| `grpc_durations` | HISTOGRAM | Histogram of the GRPC query processing time | `app` (application), `method` (GRPC method), `status` (query status). |
| `grpc_requests` | GAUGE | Different metrics of GRPC queries | `app` (application), `method` (GRPC method), `status` (query status). |

### Metrics for the Cloud Billing license model {#metrics-cloud-billing}

| Metric | Type | Description | Labels |
|:---------------------------------------|:--------|:-------------------------------------------------------------------------------|:-----------------------------------------|
| `billing_agent_billing_units_sent` | COUNTER | Count of billing packets sent to Yandex Billing | `unit_type`, service type: `stt`/`tts`. |
| `billing_agent_requests_sent` | COUNTER | Number of queries sent to the Cloud Billing server {{ sk-hybrid-name }} |                                          |
| `billing_agent_entries_sent` | COUNTER | Number of billing records sent |                                          |
| `billing_agent_queue_size` | GAUGE | Current Cloud Billing queue size {{ sk-hybrid-name }} |                                          |
| `billing_agent_billing_units_received` | COUNTER | Number of billing packets received from `stt`/`tts` services | `unit_type`, service type: `stt`/`tts`. |
| `billing_agent_last_entry_serial` | GAUGE | Serial number of the last billing record sent |                                          |
| `billing_agent_last_entry_unixtime` | GAUGE | Standard Unix time of the last billing record sent |                                          |

### Metrics for the Yubikey license model {#metrics-yubikey}

| Metric | Type | Description | Labels |
|:---------------------|:------|:-------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------|
| `license_active` | GAUGE | License status (`0` — for inactive license, `1` — for active license) |                                                                                                                                                       |
| `license_parameters` | GAUGE | License options | `type`, parameter type: `max_stt_connections`: Maximum number of connections to `stt` service; `max_tts_rps`: Maximum RPS for the `tts` service |

## Envoy metrics {#envoy-metrics}

To get information about the Envoy service status, use the administrative interface at the URL:

```text
<IP address>:9091
```

Where:

* `<IP address>`: IP address of the Envoy {{ sk-hybrid-name }} service in your network.

To learn more about the interface, see the [Envoy documentation](https://www.envoyproxy.io/docs/envoy/latest/operations/admin).

Envoy metrics in Prometheus format are available via the administrative interface at the URL:

```text
<IP address>:9091/stats/prometheus
```

{% note info %}

To get only significant metrics that changed at least once, use the URL: `<IP address>:9091/stats?format=prometheus&usedonly`.

{% endnote %}

Informative Envoy metrics for {{ sk-hybrid-name }} monitoring:

* [Upstream metrics](https://www.envoyproxy.io/docs/envoy/latest/configuration/upstream/cluster_manager/cluster_stats) for Envoy communications with the `stt`/`tts` service clusters.
* [Downstream metrics](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/stats) for Envoy communications with external resources. e.g.:

   | Metric | Type | Description | Labels |
   |:-------------------------------|:--------|:----------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------|
   | `downstream_cx_total` | COUNTER | Number of HTTP connections during the service operation | `envoy_http_conn_manager_prefix` |
   | `downstream_cx_active` | GAUGE | Number of active HTTP connections. | `envoy_cluster_name`, cluster name: `upstream_stt`, `upstream_tts` for {{ sk-hybrid-name }} services |
   | `downstream_cx_rx_bytes_total` | COUNTER | Amount of information received (in bytes) during the service operation | `envoy_http_conn_manager_prefix` |
   | `downstream_cx_tx_bytes_total` | COUNTER | Amount of information sent (in bytes) during the service operation | `envoy_http_conn_manager_prefix` |
   | `downstream_rq_total` | COUNTER | Numbers of queries sent during the service operation | `envoy_http_conn_manager_prefix` |
   | `downstream_rq_active` | GAUGE | Number of active queries. | `envoy_http_conn_manager_prefix` |
