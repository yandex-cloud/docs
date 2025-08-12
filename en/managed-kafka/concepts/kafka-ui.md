---
title: '{{ kafka-ui }} for {{ KF }}'
description: In this tutorial, you will learn about the features of {{ kafka-ui }}, a web UI for {{ KF }}.
---

# {{ kafka-ui }} for {{ KF }}

To work with {{ mkf-name }} clusters, you can use {{ kafka-ui }}. It will help you track data streams, troubleshoot issues, manage [brokers](brokers.md), your cluster, [producers and consumers](producers-consumers.md).

Main web UI features:

* Managing [topics](topics.md#topics):
   * Creating, editing, and deleting topics.
   * Updating topic configurations (number of partitions, replication).
   * Monitoring topic sizes and their performance.
   * Viewing metrics for each topic.

* Working with messages:
   * Viewing message content in various formats, e.g., JSON, Avro, Protobuf, or Plain Text.
   * Sending messages to topics.
   * Searching messages by content and metadata.
   * Filtering messages by labels.

* Monitoring [consumers](producers-consumers.md):
   * Viewing consumer groups and their state.
   * Tracking message processing delay (consumer lag).
   * Managing consumer offsets.
   * Monitoring consumer activity.

* Managing a cluster:
   * Viewing information about brokers and their state.
   * Monitoring cluster configuration. 
   * Viewing partitions and their distribution.
   * Viewing performance metrics.

* Additional features:
   * Support for managing multiple clusters.
   * Configuration of authentication and authorization.
   * Data and configuration export.
   * Light and dark UI themes.

For more information on using the web UI, see the [{{ kafka-ui }} for {{ KF }} documentation](https://docs.kafka-ui.provectus.io).

For a step-by-step guide on how to enable {{ kafka-ui }}, see [{#T}](../operations/kafka-ui-enable.md).