# Importing data to the {{ dataproc-full-name }} cluster using Sqoop

{% include [What is the Sqoop](./header.md) %}

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% note info %}

Place the clusters and the VM instance in the same [cloud network](../../vpc/concepts/network.md).

{% endnote %}

1. {% include [Settings for MPG](./mpg/create.md) %}

1. To import the data to the {{ objstorage-full-name }} bucket:

   1. [Create a bucket](../../storage/operations/buckets/create.md) named `my-bucket`.
   1. [Create a service account](../../iam/operations/sa/create.md) named `bucket-sa`.
   1. [Grant to this service account](../../storage/operations/buckets/edit-acl.md) write permissions for `my-bucket`.

1. [Create a {{ dataproc-full-name }} cluster](../../data-proc/operations/cluster-create.md) in any suitable [configuration](../../data-proc/concepts/instance-types.md).

   {% include [Settings for DataProc cluster](./data-proc-cluster-settings.md) %}

1. [Create a VM instance](../../compute/operations/vm-create/create-linux-vm.md) to connect to the source cluster and {{ dataproc-full-name }}.

1. Set up security groups for the clusters and the VM instance to allow connecting:

   * [To the VM instance and the {{ dataproc-full-name }} cluster](../../data-proc/operations/connect.md).
   * [To the {{ mpg-full-name }} cluster](../../managed-postgresql/operations/connect.md#configuring-security-groups).

## Preparing the source cluster {#prepare}

{% include [Prepare MPG source](./mpg/prepare.md) %}

## Importing the database {#database-import}

To enable [database parallelism](https://sqoop.apache.org/docs/1.4.2/SqoopUserGuide.html#_controlling_parallelism), Sqoop lets you split imported data both by the primary key and other table columns. In the example, the data is split by the `age` column.

Let:

{% include [Shared settings](./shared-properties.md) %}
* {{ mpg-full-name }} cluster ID: `c9qgcd6lplrsjt9jhtuu`.

### Import to {{ objstorage-full-name }} {#import-object-storage}

1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#object-storage).
1. Run the command:

   {% include [Command for MPG](./mpg/storage.md) %}

### Importing data to the HDFS directory {#import-hdfs}

1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#hdfs).
1. Run the command:

   {% include [HDFS for MPG](./mpg/hdfs.md) %}

### Importing data to Apache Hive {#import-hive}

1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#apache-hive).
1. Run the command:

   {% include [HIVE for MPG](./mpg/hive.md) %}

### Importing data to Apache HBase {#import-hbase}

1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#apache-hbase).
1. Run the command:

   {% include [HBASE for MPG](./mpg/hbase.md) %}

## Verify the import {#check}

{% include [Check import](./check-import.md) %}

## Delete created resources {#clear-out}

If you no longer need these resources, delete them:

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. If you reserved a public static IP address for the VM, release and [delete it](../../vpc/operations/address-delete.md).
1. Delete the clusters:

   * [{{ mpg-full-name }}](../../managed-postgresql/operations/cluster-delete.md);
   * [{{ dataproc-full-name }}](../../data-proc/operations/cluster-delete.md).

1. If you created an {{ objstorage-full-name }} bucket, [delete it](../../storage/operations/buckets/delete.md).
