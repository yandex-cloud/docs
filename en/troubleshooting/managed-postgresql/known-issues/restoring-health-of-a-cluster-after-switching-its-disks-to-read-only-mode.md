# Restoring health of a Managed Services for PostgreSQL cluster after its disks become Read Only

## Issue description {#case-description}
The storage in your Managed Services for PostgreSQL cluster has become read-only.
New data is not written to your cluster's database tables.

## Troubleshooting and reproducing issues {#diagnosis-and-reproduction}
Go to the **Monitoring** tab in the cluster management interface, open the `Disk capacity on primary` chart, and look up the ratio between the `free` and `used bytes` values.
This way, you can evaluate the percentage ratio of the cluster storage utilization.

When the storage is more than 97% full, the host automatically switches to `read-only` mode.
For all databases in this case, `DEFAULT_TRANSACTION_READ_ONLY` is set to `TRUE` using the `ALTER DATABASE` query.

`INSERT`, `DELETE`, or `UPDATE` queries result in an error in this mode.

## Solution {#case-resolution}
You can avoid this by setting an alert on switching over to `read-only` mode. You can find the steps to set up such an alert [here](../../../managed-postgresql/concepts/storage.md#read-only-monitor).

When you receive the alert, you can use two methods to disable this mode in your cluster:
- By [expanding the storage size](../../../managed-postgresql/operations/update.md#change-disk-size): in this case, the service will automatically disable the `read-only ` mode.
- Manually, by following this [guide](../../../managed-postgresql/concepts/storage.md#read-only-solutions).

Currently, there is no automatic method to expand cluster storage.
