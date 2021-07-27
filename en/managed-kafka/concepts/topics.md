---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Topics and partitions

## Topics {#topics}

A topic is a way to group message streams into categories. [Producers](producers-consumers.md) [publish](../operations/connect.md) messages of a certain category in a topic, while [consumers](producers-consumers.md) [subscribe](../operations/connect.md) to this topic and read messages from it. For each topic, {{ KF }} keeps a message log that can be divided into several partitions.

For example, if the data producer is an online store, you can create separate topics for logging user actions, storing data about their shopping cart, keeping records about transactions, and so on.

{{ mkf-name }} manages storage of topic messages and enables:

- Partition replication: provided that a cluster consists of at least two [brokers](brokers.md) and the replication factor set for topics is greater than one.
- Message compaction.
- Log purging [in accordance with the policy](../operations/cluster-topics.md#create-topic) when partition messages become outdated or the specified log size is reached.

## Partitions {#partitions}

A partition is a sequence of topic messages that are stored in the order they are received. The message sequence number is called an offset. Consumers read messages from the beginning to the end of a partition, that is, messages that were received earlier are consumed first. To start reading data from a specific message, consumers must pass the broker its offset.

Using partitions, you can:

- Distribute the message storage and request processing load among multiple [brokers {{ KF }}](brokers.md).
- Provide fault tolerance: a partition can be replicated to a specified number of brokers.

For more information about topics and partitions, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#intro_topics).

