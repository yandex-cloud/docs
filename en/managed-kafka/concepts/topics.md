# Topics and partitions

## Topics {#topics}

A topic is a way to group message streams into categories. [Producers](producers-consumers.md) [publish](../operations/connect.md) a certain category of messages to a topic, while [consumers](producers-consumers.md) [subscribe](../operations/connect.md) to this topic and pull messages from it. For each topic, {{ KF }} keeps a message log that can be divided into several partitions.

For example, if the data producer is an online store, you can create separate topics for logging user actions, storing data about their shopping cart, keeping records about transactions, and so on.

{{ mkf-name }} manages storage of topic messages and enables:

- Partition replication: provided that a cluster consists of at least two [brokers](brokers.md) and the replication factor set for topics is greater than one.
- Message compaction.
- Log purging [in accordance with the policy](../operations/cluster-topics.md#create-topic) when partition messages become outdated or the specified log size is reached.

### Service topics {#service-topics}

While running, {{ mkf-name }} is able to create and use service topics.
You cannot write user data to such topics.

The `_schemas` service topic is used to support [{{ mkf-msr }}](./managed-schema-registry.md).

## Partitions {#partitions}

A partition is a sequence of topic messages that are stored in the order they are received. The message sequence number is called an offset. Consumers read messages from the beginning to the end of a partition, that is, messages that were received earlier are consumed first. To start reading data from a specific message, consumers must pass the broker its offset.

Using partitions, you can:

- Distribute the message storage and request processing load among multiple [{{ KF }} brokers](brokers.md).
- Provide fault tolerance: a partition can be replicated to a specified number of brokers.

To learn more about topics and partitions, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#intro_topics).

## Managing topics and partitions {#management}

A {{ mkf-name }} cluster provides two ways for you to manage topics and sections:

* Using {{ yandex-cloud }} standard interfaces (CLI, {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}, or management console). Select this method if you wish to create, delete, and configure topics and partitions using {{ mkf-name }} service features.

* Using the [{{ KF }} Admin API](https://kafka.apache.org/documentation/#adminapi). The method is suitable if you already have your own solution for managing topics and partitions. Restrictions apply when using the Admin API:

   * An administrator user with the role `ACCESS_ROLE_ADMIN` that is valid for all cluster topics is used to manage topics. If the cluster has no required user, [create](../operations/cluster-accounts.md) one.

   * You can configure user permissions for [producers and consumers](./producers-consumers.md) using standard {{ yandex-cloud }} interfaces rather than the {{ KF }} Admin API.

   * You can enable topic management via the {{ KF }} Admin API when [creating](../operations/cluster-create.md) or [changing](../operations/cluster-update.md) cluster settings, but you can't disable it.

You can use both methods separately or combined.
