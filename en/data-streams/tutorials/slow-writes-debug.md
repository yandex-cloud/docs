---
title: Troubleshooting slow writes in {{ yds-full-name }}
description: This tutorial gives a step-by-step description of how to troubleshoot write quota issues in {{ yds-full-name }}.
---

# Troubleshooting slow writes in {{ yds-full-name }}

If you notice a decrease in write speed in {{ yds-full-name }}, the most common cause is reaching the write [limit](../concepts/limits.md#yds-limits).

**There are two main limits that can slow down writes**:
* Maximum write speed per [partition](../concepts/glossary.md#shard); the default is 1 MB/sec.
* Maximum storage space used per topic; depends on {{ ydb-short-name }} database limits.

## Partition write limit

### Diagnostics

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console](https://console.yandex.cloud/), select the folder where you want to change the stream settings.
    1. Select **Data Streams**.
    1. Select the data stream for which you want to check quota usage.
    1. Go to the **Monitoring** tab.
    1. Select the **Quota Usage** tab.
    1. Examine the first chart named **Partition write quota usage max**.

{% endlist %}

If the chart shows that the write quota usage is approaching 100%, this must be what limits your data stream: the system intentionally slows writes down to stay within the allowed maximum.

### Resolution

You cannot increase the write limit for one partition. If you have reached this limit, you can increase the number of partitions in the topic. As a result, data will be written concurrently to multiple partitions, thereby increasing overall throughput.

To increase the number of partitions, edit the data stream settings according to [this guide](../operations/manage-streams.md#edit-data-stream).

## Limit on storage space used in the {{ ydb-short-name }} database

### Diagnostics

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console](https://console.yandex.cloud/), select the folder where you want to change the stream settings.
    1. Select **Data Streams**.
    1. Select the data stream for which you want to check quota usage.
    1. Go to the **Monitoring** tab.
    1. Select the **Quota Usage** tab.
    1. Examine the second chart named **Storage usage**.

{% endlist %}

If the chart shows that the storage space is close to 100% full, write requests most likely fail due to lack of storage space.

### Resolution

To free up space and re-enable writes, do one of the following:

* Manually delete the data you no longer need from the {{ ydb-short-name }} database.
* [Reduce the message retention period for your data stream](../operations/manage-streams.md#edit-data-stream). This will automatically delete old data.
* Increase the storage size limit in {{ ydb-short-name }} to expand the space available for writes. Follow these steps:
    1. In the [management console](https://console.yandex.cloud/), select the folder where you want to change the stream settings.
    1. Select **Data Streams**.
    1. Select the data stream you want to increase the database storage limit for.
    1. Navigate to the data stream's **Overview** page.
    1. Under **Access**, click the link in the **Database** field.
    1. Increase the storage limit according to [this guide](../../ydb/operations/manage-databases.md).
