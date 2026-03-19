# OTLP in {{ monium-name }}

{{ monium-name }} can receive metrics via [OTLP](https://opentelemetry.io/docs/specs/otlp/) (OpenTelemetry Protocol), which allows you to send telemetry directly from applications using the OpenTelemetry SDK or through the OpenTelemetry Collector.

## Endpoints {#endpoints}

{{ monium-name }} provides the following endpoints for receiving metrics in OTLP format:

#|
|| **Protocol** | **Endpoint** | **Description** ||
|| HTTP | `https://{{ api-host-monium }}/otlp/v1/metrics` | HTTP endpoint for receiving metrics ||
|| HTTP | `https://{{ api-host-monium }}/otlp/v1/logs` | HTTP endpoint for receiving logs ||
|| HTTP | `https://{{ api-host-monium }}/otlp/v1/traces` | HTTP endpoint for receiving traces ||
|| gRPC | `{{ api-host-monium }}:443` | gRPC endpoint for receiving all telemetry ||
|#

The gRPC and HTTP endpoints are fully compatible with the [OTLP specification](https://opentelemetry.io/docs/specs/otlp/).

## Authorization {#authorization}

Requests are authorized using an API key provided in the `Authorization` header:

```
Authorization: Api-Key <API_key>
```

The API key is created for a service account with the `monium.telemetry.writer` role. The key must have the `yc.monium.telemetry.write` scope to write any type of telemetry or one or more of the following for granular access: `yc.monium.metrics.write`, `yc.monium.logs.write`, `yc.monium.traces.write`. [Learn more about creating an API key](../../iam/operations/iam-token/create-for-sa.md).

## Headings {#headers}

### Required headers {#required-headers}

#|
|| **Header** | **Description** | **Example** ||
|| `Authorization` | API key for authentication | `Api-Key AQVN...` ||
|| `x-monium-project` | Project name: {{ monium-name }} | `folder__b1...` ||
|#

### Optional headers {#optional-headers}

#|
|| **Header** | **Description** | **Example** | **Default value** ||
|| `x-monium-cluster` | Cluster name | `production` | `default` ||
|| `x-monium-service` | Service name | `payment-gateway` | `default` ||
|#

## Distribution by shards {#shard-distribution}

{% include [shard-distribution](../../_includes/monium/shard-distribution.md) %}

Learn more about sharding parameters in [Basic terms](../concepts/glossary.md#shard).

## Data compression {#compression}

{{ realtime-api }} supports the following compression types:

#|
|| **Method** | **HTTP header** | **gRPC** | **Recommendation** ||
|| No compression. | – | – | For debugging or for a small data stream ||
|| gzip | `Content-Encoding: gzip` | `grpc-encoding: gzip` | Supported by default ||
|| zstd | `Content-Encoding: zstd` | `grpc-encoding: zstd` | **Recommended**: more efficient in terms of computing resources ||
|#

## Metric type mapping {#metric-type-mapping}

This section maps OpenTelemetry data types to {{ monium-name }} types.

### OTLP metric types {#otlp-types}

OpenTelemetry uses the following metric types:

#|
|| **OTLP type** | **Characteristic** | **Use cases** ||
|| `Gauge` | Instant value | Memory usage, temperature ||
|| `Counter` | Monotonic counter | Number of requests, request size ||
|| `UpDownCounter` | Additive counter | Number of active connections ||
|| `Histogram` | Distribution of values | Request duration, response size ||
|| `Summary` (deprecated) | Quantiles and sum | Latency percentiles ||
|#

### {{ monium-name }} type mapping {#monium-mapping}

{{ monium-name }} converts OTLP types into its internal metric types depending on temporality:

#### Temporality = Delta {#delta-temporality}

#|
|| **OTLP type** | **Monotonicity** | **{{ monium-name }} type** | **Note** ||
|| `Gauge` | — | `GAUGE` | Instant value ||
|| `Sum` | Monotonic | `RATE` | The sum is divided by the interval length in seconds ||
|| `Histogram` | — | `HIST_RATE` for buckets, `GAUGE` for statistics | `name={metric}, bin={bound}` + `name={metric}.count` + `name={metric}.sum` + `name={metric}.min` + `name={metric}.max` ||
|| `Summary` | — | `GAUGE` | `name={metric}.quantile, quantile={q}` + `name={metric}.count` + `name={metric}.sum` + `name={metric}.min` + `name={metric}.max` ||
|#

#### Temporality = Cumulative {#cumulative-temporality}

#|
|| **OTLP type** | **Monotonicity** | **{{ monium-name }} type** | **Note** ||
|| `Gauge` | — | `GAUGE` | Instant value ||
|| `Sum` | Non-monotonic | `GAUGE` | Absolute value of the counter ||
|| `Sum` | Monotonic | `GAUGE` | Absolute value of the counter ||
|| `Histogram` | — | `HIST` for buckets, `GAUGE` for statistics | `name={metric}, bin={bound}` + `name={metric}.count` + `name={metric}.sum` + `name={metric}.min` + `name={metric}.max` ||
|| `Summary` | — | `GAUGE` | `name={metric}.quantile, quantile={q}` + `name={metric}.count` + `name={metric}.sum` + `name={metric}.min` + `name={metric}.max` ||
|#

## Examples of sum processing {#sum-examples}

### Cumulative Sum {#cumulative-sum-example}

#|
|| **Period** | **Increments** | **Sum** | **Value in {{ monium-name }}** | **Type** | **Note** ||
|| #1 | `[1,1,1,2,2,2,3,3]` | 15 | 15 | `GAUGE` | The sum value is used ||
|| #2 | `[3,4,1,2,-15]` | 10 | 10 | `GAUGE` | The sum value is used ||
|| #3 | `[]` | 10 | 10 | `GAUGE` | The last value is saved ||
|#

### Delta Sum, Monotonic {#delta-sum-monotonic-example}

#|
|| **Period** | **Increments** | **Sum, interval** | **Value in {{ monium-name }}** | **Type** | **Note** ||
|| #1 | `[1,1,1,2,2,2,3,3]` | `15, (0, 5]` | 3 (15 / 5) | `RATE` | Sum is divided by interval ||
|| #2 | `[3,4,1,2]` | `10, (5, 10]` | 2 (10 / 5) | `RATE` | Sum is divided by interval ||
|| #3 | `[]` | `0, (10, 15]` | 0 (0 / 5) | `RATE` | Null value ||
|#

Non-monotonic delta sums are typically not used in OpenTelemetry.

## Processing resource attributes {#resource-attributes}

{{ monium-name }} processes OTLP resource attributes as follows:

### Preserved attributes {#preserved-attributes}

The following resource attributes are preserved as metric labels:

**Host attributes** (prioritized from highest to lowest):
* `host`
* `host.name`
* `hostname`

These attributes are saved under the `host` label.

**Environment attributes** (prioritized from highest to lowest):
* `env`
* `deployment.environment.name`
* `deployment.environment`

These attributes are saved under the `env` label.

**Kubernetes and Cloud attributes** (saved without renaming):
* `cloud.availability_zone`
* `cloud.region`
* `container.name`
* `k8s.cluster.name`
* `k8s.container.name`
* `k8s.cronjob.name`
* `k8s.daemonset.name`
* `k8s.deployment.name`
* `k8s.job.name`
* `k8s.namespace.name`
* `k8s.pod.name`
* `k8s.replicaset.name`
* `k8s.statefulset.name`

### Reserved labels {#reserved-labels}

If data point attributes use reserved label names, they are automatically renamed:

#|
|| **Original name** | **Renamed to** ||
|| `project` | `_project_` ||
|| `cluster` | `_cluster_` ||
|| `service` | `_service_` ||
|#

### Other attributes {#other-attributes}

Resource attributes not listed above are discarded.
All data point attributes are preserved as {{ monium-name }} metric labels.

## Data format {#data-format}

{{ monium-name }} supports the **OTLP Protobuf** format for all types of telemetry. The OTLP JSON format is currently supported for logs and traces.

## See also {#see-also}

* [{#T}](otlp-sdk.md)
* [{#T}](opentelemetry.md)
* [OTLP specification](https://opentelemetry.io/docs/specs/otlp/)
* [OpenTelemetry Metrics](https://opentelemetry.io/docs/concepts/signals/metrics/)
