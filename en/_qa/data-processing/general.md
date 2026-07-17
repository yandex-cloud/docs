#### Which clusters can I move to a different availability zone? {#new-availability-zone}

You can move [lightweight clusters](../../data-proc/operations/migration-to-an-availability-zone.md) and [HDFS clusters](../../data-proc/tutorials/hdfs-cluster-migration.md).

#### What should I do if data is unevenly distributed across storage subcluster hosts? {#data-unevenly-distributed}

[Connect](../../data-proc/operations/connect.md) to the cluster master host and run this command to rebalance the data:

```bash
sudo -u hdfs hdfs balancer
```

You can update the load balancer parameters. For example, to change the maximum amount of data to transfer, add the following argument: `-D dfs.balancer.max-size-to-move=<data-size-in-bytes>`.

#### Where can I view {{ dataproc-name }} cluster logs? {#cluster-logs}

You can find cluster logs in its log group. To monitor the events of a cluster and its hosts, specify the relevant [log group](../../logging/concepts/log-group.md) in the cluster settings when [creating](../../data-proc/operations/cluster-create.md) or [updating](../../data-proc/operations/cluster-update.md) the cluster. If no log group is selected for the cluster, the default log group in the cluster directory will be used for sending and storing logs. For more information, see [{#T}](../../data-proc/operations/logging.md).

{% include [logs](../logs.md) %}

#### Why is my cluster slow even though the computing resources are not fully utilized? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, consider migrating to a different cluster with larger host storage or higher-performance disks. You can migrate data to a new cluster, e.g., using [{{ metastore-full-name }}](../../metadata-hub/concepts/metastore.md).

#### I get the `^M: bad interpreter` error when running the initialization script. How do I fix this? {#syntax-error}

Since the script runtime is Linux (Ubuntu), scripts created in Windows may terminate with the `^M: bad interpreter` error due to using the `CR/LF` new line character (`LF` in Linux). To fix this error, save the script file in Linux format. For more information, see [{#T}](../../data-proc/concepts/init-action.md#syntax-errors).

#### When I run a PySpark job, I get an error related to `com/amazonaws/auth/AWSCredentialsProvider`. How do I fix this? {#sharedPrefixes-property}

If a {{ dataproc-name }} cluster is connected to a {{ metastore-name }} cluster, you may get the following error when running PySpark jobs:

```text
previously initiated loading for a different type with name "com/amazonaws/auth/AWSCredentialsProvider";
```

To fix this, [add](../../data-proc/operations/cluster-update.md) the `spark:spark.sql.hive.metastore.sharedPrefixes` property set to `com.amazonaws,ru.yandex.cloud` to the {{ dataproc-name }} cluster.

#### When using dynamic partition overwrites, I get an error related to `PathOutputCommitProtocol`. How do I fix it? {#dynamic-partition-overwrite}

When data processing uses dynamic partition overwrites, you may get this error:

```text
py4j.protocol.Py4JJavaError: An error occurred while calling o264.parquet.
: java.io.IOException: PathOutputCommitProtocol does not support dynamicPartitionOverwrite
```

To fix it, [add](../../data-proc/operations/cluster-update.md) the following properties to the {{ dataproc-name }} cluster:

* `spark:spark.sql.sources.partitionOverwriteMode : dynamic`
* `spark:spark.sql.parquet.output.committer.class : org.apache.parquet.hadoop.ParquetOutputCommitter`
* `spark:spark.sql.sources.commitProtocolClass : org.apache.spark.sql.execution.datasources.SQLHadoopMapReduceCommitProtocol`

You can also add properties when [creating a job](../../data-proc/operations/jobs.md).

#### Why does the `NAT should be enabled on the subnet` error occur and how do I fix it? {#nat}

This error occurs when trying to create a {{ dataproc-name }} cluster in a subnet with no NAT gateway configured. To fix it, [configure a network for {{ dataproc-name }}](../../data-proc/tutorials/configure-network.md).

#### Why does the `Using fileUris is forbidden on lightweight cluster` error occur and how do I fix it? {#file-uri}

This error occurs because the [lightweight cluster](../../data-proc/concepts/index.md#light-weight-clusters) configuration does not include HDFS. To fix it, [create a cluster](../../data-proc/operations/cluster-create.md) with HDFS support.

We also recommend using [{{ objstorage-full-name }} buckets](../../storage/concepts/bucket.md) to work with jobs. You can [upload scripts](../../storage/operations/objects/upload.md) for running jobs to these buckets. Scripts are stored as objects that can be [linked](../../storage/operations/objects/link-for-download.md). This allows you to use links from {{ objstorage-name }} in your jobs rather than links in `file:/` format.

#### Why does the `Create {{ dataproc-name }} cluster Error: 0 Address space exhausted` error occur and how do I fix it? {#addresses-exhausted}

This error means that your {{ dataproc-name }} cluster's subnet has no free IP addresses available for assignment to cluster hosts. To check how many IP addresses are available, [view the list of addresses used](../../vpc/operations/subnet-used-addresses.md) in the subnet and its mask.

To fix this error, do one of the following:

* Delete unused resources taking up the subnet's IP addresses.
* Create a subnet with a CIDR block that matches your cluster configuration. Next, create a {{ dataproc-name }} cluster in the new subnet.

For more information about subnet sizes, see [this {{ vpc-full-name }} guide](../../vpc/concepts/network.md#subnet).

#### Why is my cluster's status `Unknown`? {#unknown}

If your cluster's status changed from `Alive` to `Unknown`:

1. Make sure you have [set up a network for {{ dataproc-name }}](../../data-proc/tutorials/configure-network.md). For a cluster to run, you need to create and configure the following network resources:

   * Network
   * Subnet
   * NAT gateway
   * Route table
   * Security group
   * Service account for the cluster
   * Bucket to store job dependencies and results

1. Review the logs that describe the cluster state over the specified period:

   ```bash
   yc logging read \
      --group-id=<log_group_ID> \
      --resource-ids=<cluster_ID> \
      --filter=log_type=yandex-dataproc-agent \
      --since 'YYYY-MM-DDThh:mm:ssZ' \
      --until 'YYYY-MM-DDThh:mm:ssZ'
   ```

   In `--since` and `--until`, specify the period boundaries. Use the `YYYY-MM-DDThh:mm:ssZ` time format, e.g., `2020-08-10T12:00:00Z`. Provide all times in UTC.

   For more information, see [{#T}](../../data-proc/operations/logging.md).

#### What is the minimum compute capacity required for a subcluster with a master host? {#master-computing-power}

It depends on the driver deploy mode:

{% include [subcluster-computing-nodes](../../_includes/data-processing/subcluster-computing-nodes.md) %}

In {{ yandex-cloud }}, compute capacity depends on the host class. For their ratio, see [Host classes](../../data-proc/concepts/instance-types.md).

#### How do I upgrade my image version in {{ dataproc-name }}? {#upgrade}

{{ dataproc-name }} has no native mechanism for [image version](../../data-proc/concepts/environment.md) upgrades. To upgrade your image version, create a new cluster.

To make sure you always use the latest version, [automate](../../data-proc/tutorials/airflow-automation.md) the creation and removal of temporary {{ dataproc-name }} clusters using {{ maf-full-name }}. To run jobs automatically, you can [use](../../data-proc/tutorials/datasphere-integration.md) {{ ml-platform-full-name }} alongside {{ maf-name }}.

#### How do I run jobs? {#jobs}

You can do this in several ways:

{% include [running-jobs](../../_includes/data-processing/running-jobs.md) %}

#### What limits apply to security groups? {#security-groups}

You can create no more than five security groups per network. Each group may have a maximum of 50 rules. Learn more about [limits in {{ vpc-full-name }}](../../vpc/concepts/limits.md#vpc-limits).

#### Can I get superuser privileges on hosts? {#connect-root}

Yes. To switch to the superuser, enter the following command after connecting to the host:

   ```bash
     sudo su
   ```

However, you do not have to switch to the superuser: just use `sudo`.

#### How can I fix the no permission error when attaching a service account to a cluster? {#attach-service-account}

{% include notitle [attach-sa-create-update](../attach-sa-create-update.md) %}