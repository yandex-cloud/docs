# Logging Stack

{{ stackland-name }} enables cluster log collection using these open-source tools:

* [Loki](https://grafana.com/oss/loki/): Centralized log aggregation and storage system.
* [Fluent Bit](https://fluentbit.io/): Log shipper.
* [Grafana](https://grafana.com): Log viewing interface.

You can manage log storage and shipping via the `LoggingConfig` [custom resource](#configuration) settings.

## Viewing logs in Grafana {#grafana}

The Grafana interface is available at `https://grafana.sys.<cluster domain>`. To sign in, click **Sign in with Stackland Auth**.

Loki and Fluent Bit are connected to the interface by default. To start viewing logs in Grafana, create a log collection query in the **Explore** section.

## Storing logs {#storage}

In the custom resource, you can [select a log storage backend, set the retention period, and attach a persistent volume for storage](#storage-settings). Each log storage backend supports additional fine-grained configuration.

## Shipping logs {#shipment}

In the custom resource, you can specify the [log shipping interval and buffer size](#shipment-settings). By default, `defaultOutput` enables Fluent Bit integration with Loki.

## Configuration {#configuration}

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/loggingconfig.md) %}

### Storage settings {#storage-settings}

Here is an example:

```yaml
logStorage:
  backend: loki
  replicas: 1
  resources:
    requests:
      memory: 512Mi
      cpu: 200m
    limits:
      memory: 1Gi
      cpu: 500m
  storage:
    enabled: true
    storageClass: ssd
    size: 50Gi
  retentionPeriod: 7d
  loki:
    limitsConfig:
      maxLabelNamesPerSeries: 20
    compactor:
      retentionEnabled: true
      retentionDeleteDelay: 24h
```

* `backend`: Specifies the type of log storage backend in use.
* `replicas`: Sets the number of pod replicas.
* `resources`: Limits resources (CPU and memory) for the pod.
* `storage`: Defines persistent volume settings for log storage.
* `retentionPeriod`: Sets the log retention period.
* `loki`: Defines advanced configuration options for Loki.

### Log shipment settings {#shipment-settings}

Here is an example:

```yaml
logSender:
  backend: fluent-bit
  flushInterval: 5
  bufferSize: 64MB
  resources:
    requests:
      memory: 128Mi
      cpu: 50m
    limits:
      memory: 256Mi
      cpu: 100m
  fluentBit:
    logLevel: info
    tenantId: prod-team
    defaultOutput: true
```

* `backend`: Specifies the type of log shipping agent in use.
* `flushInterval`: Sets the interval in seconds at which Fluent Bit sends collected logs to the storage backend (e.g., Loki).
* `bufferSize`: Defines the maximum memory volume allocated to Fluent Bit for buffering logs before sending them.
* `resources`: Limits resources (CPU and memory) for the pod.
* `fluentBit`: Defines advanced configuration options for Fluent Bit.
