---
title: "{{ mos-name }}. Questions and answers"
description: "How do I get the logs of my activity in Yandex Managed Service for {{ OS }}? Find the answer to this and other questions in this article."
---

# Questions and answers about {{ mos-name }}

## General questions {#general}

#### How are {{ OS }} clusters maintained? {#service-window}

Maintenance in {{ mos-short-name }} implies:

* Automatic installation of {{ OS }} updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mos-short-name }} maintenance activities.

For more information, see [Maintenance](../concepts/maintenance.md).

#### Is cluster backup enabled by default? {#default-backup}

Yes, automatic [backup](../concepts/backup.md) is enabled by default and takes place every hour. All backups are incremental and store only the data that has changed since the previous backup to save storage space.

Automatic backups are stored for two weeks.

#### Which version of {{ OS }} does {{ mos-short-name }} use? {#dbms-version}

The {{ OS }} versions maintained by the vendor are available in {{ mos-short-name }}. For more information, see [{#T}](../concepts/update-policy.md).

#### What happens when a new {{ OS }} version is released? {#new-version}

When a new minor version is released, the cluster software is [automatically updated](../concepts/update-policy.md) after testing. Clusters with an unsupported {{ OS }} version will also be updated automatically.

The owner of the affected clusters will receive a notice of expected work times and database availability.

{% include [logs](../../_qa/logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I set up an alert that is triggered once a certain disk space percentage is used up? {#disk-space-percentage}

[Create an alert](../../managed-opensearch/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mos-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of the disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of the disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85,899,345,920` bytes (80%)

#### Why is a cluster working slowly even though it still has free computing resources? {#throttling}

{% include [throttling](../../_qa/throttling.md) %}

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size or switch to a faster disk type by [restoring the cluster](../operations/cluster-backups.md#restore) from a backup.
