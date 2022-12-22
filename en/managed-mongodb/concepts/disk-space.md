# Disk space in {{ mmg-name }}

{% include [mmg-readonly-safeguard.md](../../_includes/mdb/mmg-readonly-safeguard.md) %}

After switching to read-only mode:

* Write operations will not be allowed on the host and only read operations will be possible.
* If the host was PRIMARY before switching to read-only mode, this role will be automatically assigned to one of the SECONDARY hosts in the cluster, because the PRIMARY role requires permission to write to the disk.

If the amount of data in the cluster keeps growing, then all the hosts will switch one by one to read-only mode and the cluster will eventually stop accepting data for writing.

## Monitoring the switch to read-only mode {#read-only-monitor}

If the host switched to read-only mode, you can do the following:
* [Increase the storage space on the host](../operations/update.md#change-disk-size) to go above the threshold value. In this case, {{ yandex-cloud }} will disable read-only mode automatically.
* [Add additional shards to the cluster](../operations/shards.md#add-shard). Read-only mode won't be lifted on this host, but the cluster will be able to continue working normally provided there is free disk space on the other shards.
* Contact [technical support]({{ link-console-support }}) and ask them to temporarily disable read-only mode on this host so that you can manually delete some data. Make sure the amount of free disk space never reaches zero during this time: since the fail-safe is disabled, {{ MG }} will crash and the cluster will be disabled.
* [Force data synchronization](../operations/hosts.md#resetup) between replicas. This can help when a large amount of data was deleted from the cluster, but the disk space was not released (marked as available for reuse).

To avoid having the host switch to read-only mode, we recommend setting up alerts in {{ monitoring-full-name }} to notify you when you are running out of storage space:

1. Open the {{ monitoring-name }} panel. 
{% if audience == "external" %}
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
{% else %}
1. [Create a notification channel](https://docs.yandex-team.ru/solomon/concepts/alerting#channels).
{% endif %}
1. {% if audience == "external" %}[Create an alert](../../monitoring/operations/alert/create-alert.md){% else %}[Create an alert](https://docs.yandex-team.ru/solomon/concepts/alerting#alerts){% endif %} and specify the following in its parameters:
   1. **Yandex.Metrica**: Sequentially select the cloud and folder where the {{ mmg-name }} cluster is located, then specify the parameters `service={{ mmg-name }}`, `name = disk.free_bytes`, and `resource_id=<cluster_id>` (in the latter, select the ID of the {{ mmg-name }} cluster which the alert is configured for).
   1. **Trigger condition**: Select `Less than or equals` and specify the amount of free disk space to trigger the alert:
      1. For clusters with hosts with up to 600 GB, the recommended value is `1G` (1 GB) for `Alarm` and `1500M` (1.5 GB) for `Warning`.
      1. For larger clusters, the recommended value is `6G` (6 GB) for `Alarm` and `10G` (10 GB) for `Warning`.
   1. Open **Additional settings** and specify:
      1. **Evaluation window**: The interval used to calculate the aggregation function.
      1. **Aggregation function**: `Minimum` (the minimum value of free disk space for the period specified in the **Evaluation window** field).
   1. Add the previously created notification channel.
1. Save the alert.
