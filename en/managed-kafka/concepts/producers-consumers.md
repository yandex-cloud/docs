# Producers and consumers

{{ KF }} is a distributed system for exchanging messages between data producers and consumers.

* **Consumer** is a data source application. It connects to a {{ KF }} cluster and writes messages with data to specific [topics](topics.md) and topic partitions. To be able to write messages to a topic or partition, the application must have a [user account](../operations/cluster-accounts.md) with the appropriate set of permissions.
* **Consumer** is an application that receives and processes data from producers. Instead of getting data directly from a producer, it connects to the {{ KF }} cluster, subscribes to certain [topics](topics.md), and reads messages from them. To be able to subscribe to a topic, the application must have a [user account](../operations/cluster-accounts.md) with the right set of permissions.


For more information, see the {{ KF }} documentation for [producers](https://kafka.apache.org/documentation/#theproducer) and [consumers](https://kafka.apache.org/documentation/#theconsumer).
