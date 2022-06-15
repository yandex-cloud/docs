# Migrating with MirrorMaker 2.0

MirrorMaker 2.0 is a utility to replicate [topics](../concepts/topics.md) between {{ KF }} clusters. For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#georeplication).

You can use the utility for continuous data migration to a {{ mkf-name }} cluster with [Manage topics via the {{ KF }} Admin API](../concepts/topics.md#management) enabled.

To migrate data from the _source cluster_ in {{ KF }} to the {{ mkf-name }} _target cluster_:

1. [Configure MirrorMaker](#configure-mirrormaker).
1. [Start replication](#replication-start).
1. [Check the {{ KF }} target cluster](#check-data-mkf) topic for data.

## Before you start {#before-you-begin}

1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md):
    * With [topic management](../concepts/topics.md#management) via the Admin API enabled.
    * With an [administrator](../operations/cluster-accounts.md#create-account) account.
    * With [Auto create topics enable](../concepts/settings-list.md#settings-auto-create-topics) activated.

1. Create a source cluster user authorized to manage topics via the Admin API.

1. Set up a VM with MirrorMaker:
    1. [Create a new Linux VM](../../compute/operations/vm-create/create-linux-vm.md) on the same network as the target cluster.
    1. Install the JDK:

        ```bash
        sudo apt update && sudo apt install -y default-jdk
        ```
    1. [Download](https://kafka.apache.org/downloads) and unpack the {{ KF }} archive with the same version number as the version installed in the target cluster.

1. Configure a firewall and [security groups](../operations/connect.md#configuring-security-groups), if required, to connect MirrorMaker to the target and the source clusters.

1. Using the [kafkacat](../operations/connect.md#bash) utility, make sure the VM running MirrorMaker can connect to the source and the target clusters.

## Configure MirrorMaker {#configure-mirrormaker}

1. [Connect to the VM running MirrorMaker over SSH](../../compute/operations/vm-connect/ssh.md).

1. Download an [SSL certificate](../operations/connect.md#get-ssl-cert) to connect to a {{ mkf-name }} cluster.

1. Select a password for and create the certificate store and add an SSL certificate for connecting to the cluster:

   ```bash
   keytool --noprompt -importcert -alias {{ crt-alias }} \
      -file {{ crt-local-dir }}{{ crt-local-file }} \
      -keystore <path to Java Key Store file> \
      -storepass <certificate store password, a minimum of 6 characters>
   ```

1. Create an `mm2.properties` MirrorMaker configuration file:

   {% cut "mm2.properties" %}

   ```
   # Kafka clusters
   clusters=cloud, source
   source.bootstrap.servers=<source cluster broker FQDN>:9092
   cloud.bootstrap.servers=<Target Cluster 1 broker FQDN>:9091, ..., <Target Cluster N broker FQDN>:9091
   
   # Source and target cluster settings
   source->cloud.enabled=true
   cloud->source.enabled=false
   replication.policy.separator=
   source.cluster.alias=
   cloud.cluster.alias=cloud
   
   # Internal topics settings
   source.config.storage.replication.factor=<R>
   source.status.storage.replication.factor=<R>
   source.offset.storage.replication.factor=<R>
   source.offsets.topic.replication.factor=<R>
   source.errors.deadletterqueue.topic.replication.factor=<R>
   source.offset-syncs.topic.replication.factor=<R>
   source.heartbeats.topic.replication.factor=<R>
   source.checkpoints.topic.replication.factor=<R>
   source.transaction.state.log.replication.factor=<R>
   cloud.config.storage.replication.factor=<R>
   cloud.status.storage.replication.factor=<R>
   cloud.offset.storage.replication.factor=<R>
   cloud.offsets.topic.replication.factor=<R>
   cloud.errors.deadletterqueue.topic.replication.factor=<R>
   cloud.offset-syncs.topic.replication.factor=<R>
   cloud.heartbeats.topic.replication.factor=<R>
   cloud.checkpoints.topic.replication.factor=<R>
   cloud.transaction.state.log.replication.factor=<R>
   
   # Topics
   topics=.*
   groups=.*
   topics.blacklist=.*[\-\.]internal, .*\replica, __consumer_offsets
   groups.blacklist=console-consumer-.*, connect-.*, __.*
   replication.factor=<M>
   refresh.topics.enable=true
   sync.topic.configs.enabled=true
   refresh.topics.interval.seconds=10
   
   # Tasks
   tasks.max=<T>
   
   # Source cluster authentication parameters. Comment out if no authentication required
   source.client.id=mm2_consumer_test
   source.group.id=mm2_consumer_group
   source.security.protocol=SASL_PLAINTEXT
   source.sasl.mechanism=SCRAM-SHA-512
   source.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="<source cluster username>" password="<source cluster user password>";
   
   # Target cluster authentication parameters
   cloud.client.id=mm2_producer_test
   cloud.group.id=mm2_producer_group
   cloud.ssl.enabled.protocols=TLSv1.2,TLSv1.1,TLSv1
   cloud.ssl.truststore.location=<path to Java Key Store file>
   cloud.ssl.truststore.password=<certificate store password>
   cloud.ssl.protocol=TLS
   cloud.security.protocol=SASL_SSL
   cloud.sasl.mechanism=SCRAM-SHA-512
   cloud.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="<target cluster username>" password="<target cluster user password>";
   
   # Enable heartbeats and checkpoints
   source->target.emit.heartbeats.enabled=true
   source->target.emit.checkpoints.enabled=true
   ```

   {% endcut %}

   Notes on MirrorMaker configuration:
   * It performs one-way replication (`source->cloud.enabled = true`, `cloud->source.enabled = false`).
   * It replicates all topics. You can use the `topics` parameter to specify a regular expression for selecting topics.
   * Topic names in the target cluster are the same as in the source.
   * `<R>` is [the parameter that sets the replication factor for MirrorMaker service topics](../concepts/settings-list.md#settings-topic-replication-factor). The value of this parameter should not exceed the smaller of the number of brokers in the source or the number of brokers in the target cluster.
   * `<M>` is [the default replication factor](../concepts/settings-list.md#settings-topic-replication-factor) defined for topics in the target cluster.
   * `<T>` is the number of concurrent MirrorMaker processes. A value of at least `2` is recommended for even replication load distribution. For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#georeplication-config-syntax).

   You can request {{ mkf-name }} broker FQDNs with [a list of hosts in the cluster](../operations/cluster-hosts.md#list-hosts).

## Start replication {#replication-start}

Launch MirrorMaker on the VM as follows:

```bash
<Kafka installation path>/bin/connect-mirror-maker.sh <path to mm2.properties config file>
```

## Check the target cluster topic for data {#check-data-mkf}

1. Connect to the target cluster topic using [kafkacat](../operations/connect.md#bash).

1. Make sure the console displays messages from the source cluster topic.

For more information about working with MirrorMaker 2.0 as a service, see the [{{ KF }} documentation](https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0).
