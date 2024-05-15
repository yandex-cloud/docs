---
title: "What topics and partitions are available in {{ mkf-full-name }}"
description: "In this tutorial, you will learn about topics and partitions available in {{ mkf-name }}."
---

# Topics and partitions

## Topics {#topics}

A topic is a way to group message streams into categories. [Producers](producers-consumers.md) publish messages of a certain category to a topic, while [consumers](producers-consumers.md) subscribe to this topic and read messages from it. For each topic, {{ KF }} keeps a message log that can be divided into multiple partitions.

For example, if the data producer is an online store, you can create separate topics for logging user actions, storing data about their shopping cart, keeping records about transactions, etc.

{{ mkf-name }} manages storage of topic messages and enables:

- Partition replication, in case a cluster consists of at least two [brokers](brokers.md) and the replication factor for topics is greater than one.
- Message compression.
- Log purging [in accordance with the policy](../operations/cluster-topics.md#create-topic) when partition messages become outdated or the specified log size is reached.

### Service topics {#service-topics}

While running, {{ mkf-name }} is able to create and use service topics.
You cannot write user data to such topics.

The `__schema_registry` service topic is used to support [{{ mkf-msr }}](./managed-schema-registry.md).

The `__connect-configs`, `__connect-offsets`, and `__connect-status` service topics are used to ensure that [{{ mkf-mkc }}](./connectors.md) operates properly.

## Partitions {#partitions}

A partition is a sequence of topic messages stored in the order they are received. The message sequence number is called an offset. Consumers read messages from the beginning to the end of a partition, that is, messages that were received earlier are consumed first. To start reading data from a specific message, consumers must provide the broker with its offset.

Using partitions, you can:

- Distribute the message storage and request processing load among multiple [{{ KF }} brokers](brokers.md).
- Provide fault tolerance: a partition can be replicated to a specified number of brokers.

To learn more about topics and partitions, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#intro_topics).

## Managing topics and partitions {#management}

A {{ mkf-name }} cluster provides two ways for you to manage topics and partitions:

* Using native {{ yandex-cloud }} interfaces, such as CLI, API, or management console. Use this method if you want to create, delete, and configure topics and partitions using {{ mkf-name }} features.

* Using the [{{ KF }} Admin API](https://kafka.apache.org/documentation/#adminapi). The method will suit you if you already have your own solution for managing topics and partitions. When using the Admin API, the following restrictions apply:

   * To manage topics, you will need an admin user with the `ACCESS_ROLE_ADMIN` role that is effective for all cluster topics. If there is no such user in the cluster, [create](../operations/cluster-accounts.md) one.

   * You need to configure user permissions for [producers and consumers](./producers-consumers.md) using native {{ yandex-cloud }} interfaces rather than the {{ KF }} Admin API.

You can use these methods separately or combined.
