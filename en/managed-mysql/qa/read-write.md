# Cluster read/write issues

#### Cluster write failure {#write-failure}

1. If database storage becomes 95% full, a cluster changes to **Read only** mode. Check your storage for the amount of free space and increase the storage size as required. To check the amount of free space:
   1. Go to the folder page and select **{{ mmy-short-name }}**.
   1. Click the name of the desired cluster, and go to the **Monitoring** tab.
   1. Check the **Disk usage** chart.
1. Make sure that the host being written to is the master rather than a [replica](mysql.md#read-only-instance).

{% include [qa-replica-lagging](../../_includes/mdb/mmy/qa-replica-lagging.md) %}

#### Cluster size much greater than cluster data {#cluster-greater-data}

This happens because of the way {{ MY }} stores data and not because of {{ mmy-short-name }} in {{ yandex-cloud }}. Factors affecting storage space usage:
* Fragmentation.
* Index fill factor.
* Rollback segment storage.
* Type packaging.

To find out the actual table size within a database, access the `INNODB_SYS_TABLESPACES` system table. For more detail, see [Finding MySQL Table Size on Disk](https://www.percona.com/blog/2016/01/26/finding_mysql_table_size_on_disk).

#### Any application error {#application-error}

1. Check whether there is space available on the disk hosting your cluster:
   1. Go to the folder page and select **{{ mmy-short-name }}**.
   1. Click the name of the desired cluster, and go to the **Monitoring** tab.
   1. Check the **Disk usage** chart.
1. Check host monitoring charts:
   1. Go to the folder page and select **{{ mmy-short-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.
   1. Go to the **Monitoring** page.
   1. Find the problem resource: its plot will be approaching or will have crossed its boundary.
   1. Select the other hosts from the drop-down list and check them as well.
1. Check the virtual machine or the server running the application connecting to your database for available resources.
