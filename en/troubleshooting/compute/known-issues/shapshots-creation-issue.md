# Fixing issues with creating disk snapshots



## Issue description {#issue-description}

While working with VM snapshots in Compute Cloud, you encounter one or more of the following issues:

* Disk snapshots are not created according to the schedule.
* You cannot create a new disk snapshot.
* You cannot create a new schedule for disk snapshots.
* When trying to create a disk snapshot, you see this error message: `Limit compute.snapshots.count exceeded` or `Limit compute.snapshots.size exceeded`.
* When trying to create a new schedule, you see this error message: `Limit compute.snapshotSchedules.count exceeded`.

## Solution {#case-resolution}

Check the current values of the `compute.snapshots.count`, `compute.snapshots.size`, and `compute.snapshotSchedules.count` quotas.
The operations to create new snapshots will result in an error if the related quotas are exceeded.
You can create a [request to increase quotas](https://console.cloud.yandex.com/cloud?section=quotas) from the management console.

{% note info %}

To create quota increase requests, your IAM account needs the `quota-manager.requestOperator` role assigned to the cloud where you need to increase the quota.

{% endnote %}

We discuss quotas in more detail on the [Quotas and limits for Yandex Cloud services](../../../overview/concepts/quotas-limits) page and in the relevant sections of the documentation for each of the services.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. The ID of the VM instance for which a snapshot cannot be created.
2. Full text of the error message
3. [HAR file](../../../support/create-har.md) with saved results of browser interaction with Yandex Cloud servers when trying to create a new snapshot.
