# Monitoring

{{ stackland-name }} allows you to set up monitoring for the cluster and platform components with [Prometheus](https://prometheus.io), [Grafana](https://grafana.com), and Alertmanager.

* Prometheus: Tool for collecting metrics from the cluster and platform components.
* Grafana: Interface for viewing and visualizing metrics and logs.
* Alertmanager: Tool for managing alerting rules and sending notifications on issues.

The dedicated [Logging Stack](logging.md) component stores and collects logs. It connects Loki data sources to Grafana.

## Grafana interface {#grafana}

The Grafana interface is available at `https://grafana.sys.<cluster domain>`. To sign in, click **Sign in with Stackland Auth**.

The Monitoring component connects the `prometheus` and `alertmanager` data sources to Grafana. The Logging Stack component adds the `stackland-logs` and `audit-logs` data sources. To check the connected sources, go to **Connections** on the **Data sources** page. To view metrics and logs, open the **Explore** tab.

## Access management {#access}

Based on the [role in the cluster](../../access-management.md), a user will be assigned a global role in Grafana. If the user is a member of the `stackland-cluster-admins` group, they will immediately get administrator permissions in Grafana. If they are a member of the `stackland-cluster-editors` group, they get the `editor` role. If the user is not a group member, they will be assigned the `viewer` role.

Once you log in, you can manage permissions at the level of individual Grafana resources and individual users. You can read more about access management in this [Grafana guide](https://grafana.com/docs/grafana/latest/permissions/).

The tenant proxy of the Logging Stack component additionally checks access to log sources. By default, logs are accessible only by `stackland-cluster-admins` group members. The `Viewer` or `Editor` Grafana roles alone do not grant access to them.

## Metric dashboards {#dashboards}

You can find ready-to-use dashboards on the **Dashboards** tab: the `stackland-monitoring` folder contains dashboards with cluster metrics. You can find dashboards with platform component metrics in other folders, e.g., in `stackland-managed-postgres`.

In addition to the ready-to-use dashboards, you can create your own and add your app metrics to them. For more information about creating dashboards, see [{#T}](../../operations/monitoring/dashboard-create.md).

## Logs {#logs}

On the **Explore** tab, select the `stackland-logs` source to view system logs, or `audit-logs` to view Kubernetes API audit logs. For more information, see [{#T}](../../operations/logging/logs-view.md).

## Alerts {#alerts}

Configuring alerting rules enables you to receive notifications on issues with the cluster or applications. Notifications can be send via email, message queues, or messengers.

Read more about creating notification channels in [{#T}](../../operations/monitoring/alerts-create-contact-point.md).

## Configuration {#configuration}

### General format {#general}

{% include notitle [YAML-file](../../_includes/yamls/components/monitoringconfig.md) %}

#### Monitoring component status {#status}

```yaml
status:
  datasourceConfigured: true
  grafanaReady: true
  s3ExtensionProvisioned: true
  message: Grafana is ready
  observedGeneration: 1
```

* `datasourceConfigured`: Confirms whether the enabled Prometheus and Alertmanager data sources were created in Grafana.
* `grafanaReady`: Grafana is ready for use.
* `s3ExtensionProvisioned`: Indicates that Monitoring is managing the S3 resources used for long-term Thanos metrics storage. The field is `true` if `thanos.longTermStorage.stackland` is defined and the controller started creating associated resources.
* `message`: Grafana status message.
* `observedGeneration`: Active configuration version.

#### General settings {#common-settings}

```yaml
clusterIssuer: stackland-default
```

* `clusterIssuer`: ClusterIssuer name for TLS certificates.

#### Alertmanager {#alertmanager}

```yaml
alertmanager:
  enabled: true
  replicas: 3
  retention: "240h"
  ingressEnabled: true
  storage:
    enabled: true
    storageClass: stackland-ssd
    size: "1Gi"
  resources:
    requests:
      cpu: "100m"
      memory: "256Mi"
    limits:
      cpu: "500m"
      memory: "1Gi"
```

* `enabled`: Enables Alertmanager.
* `replicas`: Number of Alertmanager replicas.
* `retention`: Alertmanager data storage period.
* `storage.enabled`: Enables the PVC for the Alertmanager state. The storage is enabled by default.
* `storage.storageClass`: StorageClass for the PVC. If not specified, the cluster's default StorageClass is used.
* `storage.size`: PVC size. It not specified, `1Gi` is used.
* `ingressEnabled`: Enables access to Alertmanager via Ingress.
* `resources`: Resource requirements.

You cannot change the `storage.enabled`, `storage.storageClass`, and `storage.size` fields after creating `MonitoringConfig`. To change storage, recreate the resource.

#### Grafana {#grafana}

```yaml
grafana:
  enabled: true
  resources:
    requests:
      cpu: "200m"
      memory: "512Mi"
    limits:
      cpu: "1"
      memory: "2Gi"
```

* `enabled`: Enables Grafana.
* `resources`: Resource requirements.

#### Grafana Operator {#grafana-operator}

```yaml
grafanaOperator:
  enabled: true
  resources:
    requests:
      memory: "128Mi"
      cpu: "50m"
    limits:
      cpu: "200m"
      memory: "512Mi"
```

* `enabled`: Enables Grafana Operator.
* `resources`: Resource requirements.


#### Prometheus {#prometheus}

```yaml
prometheus:
  enabled: true
  replicas: 2
  retention: 15d
  ingressEnabled: true
  storage:
    storageClass: stackland-ssd
    size: "10Gi"
  resources:
    requests:
      cpu: "1"
      memory: "2Gi"
    limits:
      cpu: "1"
      memory: "2Gi"
  thanos:
    longTermStorage:
      stackland: {}
```

* `enabled`: Enables Prometheus.
* `replicas`: Number of Prometheus replicas.
* `retention`: Prometheus data storage period.
* `ingressEnabled`: Enables access to Prometheus via Ingress.
* `resources`: Resource requirements.
* `storage.storageClass`: StorageClass for the PVC. If not specified, the cluster's default StorageClass is used.
* `storage.size`: PVC size; local history depth is automatically limited to 80% of the PVC size.
* `thanos.longTermStorage.stackland`: Enables long-term storage of metrics in the internal S3. [{{ objstorage-name }}](storage.md) must be enabled to use the parameter.

You cannot change the `storage.storageClass` and `storage.size` fields after creating `MonitoringConfig`. To change storage, recreate the resource.

#### Hardware monitoring {#hardware-monitoring}

```yaml
hardwareMonitoring:
  enabled: true
  resources:
    requests:
      cpu: "50m"
      memory: "64Mi"
    limits:
      cpu: "200m"
      memory: "256Mi"
```

* `enabled`: Enables collection of hardware status metrics.
* `resources`: Resource requirements for the hardware monitoring agent.
