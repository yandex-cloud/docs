# {{ mch-name }}

{{ mch-name }} is a managed service for working with an open-source column-oriented {{ CH }} DBMS. It simplifies database cluster deployment and upgrades, ensures fault tolerance through replication and sharding, and provides backup and monitoring tools.

With {{ mch-name }}, you can:

* Create and recover clusters using the `ClickhouseCluster` custom resource.
* Create one-time backups using the `ClickhouseBackup` custom resource.
* Configure data replication between hosts for high availability.
* Use sharding for horizontal scaling and load distribution.

You can manage integration with {{ CH }} using the `ManagedClickhouseConfig` custom resource settings.

## Component configuration {#managedclickhouseconfig}

The `ManagedClickhouseConfig` resource settings define the {{ mch-name }} component configuration in the cluster, such as the component status (enabled/disabled), operator resources, and default cluster resources.

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/managedclickhouseconfig.md) %}

Settings:

* `enabled`: Enables/disables the component.
* `settings.monitoring.enabled`: Enables/disables monitoring for {{ CH }}.
* `settings.stackland-ch`: `stackland-clickhouse-operator` settings, such as `replicas` standing for the operator pod replica count and `resources` specifying CPU and memory requests and limits.
* `settings.altinity-ch`: `resources` for the `altinity-clickhouse-operator` pod.
* `settings.metrics`: Metric component resources.
* `settings.defaultClickHouseResources`: Default resources for ClickHouse pods if not specified in the `ClickhouseCluster` resource.
* `settings.defaultKeeperResources`: Default Keeper resources if not specified in the `ClickhouseCluster` resource.

## Creating a cluster {#configuration}

Here is an example of a minimal cluster configuration:

{% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/create-cluster-min.md) %}

Where:

* `shards`: Cluster topology. In this example, we will use one shard with default settings.
* `storage`: Disk space settings for storing data.
* `resources`: Limits resources for the {{ mch-name }} pod.
* `keeper`: {{ CH }} Keeper configuration.

## Cluster network access {#network-access}

{{ mch-name }} enables configuring network access to a {{ CH }} cluster at two levels:

* **Cluster endpoint**: Single entry point for connecting to the entire cluster. Requests are automatically distributed across all shards.
* **Shard endpoints**: Direct connection to a specific cluster shard.

### Service types {#service-types}

You can select one of the following service types for each endpoint:

* `None`: No endpoint is created. This option is the default for shards.
* `ClusterIP`: Endpoint is only accessible within the Kubernetes cluster. This option is the default for the cluster endpoint.
* `LoadBalancer`: Endpoint is accessible both within the cluster and externally via a network load balancer.

### Cluster endpoint {#cluster-endpoint}

The system automatically creates a cluster endpoint when you create a {{ CH }} cluster. The default type is `ClusterIP`, which allows access from other Kubernetes pods.

To make the cluster accessible externally, specify the `LoadBalancer` type in the `spec.clickhouse.service` setting.

```yaml
spec:
  clickhouse:
    service: LoadBalancer
```

### Shard endpoints {#shard-endpoints}

By default, shard endpoints are not created, i.e., `service: None`. This helps save resources when direct access to shards is not required.

To create an endpoint for a specific shard, set a service type in the `spec.clickhouse.shards[].service` setting:

```yaml
spec:
  clickhouse:
    shards:
      - id: shard-1
        service: ClusterIP  # access only within the cluster
      - id: shard-2
        service: LoadBalancer  # external access
```

When creating a shard endpoint, a single service is created for the entire shard rather than dedicated services for each replica within the shard.

### Getting connection addresses {#getting-connection-addresses}

After the cluster is created, you can find connection addresses in the `ClickhouseCluster` resource status:

```bash
kubectl get clickhousecluster <cluster_name> -n <project_name> -o jsonpath='{.status.clusterStatus.fqdns}'
```

Response structure:

* `cluster.internal`: Internal FQDN for connecting to the cluster from other pods.
* `cluster.external`: External FQDN for external connections to the cluster (only for `LoadBalancer`).
* `shards[].serviceFqdn.internal`: Internal FQDN for connecting to a specific shard.
* `shards[].serviceFqdn.external`: External FQDN for external connections to the shard (only for `LoadBalancer`).

Internal FQDNs have the `<resource_name>.<project_name>.svc.{{ cluster-domain }}` format and are only available within the Kubernetes cluster.

External FQDNs are created automatically for `LoadBalancer` type services and are available from outside the cluster. Learn more about DNS [here](dns.md).

## Deletion protection {#deletion-protection}

The `spec.deletionProtection` setting in the `ClickhouseCluster` resource prevents accidental deletion of the cluster via the Kubernetes API. With protection enabled (`spec.deletionProtection: true`), the operator rejects any attempt to delete the cluster resource; the `kubectl delete` command and deletion through the management console do not work until protection is disabled.

* The default value is `false`, meaning that protection is disabled.
* To enable or disable deletion protection, set `spec.deletionProtection` as needed when creating or [updating](../../operations/clickhouse/edit-cluster.md) your cluster.
* Protection is limited to the `ClickhouseCluster` resource. It does not apply to operator-created resources, such as `PVC`, `Secret`, and `ConfigMap`.

