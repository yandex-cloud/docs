# Restoring a {{ mpg-name }} cluster after running out of free storage space


## Issue description {#issue-description}

* The {{ mpg-name }} cluster is running in read-only mode.
* Any writes to the cluster's database tables fail.

## Diagnostics and issue reproduction {#issue-diagnostics-and-reproduction}

Go to the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab in the [management console]({{ link-console-main }}), open the `Disk capacity on primary` chart, and review the ratio between the `free` and `used bytes` values to estimate the percentage of cluster storage utilization.

{% note info %}

When the storage is more than 95% full, the host will automatically switch to `read-only` mode. In this case, the `ALTER DATABASE` statement sets the `DEFAULT_TRANSACTION_READ_ONLY = TRUE` flag for all databases.

In this mode, any `INSERT`, `DELETE`, or `UPDATE` operations return an error.

{% endnote %}

## Solution {#issue-resolution}

You can avoid this by setting up an alert to monitor switching to `read-only` mode. To learn more about how to set it up, see [this article on {{ mpg-name }}](../../../managed-postgresql/concepts/storage.md#read-only-monitor).

Upon receiving the alert, you can recover the cluster from this mode in two ways:

* [Expanding the storage size](../../../managed-postgresql/operations/storage-space.md): {{ mpg-name }} will automatically disable `read-only ` mode.
* Manually by following [these steps](../../../managed-postgresql/concepts/storage.md#read-only-solutions).

Currently, there is no way to automatically expand cluster storage.