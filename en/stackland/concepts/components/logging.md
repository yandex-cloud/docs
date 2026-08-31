# Logging Stack

{{ stackland-name }} collects and stores cluster logs using these open-source tools:

* [Loki](https://grafana.com/oss/loki/): Centralized log storage.
* [Fluent Bit](https://fluentbit.io/): Log shipping agent.
* [Grafana](https://grafana.com): Log viewing and analyzing interface.

You can manage log storage and shipping via the `LoggingConfig` [custom resource](#configuration).

## Types of collected logs {#log-streams}

By default, Fluent Bit sends two log streams to Loki:

* Kubernetes API audit logs from `/var/log/audit/kube/kube-apiserver.log` to the `audit` tenant.
* Container logs from the `stackland-*` namespace to the `stackland` tenant.

Container logs from other namespaces are not sent to Loki.

In Grafana, each tenant corresponds to a separate data source:

| Data source | Tenant | Content |
| --- | --- | --- |
| `audit-logs` | `audit` | Kubernetes API audit logs |
| `stackland-logs` | `stackland` | Logs of platform components from `stackland-*` namespaces |
| `audit-logs-legacy` | `audit` | Audit logs from `singleBinary` when both modes are used simultaneously |
| `stackland-logs-legacy` | `stackland` | Platform component logs from `singleBinary` when both modes are used simultaneously |

## Viewing logs in Grafana {#grafana}

The Grafana interface is available at `https://grafana.sys.<cluster domain>`. To sign in, click **Sign in with Stackland Auth**.

Open the **Explore** section and select the `stackland-logs` or `audit-logs` data source. If both `singleBinary` and `simpleScalable` are enabled at the same time, new logs are written to these sources, and the history from `singleBinary` remains available through `stackland-logs-legacy` and `audit-logs-legacy`. The **Logs** app is also available to system logs; it uses the `stackland-logs` source.

By default, queries to both tenants go through an authorization proxy. Access is allowed to the `stackland-cluster-admins` group members. You can edit the list of groups in the `tenantProxy.adminGroups` setting. The `Viewer` or `Editor` roles in Grafana alone do not grant access to logs.

## Storing logs {#storage}

Loki supports two deployment modes:

* `singleBinary`: One Loki instance with data on a PVC.
* `simpleScalable`: Scalable configuration with the `writer`, `reader`, and `backend` components, storing data in internal S3. The [{{ objstorage-name }}](storage.md) component must be enabled to use this mode.

At least one mode must be enabled. When switching between modes, you can temporarily enable them both simultaneously.

`singleBinary` configuration example:

```yaml
logStorage:
  loki:
    singleBinary:
      enabled: true
      storage:
        storageClass: stackland-ssd
        size: 50Gi
      resources:
        requests:
          memory: 1Gi
          cpu: 500m
        limits:
          memory: 2Gi
          cpu: "1"
      limitsConfig:
        retentionPeriod: 30d
        maxLabelNamesPerSeries: 30
      compactor:
        retentionEnabled: true
        retentionDeleteDelay: 2h
```

* `storage.storageClass`: StorageClass for the PVC. If not specified, the cluster's default StorageClass is used.
* `storage.size`: PVC size.
* `resources`: Loki resource requirements.
* `limitsConfig.retentionPeriod`: Log retention.
* `limitsConfig.maxLabelNamesPerSeries`: Maximum number of labels per series.
* `compactor.retentionEnabled`: Enables deletion of expired data.
* `compactor.retentionDeleteDelay`: Delay before data is deleted.

## Managing tenant access {#tenant-proxy}

```yaml
logStorage:
  loki:
    tenantProxy:
      enabled: true
      adminGroups:
        - stackland-cluster-admins
      replicas: 1
      resources:
        requests:
          cpu: 50m
          memory: 64Mi
        limits:
          cpu: 200m
          memory: 256Mi
```

* `enabled`: Sends Grafana queries to Loki through the authorization proxy. By default, the proxy is enabled.
* `adminGroups`: IAM groups whose members can query the `audit` and `stackland` tenants.
* `replicas`: Number of proxy replicas.
* `resources`: Proxy resource requirements.

If `enabled: false`, Grafana connects to Loki directly, without checking user groups.

## Log delivery {#shipment}

```yaml
logSender:
  fluentBit:
    logLevel: info
    sendToStacklandLogStorage: true
    flushInterval: 5s
    bufferSize: 5MB
    resources:
      requests:
        memory: 100Mi
        cpu: 100m
      limits:
        memory: 200Mi
        cpu: 200m
```

* `logLevel`: Fluent Bit logging level: `debug`, `info`, `warn`, and `error`.
* `sendToStacklandLogStorage`: Enables sending to Loki. The default value is `true`.
* `flushInterval`: Interval for shipping accumulated logs.
* `bufferSize`: Fluent Bit buffer size.
* `resources`: Fluent Bit resource requirements.

### Additional outputs {#additional-outputs}

In `fluentBit.outputs`, you can configure up to ten additional `opensearch` and `stdout` outputs. If `sendToStacklandLogStorage: false`, at least one additional output must be enabled.

Example of shipping logs to Loki and OpenSearch simultaneously:

```yaml
logSender:
  fluentBit:
    sendToStacklandLogStorage: true
    outputs:
      - name: opensearch-main
        enabled: true
        type: opensearch
        match: "*"
        opensearch:
          host: opensearch.logging.svc.cluster.local
          port: 9200
          index: stackland-logs
          workers: 2
          retryLimit: 3
```

To connect using TLS and Basic Auth, you can use `opensearch.tls.caSecret`, `opensearch.basicAuth.usernameSecret`, and `opensearch.basicAuth.passwordSecret`. Secrets can reside in any namespace if it is specified in the link; the controller copies the required values to the `stackland-logging` namespace.

## Configuration {#configuration}

Full `LoggingConfig` example:

{% include notitle [YAML-file](../../_includes/yamls/components/loggingconfig.md) %}

### Component status {#status}

The `status` field of the resource displays:

* `datasourceConfigured`: Loki data sources created in Grafana.
* `conditions`: Readiness conditions for the component and probes for additional outputs.
* `message`: Current component status.
* `observedGeneration`: Last processed configuration version.
