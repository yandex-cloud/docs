# Creating a {{ mch-name }} cluster

If you have a [project](../projects/create-project.md), you can create a [{{ CH }}](../../concepts/components/clickhouse.md) cluster in it.

## Using the CLI {#cli}

1. If the project does not exist yet, create it: `kubectl create namespace <project name>`.
1. Create the `ClickhouseCluster` resource file, e.g., using the `touch clickhousecluster.yaml` command.
1. Open the file and paste the configuration below into it:

    {% list tabs %}

    - Minimum configuration

        {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/create-cluster-min.md) %}

    - Configuration with backup (stackland-storage)

        This option explicitly names the storage type, `spec.backup.storage.type: stackland-storage`, i.e., the bucket and access keys are created by the operator. You only need to create a superuser secret. Optionally, substitute the schedule into `spec.backup.schedule` (in [CRON expression format](https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format)) and then fill out the `spec.backup.retention` section to limit the number of backups and their retention period in S3.

        {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/create-cluster-max.md) %}

    - Backup to S3 (type: s3)

        This option explicitly names the storage type, `spec.backup.storage.type: s3`, for an S3-compatible bucket. Create a secret with the access credentials for the bucket and a superuser secret. Substitute the bucket name, endpoint into the example and, optionally, schedule into `spec.backup.schedule`, and fill out the `spec.backup.retention` section to limit the number of backups and their retention period in S3.

        {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/create-cluster-backup-s3.md) %}

    {% endlist %}

1. Apply the manifest: `kubectl apply -f clickhousecluster.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Click **Create**.
1. Fill out the fields as follows:

    **Basic parameters**

    * **Cluster name**: Cluster name. Only use lowercase letters, numbers, and hyphens.
    * **Version**: {{ CH }} version. Select from the list of available versions.
    * **Cluster service type**: Service type for accessing the entire cluster. Available values: `ClusterIP` (access only within the cluster, default) or `LoadBalancer` (access from outside).

    **Storage**

    * **Storage class**: `stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`. Learn more about storage classes in [Disk subsystem](../../concepts/components/disk-storage.md#storage-classes).
    * **Storage size**: Size of the disk used to store data. Once created, the disk size can only be increased.

    **Settings** (drop-down section)

    **Resources**

    * **Requested CPU**: Guaranteed amount of computing resources.
    * **Requested memory**: Guaranteed amount of RAM.
    * **CPU limit**: Maximum amount of computing resources.
    * **Memory limit**: Maximum amount of RAM.

    **Shards**

    List of cluster shards. By default, one `shard-1` is created. You can add additional shards by clicking **Add shard**.

    For each shard, you can configure:

    * **Shard ID**: Shard ID.
    * **Shard weight**: Shard weight for data distribution.
    * **Number of replicas**: Number of replicas in the shard.
    * **Shard service type**: Service type for access to the shard. Available values: `Do not create service` (no endpoint is created, default), `ClusterIP` (access only within the cluster), or `LoadBalancer` (access from outside).

    **Superuser**

    * **Allow access**: Switch to allow creating a superuser.
    * **Name**: Superuser name for access to the database.
    * **Password**: Superuser password. You can generate it automatically by clicking **Generate**.

    **{{ CH }} Keeper**

    * **Number of Keeper instances**: Number of {{ CH }} Keeper instances for fault tolerance.
    * **Keeper host class**: Resource configuration for Keeper instances (storage, CPU, memory).

    **Backup configuration**

    * **Enable automatic backups**: Switch to enable automatic backups to the S3 bucket.

1. Click **Create**.

Done. The cluster has now appeared in the **{{ CH }} Clusters** list.

## Connecting to a cluster {#connect}

To connect to a cluster, use the host FQDN in `<cluster_name>.<project_name>.svc.>.{{ cluster-domain }}` format.

### clickhouse-client {#clickhouse-client}

Install the client.

```bash
sudo apt update && sudo apt install --yes clickhouse-client
```

Connect to the cluster:

```bash
clickhouse-client --host <cluster_name>.<project_name>.svc.{{ cluster-domain }} \
                  --user <username> \
                  --database <DB_name> \
                  --port 9000 \
                  --ask-password
```

### HTTP interface {#http}

Run the following request via HTTP:

```bash
curl --header "X-{{ CH }}-User: <username>" \
     --header "X-{{ CH }}-Key: <password>" \
     'http://<cluster_name>.<project_name>.svc.{{ cluster-domain }}:8123/?database=<database_name>&query=SELECT%20version()'
```

{% note info %}

For the first connection, use the `clickhouse` database and the superuser name specified when creating the cluster.

{% endnote %}

## Getting addresses for connection {#get-connection-addresses}

After you create a cluster, you can get addresses (FQDNs) for connection to the cluster and individual shards.

### Getting an FQDN via the CLI {#get-fqdn-cli}

Run this command:

```bash
kubectl get clickhousecluster <cluster_name> -n <project_name> -o jsonpath='{.status.clusterStatus.fqdns}'
```

The result contains the following:

* `cluster.internal`: Internal FQDN for connecting to the entire cluster from other pods in Kubernetes.
* `cluster.external`: External FQDN for external connections to the cluster (only available if `spec.clickhouse.service` is set to `LoadBalancer`).
* `shards[].serviceFqdn.internal`: Internal FQDN for connecting to a specific shard.
* `shards[].serviceFqdn.external`: External FQDN for external connections to a shard (only available if `spec.clickhouse.shards[].service` is set to `LoadBalancer`).

Result example:

```json
{
  "cluster": {
    "internal": "ch-sample.my-project.svc.example.com",
    "external": "ch-sample.svc.example.com"
  },
  "shards": [
    {
      "id": "shard-1",
      "serviceFqdn": {
        "internal": "ch-sample-shard-1.my-project.svc.example.com",
        "external": "ch-sample-shard-1.svc.example.com"
      }
    }
  ]
}
```

### Getting an FQDN via the management console {#get-fqdn-console}

1. Open your project.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. On the **Overview** tab, under **Cluster overview** and **<shard name> shard**, you will see the addresses for connection.

{% note info %}

Internal FQDNs have the `<resource_name>.<project_name>.svc.{{ cluster-domain }}` format and are only available within the Kubernetes cluster.

External FQDNs are created automatically for `LoadBalancer` type services and are available from outside the cluster. Learn more about DNS [here](../../concepts/components/dns.md).

{% endnote %}
