---
title: "{{ mes-name }}. Questions and answers"
description: "How do I get the logs of my activity in Yandex Managed Service for Elasticsearch? Find the answer to this and other questions in this article."
---

# Questions and answers about {{ mes-short-name }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

## General questions {#general}

#### How are {{ ES }} clusters maintained? {#service-window}

Maintenance in {{ mes-short-name }} implies:

* Automatic installation of {{ ES }} updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mes-short-name }} maintenance activities.

For more information, see [{#T}](../concepts/maintenance.md).

#### Is cluster backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ mes-name }} clusters, a complete backup is performed every hour, and all the indexes are saved. This helps restore a cluster's state from any available backup.

Backups are kept for 7 days.

#### Which version of {{ ES }} does {{ mes-short-name }} use? {#dbms-version}

The {{ ES }} versions maintained by the vendor are available in {{ mes-short-name }}. For more information, see [{#T}](../concepts/update-policy.md).


#### What happens when a new {{ ES }} version is released? {#new-version}

When new versions include only bug fixes (such versions are called _maintenance releases_), the cluster software is automatically updated after a short testing period.

The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.


#### What happens when the {{ ES }} version becomes deprecated? {#dbms-deprecated}

{{ mes-short-name }} automatically notifies cluster owners by email that their {{ ES }} version is approaching end of life.

Clusters running a deprecated version of {{ ES }} are updated according to the [version control policy](../concepts/update-policy.md).

The owners of the affected clusters receive advanced notice of expected work times and DB availability.

{% include [logs](../../_qa/logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I set up an alert that is triggered once a certain disk space percentage is used up? {#disk-space-percentage}

[Create an alert](../../managed-elasticsearch/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mes-name }} cluster.

For `disk.used_bytes`, use notification thresholds. Here are their recommended values:

* `Alarm`: 90% of disk space.
* `Warning`: 80% of disk space.

The thresholds are only set in bytes. For example, here are the recommended values for a disk of 100 GB:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).

#### Why is a cluster working slowly even though it still has free computing resources? {#throttling}

{% include [throttling](../../_qa/throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when you [update your cluster](../operations/cluster-update.md#change-disk-size).

If you are using the `network-hdd` storage type, consider switching to `network-ssd` or `network-ssd-nonreplicated` by [restoring the cluster](../operations/cluster-backups.md#restore) from a backup.
