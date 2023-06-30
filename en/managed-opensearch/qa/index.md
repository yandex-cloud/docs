---
title: "{{ mos-name }}. Questions and answers"
description: "How do I get the logs of my activity in {{ OS }}? Find the answer to this and other questions in this article."
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

Yes, backup is enabled by default. For {{ mos-name }} clusters, a complete backup is performed once a day, and all the indexes are saved. This helps restore a cluster's state from any available backup.

Backups are kept for 7 days.

#### Which version of {{ OS }} does {{ mos-short-name }} use? {#dbms-version}

The {{ OS }} versions maintained by the vendor are available in {{ mos-short-name }}. For more information, see [{#T}](../concepts/update-policy.md).

#### What happens when a new {{ OS }} version is released? {#new-version}

When a new minor version is released, the cluster software is [automatically updated](../concepts/update-policy.md) after testing. Clusters with an unsupported {{ OS }} version will also be updated automatically.

The owner of the affected clusters will receive a notice of expected work times and database availability.

{% include [logs](../../_qa/logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I set up an alert that is triggered once a certain disk space percentage is used up? {#disk-space-percentage}

[Create an alert](../../managed-opensearch/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mos-name }} cluster.

For `disk.used_bytes`, use notification thresholds. Here are their recommended values:

* `Alarm`: 90% of disk space.
* `Warning`: 80% of disk space.

The thresholds are only set in bytes. For example, here are the recommended values for a disk of 100 GB:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).
