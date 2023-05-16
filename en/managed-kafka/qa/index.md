---
title: "{{ mkf-name }}. Questions and answers"
description: "How do I get the logs of my activity in Yandex Managed Service for Apache Kafka? Find the answer to this and other questions in this article."
---

# General questions about {{ mkf-name }}

#### What do I do if I get an error like "disk size must be at least ... according to topics partitions number and replication factor but size is ..."? {#disk-size}

The error results from the fact that your topics' log segments take up more space than is available in broker storage. For more information about calculating the required space, see [{#T}](../concepts/storage.md#minimal-storage-size).

To solve the issue, you can [increase the disk size](../operations/cluster-update#change-disk-size) or reduce the [topic](../operations/cluster-topics.md#update-topic) segment or [total cluster](../operations/cluster-update.md#change-kafka-settings) size.

{% include [logs](../../_qa/logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I move a cluster to a different network?

You cannot move a {{ mkf-name }} cluster to another network.

Here is an alternative solution:

1. Create a new cluster with the same configuration in the new network.
1. Use [MirrorMaker](../tutorials/kafka-connectors.md#kf-mirrormaker) to move the topics of the source cluster to the new one.

#### How do I set up an alert that is triggered once a certain disk space percentage is used up? {#disk-space-percentage}

[Create an alert](../../managed-kafka/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mkf-name }} cluster.

For `disk.used_bytes`, use notification thresholds. Here are their recommended values:

* `Alarm`: 90% of disk space.
* `Warning`: 80% of disk space.

The thresholds are only set in bytes. For example, here are the recommended values for a disk of 100 GB:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).
