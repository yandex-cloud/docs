#### Why do cluster writes fail? {#write-failure}

1. If the database storage reaches 95% capacity, the cluster will switch to read-only mode. Check the amount of free space in your storage and increase the storage size, if required. To check the amount of free space:
   1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}** tab.
   1. Check the **Disk usage** chart.
1. Make sure all writes target the master host, not a [replica](../../managed-mysql/qa/mysql.md#read-only-instance).

{% include [qa-replica-lagging](../../_includes/mdb/mmy/qa-replica-lagging.md) %}

#### Why is the cluster size a lot larger than the amount of data it stores? {#cluster-greater-data}

This occurs because of {{ MY }} storage features, not due to {{ mmy-short-name }} in {{ yandex-cloud }}. The following factors affect the amount of storage used:
* Fragmentation
* Index fill factor
* Rollback segment storage
* Data type packing

To find out the actual size of database tables, use the `INNODB_SYS_TABLESPACES` system table. For more information, see [Finding MySQL table size on disk](https://www.percona.com/blog/2016/01/26/finding_mysql_table_size_on_disk).

#### What should I do in case of an application error? {#application-error}

1. Check whether the disk hosting your cluster has enough free space:
   1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}** tab.
   1. Check the **Disk usage** chart.
1. Check host monitoring charts:
   1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
   1. Go to the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}** page.
   1. Find the resource in question: its chart will be approaching or crossing the limit.
   1. Select the other hosts from the drop-down list and check them as well.
1. Check the VM or the server running the application connecting to your database for available resources.
