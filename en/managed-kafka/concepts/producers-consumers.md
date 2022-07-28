# Producers and consumers

{{ KF }} is a distributed system for exchanging messages between data producers and consumers.

* **Producer** is a data source application. It connects to a {{ KF }} cluster and writes messages with data to specific [topics](topics.md) and topic partitions. To write messages to a topic and partition, an application user must be granted the appropriate rights.
* **Consumer** is an application that receives and processes data from producers. Instead of getting data directly from a producer, it connects to the {{ KF }} cluster, subscribes to certain [topics](topics.md), and reads messages from them. To subscribe to a topic, an application user must be granted the appropriate rights.

For more information, see the {{ KF }} documentation for [producers](https://kafka.apache.org/documentation/#theproducer) and [consumers](https://kafka.apache.org/documentation/#theconsumer).
