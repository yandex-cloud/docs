# {{ mkf-name }} {#kafka}

{{ mkf-name }} is a message broker that allows you to implement an architecture using message queues. Using this component, you can create clusters and topics and manage user access by leveraging the following custom resources:

* `KafkaCluster`: To create a cluster.
* `KafkaTopic`: To work with topics.
* `KafkaUserAccess`: To manage user access.

You can manage integration with {{ KF }} using the `ManagedKafkaConfig` custom resource settings.

## Configuration {#configuration}

Here is an example:

{% include notitle [YAML-file](../../_includes/yamls/components/managedkafkaconfig.md) %}

Where:

* `defaultStorageClass`: Sets the default storage class for {{ KF }} topics.
* `stackland-kafka`: Stackland Kafka operator settings, such as `replicas` standing for the replica count and `resources` specifying CPU and memory limits.
* `strimzi-kafka`: Strimzi Kafka operator settings, such as `replicas` and `resources` (when using Strimzi).
* `defaultKafkaResources`, `defaultControllerResources`: Default resources for Kafka brokers and the controller. These settings are optional.
* `monitoring.enabled`: Specifies whether to enable component monitoring. This is an optional setting.
