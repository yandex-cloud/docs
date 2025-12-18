# Troubleshooting disk snapshot creation issues


## Issue description {#issue-description}

When using VM snapshots in {{ compute-name }}, you encounter one or more of the following issues:

* Disk snapshots are not created according to the schedule.
* You cannot create a new disk snapshot.
* You cannot create a new schedule for disk snapshots. 
* When trying to create a disk snapshot, you get the `Limit compute.snapshots.count exceeded` or `Limit compute.snapshots.size exceeded` error.
* When trying to create a new schedule, you get the `Limit compute.snapshotSchedules.count exceeded` error.

## Solution {#case-resolution}

Check the current values for the following quotas: **Number of disk snapshots**, **Total disk snapshot size**, and **Number of schedules for disk snapshots**. Exceeding any of them will cause snapshot creation to fail.

You can [request a quota increase]({{ link-console-quotas }}) using the [management console]({{ link-console-main }}).

{% note info %}

To request a quota increase, your {{ iam-short-name }} account needs the `quota-manager.requestOperator` role for the cloud where you want to increase a quota.

{% endnote %}

For more information on quotas, see [**Quotas and limits for {{ yandex-cloud }} services**](../../../overview/concepts/quotas-limits.md) and the relevant sections and articles for the appropriate service.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the VM for which you were unable to create a snapshot.
1. Full text of the error message.
1. [HAR file](../../../support/create-har.md) with the recorded communication between the browser and {{ yandex-cloud }} servers when trying to create a new snapshot.
