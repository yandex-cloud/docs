# Monitoring

{{ stackland-name }} allows you to set up monitoring for the cluster and platform components with [Prometheus](https://prometheus.io), [Loki](https://grafana.com/oss/loki/), [Fluent Bit](https://fluentbit.io/), and [Grafana](https://grafana.com).

* Prometheus: Tool for collecting metrics from the cluster and platform components.
* Loki: Centralized log aggregation system.
* Fluent Bit: Log shipper.
* Grafana: Interface for viewing and visualizing metrics and logs.
* Alertmanager: Tool for managing alerting rules and sending notifications on issues.

You can extend monitoring capabilities by adding data sources and plugins to work with them.

## Grafana interface {#grafana}

The Grafana interface is available at `https://grafana.sys.<cluster domain>`. To sign in, click **Sign in with Stackland Auth**.

The Loki and Prometheus data sources are connected to it by default. To add new sources or check the connected ones, go to **Connections** on the **Data sources** page. Open the **Explore** tab and select **Metrics** or **Logs** to see what metrics and logs are collected in the cluster.

## Access management {#access}

Based on the [role in the cluster](../../access-management.md), a user will be assigned a global role in Grafana. If the user is a member of the `stackland-cluster-admins` group, they will immediately get administrator permissions in Grafana. If they are a member of the `stackland-cluster-editors` group, they get the `editor` role. If the user is not a group member, they will be assigned the `viewer` role.

Once you log in, you can manage permissions at the level of individual Grafana resources and individual users. You can read more about access management in this [Grafana guide](https://grafana.com/docs/grafana/latest/permissions/).

## Metric dashboards {#dashboards}

You can find ready-to-use dashboards on the **Dashboards** tab: the `stackland-monitoring` folder contains dashboards with cluster metrics. You can find dashboards with platform component metrics in other folders, e.g., in `stackland-managed-postgres`.

In addition to the ready-to-use dashboards, you can create your own and add your app metrics to them. For more information about creating dashboards, see [{#T}](../../operations/monitoring/dashboard-create.md).

## Logs {#logs}

You can view cluster logs on the **Explore** tab in the **Logs** section. Fluent Bit is a default service for log shipment.

## Alerts {#alerts}

Configuring alerting rules enables you to receive notifications on issues with the cluster or applications. Notifications can be send via email, message queues, or messengers.

Read more about creating notification channels in [this section](../../operations/monitoring/alerts-create-rule.md).

## Configuration {#configuration}

### General format {#general}

{% include notitle [YAML-file](../../_includes/yamls/components/monitoringconfig.md) %}

#### Monitoring component status {#status}

```yaml
status:
  datasourceConfigured: true
  grafanaReady: true
  message: Grafana is ready
  observedGeneration: 1
```

* `datasourceConfigured`: Prometheus and Loki are connected to Grafana.
* `grafanaReady`: Grafana is ready for use.
* `message`: Grafana status message.
* `observedGeneration`: Active configuration version.

#### Alertmanager {#alertmanager}

```yaml
alertmanager:
  enabled: true
  ingressEnabled: true
  resources:
    requests:
      cpu: 50m
      memory: 200Mi
```

* `enabled`: Enables Alertmanager.
* `ingressEnabled`: Enables access to Alertmanager via Ingress.
* `resources`: Resource requirements.

#### Grafana {#grafana}

```yaml
grafana:
  enabled: true
  resources:
    limits:
      cpu: 500m
      memory: 1Gi
    requests:
      cpu: 100m
      memory: 256Mi
```

* `enabled`: Enables Grafana.
* `resources`: Resource requirements.

#### Grafana Operator {#grafana-operator}

```yaml
grafanaOperator:
  enabled: true
  resources:
    limits:
      cpu: 500m
      memory: 512Mi
    requests:
      cpu: 100m
      memory: 128Mi
```

* `enabled`: Enables Grafana Operator.
* `resources`: Resource requirements.


#### Prometheus {#prometheus}

```yaml
prometheus:
  enabled: true
  ingressEnabled: true
  resources:
    limits:
      memory: 2Gi
    requests:
      cpu: 100m
      memory: 400Mi
  retention: 10d
```

* `enabled`: Enables Prometheus.
* `ingressEnabled`: Opens the Prometheus web UI via Ingress.
* `resources`: Resource requirements.
* `retention`: Data retention period before deletion.
