# Updating ClickHouse cluster settings

If you have a [{{ CH }}](../../concepts/components/clickhouse.md) cluster in your [project](../projects/create-project.md), you can update its settings.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Open the `ClickhouseCluster` resource, e.g., using the `open ch-cluster.yaml` command.
  1. Open the resource file and edit the following properties:

      * `spec.clickhouse.stop`: Stopping a cluster. `true` to stop, `false` to run a cluster.
      * `spec.clickhouse.service`: Service type for the entire cluster. Available values: `None`, `ClusterIP` (default), or `LoadBalancer`.
      * `spec.clickhouse.enableSuperuserAccess`: Enabling superuser access.
      * `spec.clickhouse.superuserSecretRef.name`: Name of the secret with superuser credentials.
      * `spec.clickhouse.resources.requests.cpu`: Number of CPUs requested for the {{ CH }} pod.
      * `spec.clickhouse.resources.requests.memory`: RAM requested for the {{ CH }} pod.
      * `spec.clickhouse.resources.limits.cpu`: Maximum number of CPUs for the {{ CH }} pod.
      * `spec.clickhouse.resources.limits.memory`: Maximum RAM for the {{ CH }} pod.
      * `spec.clickhouse.storage.size`: Storage size for {{ CH }}. You can only increase it.
      * `spec.clickhouse.storage.storageClass`: Storage class for {{ CH }}.
      * `spec.clickhouse.shards[].id`: Shard ID. Updating this parameter will delete the shard together with its data and create a new one with a new name.
      * `spec.clickhouse.shards[].instances`: Number of instances per shard.
      * `spec.clickhouse.shards[].weight`: Shard weight for data distribution.
      * `spec.clickhouse.shards[].service`: Service type for the shard, Available values: `None` (default, no endpoint created), `ClusterIP` or `LoadBalancer`.
      * `spec.keeper.instances`: Number of {{ CH }} Keeper instances.
      * `spec.keeper.resources.requests.cpu`: Number of CPUs requested for the Keeper pod.
      * `spec.keeper.resources.requests.memory`: RAM requested for the Keeper pod.
      * `spec.keeper.resources.limits.cpu`: Maximum number of CPUs for the Keeper pod.
      * `spec.keeper.resources.limits.memory`: Maximum RAM for the Keeper pod.
      * `spec.keeper.storage.size`: Storage size for Keeper. You can only increase it.
      * `spec.keeper.storage.storageClass`: Storage class for Keeper.
      * `spec.backup.schedule`: Backup schedule in cron format.
      * `spec.backup.storage.type`: Storage type for backups, e.g., `stackland-storage`.
      * `spec.backup.storage.stacklandStorage`: Stackland Storage settings for backups.

  1. Apply the manifest: `kubectl apply -f ch-cluster.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **{{ CH }} Clusters**.
  1. Select a cluster.
  1. Click **Edit**.
  1. Edit the following fields:

      **Basic parameters**

      * **Cluster name**: Only lowercase letters, numbers, and hyphens.
      * **Version**: {{ CH }} DBMS version.
      * **Cluster service type**: Service type for accessing the entire cluster. Available values: `ClusterIP` (access only within the cluster) or `LoadBalancer` (access from outside).

      **Storage**

      * **Storage class**: Storage class for {{ CH }} data.
      * **Storage size**: Data storage size. You can only increase it.

      **Settings**

      * Expanding section for addition of custom {{ CH }} settings. Click **+ Add setting** to add a name-value pair.

      **Resources**

      * **Requested CPUs**: Number of CPUs requested for the {{ CH }} pod.
      * **Requested RAM**: RAM requested for the {{ CH }} pod.
      * **CPU limit**: Maximum number of CPUs for the {{ CH }} pod.
      * **RAM limit**: Maximum RAM for the {{ CH }} pod.

      **Shards**

      For each shard, e.g., `shard-1` or `shard-2`, you can configure:

      * **Shard ID**: Shard ID.
      * **Shard weight**: Shard weight for data distribution (from 0 to 100).
      * **Number of replicas**: Number of replicas per shard (from 0 to 10).
      * **Shard service type**: Service type for access to the shard. Available values: `Disabled` (no endpoint is created), `ClusterIP` (access only within the cluster), or`LoadBalancer` (access from outside).
      * **Override**: Expanding section for overriding the settings of a particular shard:
        * **Storage**: Overriding the shard's storage class and size.
        * **Resources**: Overriding the shard’s computing resources (CPUs and RAM).
        * **Settings**: Overriding the shard’s custom settings.
      * **Delete shard**: Shard deletion button.

      Click **+ Add shard** to add a new shard to the cluster.

      **Superuser**

      * **Allow access**: Switch to allow superuser access to the cluster.

      **{{ CH }} Keeper**

      * **Number of instances**: Number of {{ CH }} Keeper instances for cluster coordination (1, 3, 5, or 7).
      * **Keeper host class**: Computing resources and storage for Keeper. Displays information about storage, CPUs and RAM.

      **Backup configuration**

      * **Enable automatic backups**: Switch to enable automatic backups.
      * **Backup schedule**: Backup schedule in cron format, e.g., `0 0 * * * *`.
      * **Delta backups between complete ones**: Number of incremental backups between complete ones (from 3 to 10).

  1. Click **Save**.

{% endlist %}

This is it, your cluster settings have been updated.
