---
title: "Managed Service for Apache Kafka. Frequently Asked Questions"
description: "How can I get the logs of my work in the managed Apache Kafka service? Answers to this and other questions in this article."
---

# General questions about {{ mkf-name }}

#### What do I do if I get an error like "disk size must be at least ... according to topics partitions number and replication factor but size is ..."? {#disk-size}

The error results from the fact that your topics' log segments take up more space than is available in broker storage. For more information about calculating the required space, see [{#T}](../concepts/storage.md#minimal-storage-size).

To solve the issue, you can [increase the disk size](../operations/cluster-update#change-disk-size) or reduce the [topic](../operations/cluster-topics.md#update-topic) segment or [total cluster](../operations/cluster-update.md#change-kafka-settings) size.

{% include [qa-logs.md](../../_includes/qa-logs.md) %}
