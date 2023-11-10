# Storage in {{ mpg-name }}


{{ mpg-name }} allows you to use network and local storage drives for database clusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure. Local disks are physically located in the database host servers.

{% include [storage-type-nrd](../../_includes/mdb/mpg/storage-type.md) %}


## Selecting disk type during cluster creation {#storage-type-selection}

The number of hosts that can be created along with a {{ PG }} cluster depends on the selected disk type:

* With local SSD (`local-ssd`) or non-replicated SSD (`network-ssd-nonreplicated`) storage, you can create a cluster with three or more hosts.

   Such a cluster will be fault-tolerant.

   Local SSD storage impacts the cost of a cluster: you are charged for it even if it is not running. For more information, refer to the [pricing policy](../pricing.md).

* With network HDD (`network-hdd`) or network SSD (`network-ssd`) storage, you can add any number of hosts within the current quota.

For more information about limits on the number of hosts per cluster, see [{#T}](./limits.md).



## Managing disk space {#manage-storage-space}

When the storage is more than 97% full, the host automatically switches to read-only mode, while all DBs get `DEFAULT_TRANSACTION_READ_ONLY` set to `TRUE` through the `ALTER DATABASE` query.

In this mode, the `INSERT`, `DELETE`, or `UPDATE` queries result in an error.


You can monitor storage usage on cluster hosts [by setting up alerts in {{ monitoring-full-name }}](../operations/storage-space.md#set-alert):


### Recovering a cluster from read-only mode {#read-only-solutions}

Use one of these methods:

* [Increase the storage capacity](../operations/storage-space.md#change-disk-size) so that it exceeds the threshold value. {{ mpg-short-name }} will then disable read-only mode automatically.

* [Disable read-only mode manually](../operations/storage-space.md#read-only-solutions) and free up storage space by deleting some data.

   {% note alert %}

   When doing so, make sure the amount of free disk space never reaches zero. Otherwise, since the fail-safe is disabled, {{ PG }} will crash and the cluster will stop working.

   {% endnote %}

### Automatic increase of storage size {#auto-rescale}

The storage size auto increase feature allows avoiding its overflow and switch of hosts to read-only mode.

Storage size is increased upon reaching a preset threshold that is specified as a percentage of the total storage size. Two thresholds are used:

* First threshold on reaching which storage size will be increased during the next maintenance window.
* Second threshold on reaching which the process of increasing storage size will start immediately.

If both thresholds are set, make sure the second one is higher than the first one.

While increasing storage size, host clusters will be unavailable.

Storage size will be increased to the value set in the respective setting. After the threshold is reached for the first time, the feature will be disabled: if the threshold values are exceeded again, storage size will not be increased. To reactivate the feature, set a new storage size value after the threshold is reached.

You can set up automatic increase of storage size:

* [When creating a cluster](../operations/cluster-create.md).
* [When updating a cluster](../operations/storage-space.md#disk-size-autoscale).

{% include [storage-resize-maintenance](../../_includes/mdb/mpg/storage-resize-maintenance.md) %}
