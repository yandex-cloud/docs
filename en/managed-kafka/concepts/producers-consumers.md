---
title: Producers and consumers
description: In this article, you will learn about producers and consumers.
---

# Producers and consumers

{{ KF }} is a distributed system for exchanging messages between data producers and consumers.

* **Producer** is a data source application. It connects to an {{ KF }} cluster and writes messages with data to specific [topics](topics.md) and topic partitions. To write messages to a topic and partition, the user must have relevant permissions which come from [roles](account-roles.md).
* **Consumer** is an application that receives and processes data from producers. Instead of getting data directly from a producer, it connects to the {{ KF }} cluster, subscribes to relevant [topics](topics.md), and reads messages from them. To subscribe to a topic, the user must have relevant permissions which come from [roles](account-roles.md).

For more information, see the {{ KF }} documentation for [producers](https://kafka.apache.org/documentation/#theproducer) and [consumers](https://kafka.apache.org/documentation/#theconsumer).