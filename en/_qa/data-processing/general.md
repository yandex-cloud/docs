#### Which clusters can be moved to a different availability zone? {#new-availability-zone}

You can move [light-weight clusters](../../data-proc/operations/migration-to-an-availability-zone.md) and [HDFS clusters](../../data-proc/tutorials/hdfs-cluster-migration.md).

#### What should I do if data on storage subcluster hosts is distributed unevenly? {#data-unevenly-distributed}

[Connect](../../data-proc/operations/connect.md) to the cluster master host and run this command to rebalance the data:

```bash
sudo -u hdfs hdfs balancer
```

You can configure the load balancer parameters. For example, to change the maximum amount of data to transfer, add the following argument: `-D dfs.balancer.max-size-to-move=<data-size-in-bytes>`.

#### Where can I view {{ dataproc-name }} cluster logs? {#cluster-logs}

You can find cluster logs in its log group. To track the events of a cluster and its individual hosts, specify the relevant [log group](../../logging/concepts/log-group.md) in cluster settings when [creating](../../data-proc/operations/cluster-create.md) or [updating](../../data-proc/operations/cluster-update.md) the cluster. If no log group has been selected for the cluster, a default log group in the cluster directory will be used to send and store logs. For more information, see [{#T}](../../data-proc/operations/logging.md).

{% include [logs](../logs.md) %}

#### Why is the cluster slow even though the computing resources are not used fully? {#throttling}

{% include [throttling](../throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, consider switching to a different cluster with larger host storage or a faster disk type. You can transfer data to a new cluster, for example, using [{{ metastore-full-name }}](../../metadata-hub/concepts/metastore.md).

#### I get the `^M: bad interpreter` error when running the initialization script. How do I fix this? {#syntax-error}

The script runtime environment being Linux (Ubuntu), scripts created in Windows may terminate with the `^M: bad interpreter` error due to using the `CR/LF` new line character (`LF` in Linux). To fix the error, save the script file in Linux format. For more information, see [{#T}](../../data-proc/concepts/init-action.md#syntax-errors).

#### When I run a PySpark job, I get an error related to `com/amazonaws/auth/AWSCredentialsProvider`. How do I fix this? {#sharedPrefixes-property}

If a {{ dataproc-name }} cluster is connected to a {{ metastore-name }} cluster, you may get the following error when running PySpark jobs:

```text
previously initiated loading for a different type with name "com/amazonaws/auth/AWSCredentialsProvider";
```

To fix this, [add](../../data-proc/operations/cluster-update.md) the `spark:spark.sql.hive.metastore.sharedPrefixes` property with the `com.amazonaws,ru.yandex.cloud` value to the {{ dataproc-name }} cluster.

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

This error occurs because the [lightweight clusters](../../data-proc/concepts/index.md#light-weight-clusters) configuration does not include HDFS. To fix the error, [create a cluster](../../data-proc/operations/cluster-create.md) with HDFS support.

We also recommend using [{{ objstorage-full-name }} buckets](../../storage/concepts/bucket.md) to work with jobs. You can [upload scripts to them](../../storage/operations/objects/upload.md) to run jobs. These scripts are stored as objects one can [get links](../../storage/operations/objects/link-for-download.md) to. As a result, you can use links from {{ objstorage-name }} instead of `file:/` format links in your jobs.

#### Why does the `Create {{ dataproc-name }} cluster Error: 0 Address space exhausted` error occur and how do I fix it? {#addresses-exhausted}

The error means that your {{ dataproc-name }} cluster's subnet has run out of IPs that can be allocated to cluster hosts. To check how many IPs are available, [view the list of addresses used](../../vpc/operations/subnet-used-addresses.md) in the subnet and its mask.

To fix the error, do one of the following:

* Delete the unnecessary resources taking up the subnet's IPs.
* Create a subnet with CIDR that suits your cluster's configuration. Next, create a {{ dataproc-name }} cluster in the new subnet.

For more information about subnet sizes, see the [{{ vpc-full-name }}](../../vpc/concepts/network.md#subnet) documentation.

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

1. Review the logs that describe the cluster status over the specified period:

   ```bash
   yc logging read \
      --group-id=<log_group_ID> \
      --resource-ids=<cluster_ID> \
      --filter=log_type=yandex-dataproc-agent \
      --since 'YYYY-MM-DDThh:mm:ssZ' \
      --until 'YYYY-MM-DDThh:mm:ssZ'
   ```

   In the `--since` and `--until` parameters, specify the period boundaries. Time format: `YYYY-MM-DDThh:mm:ssZ`, e.g., `2020-08-10T12:00:00Z`. Use the UTC time zone.

   For more information, see [{#T}](../../data-proc/operations/logging.md).

#### What is the minimum computing power required for a subcluster with a master host? {#master-computing-power}

It depends on the driver deploy mode:

{% include [subcluster-computing-nodes](../../_includes/data-processing/subcluster-computing-nodes.md) %}

In {{ yandex-cloud }}, computing power depends on the host class. For their ratio, see [Host classes](../../data-proc/concepts/instance-types.md).

#### How do I upgrade the image version in {{ dataproc-name }}? {#upgrade}

The service has no built-in mechanism for [image version](../../data-proc/concepts/environment.md) upgrades. To upgrade your image version, create a new cluster.

To make sure the version you use is always up-to-date, [automate](../../data-proc/tutorials/airflow-automation.md) the creation and removal of temporary {{ dataproc-name }} clusters using {{ maf-full-name }}. To run jobs automatically, other than {{ maf-name }}, you can also [use](../../data-proc/tutorials/datasphere-integration.md) {{ ml-platform-full-name }}.

#### How do I run jobs? {#jobs}

There are several ways to do it:

{% include [running-jobs](../../_includes/data-processing/running-jobs.md) %}

#### What security group limits are there? {#security-groups}

You can create no more than five security groups per network. Each group may have a maximum of 50 rules. Learn more about [limits in {{ vpc-full-name }}](../../vpc/concepts/limits.md#vpc-limits).

#### Can I get superuser permissions on hosts? {#connect-root}

Yes. To switch to superuser, enter the following command after connecting to the host:

   ```bash
     sudo su
   ```

However, you do not have to switch to superuser: just use `sudo`.

#### How can I fix the no permission error when connecting a service account to the cluster? {#attach-service-account}

{% include notitle [attach-sa-create-update](../attach-sa-create-update.md) %}