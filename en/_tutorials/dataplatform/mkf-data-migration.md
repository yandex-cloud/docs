

There are two ways to migrate topics from an {{ KF }} _source cluster_ to a {{ mkf-name }} _target cluster_:

* [Using the built-in {{ mkf-full-name }} MirrorMaker connector](#kf-connector).

  This method is easy to configure and does not require creating an intermediate VM.

* [Using MirrorMaker 2.0](#kf-mirrormaker).

  This requires setting up the utility manually on an intermediate virtual machine. Use this method only if it is not possible to migrate data using the built-in MirrorMaker connector for whatever reason.

Both methods are also suitable for [migrating](../../managed-kafka/operations/host-migration.md#one-host) a single-host {{ mkf-name }} cluster to a different availability zone.

## Migrating data using {{ mkf-full-name }} Connector {#kf-connector}

1. [Create a connector](#create-cluster-connector).
1. [Check the target cluster topic for data](#check-data-mkf-connector).


## Required paid resources {#paid-resources-connector}

The support cost for this solution includes:

* {{ mkf-name }} cluster fee, which covers the use of computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ KF }} pricing](../../managed-kafka/pricing.md)).
* Fee for public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


### Create a cluster and a connector {#create-cluster-connector}

{% list tabs group=instructions %}

- Manually {#manual}

    1. Set up the target cluster:
        * Create an [admin user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `admin-cloud`.
        * Enable the [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics) property.
        * Configure [security groups](../../managed-kafka/operations/connect/index.md#configuring-security-groups) if required for the target cluster connection.

    1. In the source cluster, create the `admin-source` user authorized to manage topics via the Admin API.
    1. Make sure the source cluster’s network settings allow cluster connections from the internet.
    1. [For the target cluster, create a connector](../../managed-kafka/operations/cluster-connector.md#create-connector) of the `MirrorMaker` type, configured as follows:

        * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: List of topics to migrate. You can also specify a regular expression for selecting topics. To migrate all topics, specify `.*`.
        * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-source-cluster }}**, specify the parameters for connecting to the source cluster:
          * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Source cluster prefix in the connector settings. The default value is `source`. Topics in the target cluster will be created with the specified prefix.
          * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Comma-separated list of the FQDNs of the source cluster broker hosts with the port numbers, such as follows:

              ```text
              FQDN1:9091,FQDN2:9091,...,FQDN:9091
              ```

          * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}** and **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: Username and password of the previously created `admin-source` user.
          * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Authentication mechanism for username and password validation, `SCRAM-SHA-512`.
          * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select the connection protocol for the connector:
            * `SASL_PLAINTEXT`: For connecting to the source cluster without SSL.
            * `SASL_SSL`: For SSL connections to the source cluster.

        * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-target-cluster }}**, select **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [kafka-mirrormaker-connector.tf](https://github.com/yandex-cloud-examples/yc-kafka-data-migration-from-on-premise/blob/main/kafka-mirrormaker-connector.tf) configuration file to the same working directory.

        This file describes:

        * Network.
        * Subnet.
        * Default security group and inbound internet rules for the cluster.
        * {{ mkf-name }} target cluster with [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics) set to `true`.
        * `admin-cloud` [admin user](../../managed-kafka/operations/cluster-accounts.md#create-account) for the target cluster.
        * MirrorMaker connector for the target cluster.

    1. In the `kafka-mirrormaker-connector.tf` file, specify the following:

        * Source cluster username and passwords for the source and target cluster users.
        * FQDNs of the source cluster broker hosts.
        * Source and target cluster aliases.
        * Filter pattern for topics to migrate.
        * {{ KF }} version.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

Once the connector is created, it is automatically activated and data migration starts.

{% endlist %}

### Check the target cluster topic for data {#check-data-mkf-connector}

{% include [check-topics](../_tutorials_includes/check-mkf-topic.md) %}

## Migrating data using MirrorMaker {#kf-mirrormaker}

1. [Configure MirrorMaker](#configure-mirrormaker).
1. [Start replication](#replication-start).
1. [Check the target cluster topic for data](#check-data-mkf).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources-mirrormaker}

The support cost for this solution includes:

* {{ mkf-name }} cluster fee, which covers the use of computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ KF }} pricing](../../managed-kafka/pricing.md)).
* Fee for public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* VM fee, which covers the use of computing resources, storage, and, optionally, public IP address (see [{{ compute-name }} pricing](../../compute/pricing.md)).


### Getting started {#before-you-begin}

#### Set up your infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md):

        * With the `admin-cloud` [admin user](../../managed-kafka/operations/cluster-accounts.md#create-account).
        * With the [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics) property enabled.

    1. [Create a new Linux VM](../../compute/operations/vm-create/create-linux-vm.md) for MirrorMaker in the same network as the target cluster. To be able to connect to the VM not only from within the {{ yandex-cloud }} network but also from a local machine, enable public access when creating it.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [kafka-mirror-maker.tf](https://github.com/yandex-cloud-examples/yc-kafka-data-migration-from-on-premise/blob/main/kafka-mirror-maker.tf) configuration file to the same working directory.

        This file describes:

        * Network.
        * Subnet.
        * Default security group and inbound internet rules for your cluster and VM.
        * {{ mkf-name }} cluster with [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics) set to `true`.
        * `admin-cloud` {{ KF }} [admin user](../../managed-kafka/operations/cluster-accounts.md#create-account).
        * Virtual machine with public internet access.

    1. In the `kafka-mirror-maker.tf` file, specify the following:

        * {{ KF }} version.
        * {{ KF }} admin user password.
        * Public Ubuntu [image](../../compute/operations/images-with-pre-installed-software/get-list.md) ID (non-GPU), e.g., [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
        * Username and path to the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for VM access. By default, the pre-configured image ignores the specified username and automatically creates a user named `ubuntu`. Use it to connect to the VM.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

#### Configure additional settings {#additional-settings}

1. In the source cluster, create the `admin-source` user authorized to manage topics via the Admin API.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

    1. Install the JDK:

        ```bash
        sudo apt update && sudo apt install --yes default-jdk
        ```

    1. [Download](https://kafka.apache.org/downloads) and unpack the {{ KF }} archive with the same version as installed on the target cluster, e.g., {{ KF }} 2.8:

        ```bash
        wget https://archive.apache.org/dist/kafka/2.8.0/kafka_2.12-2.8.0.tgz && \
        tar -xvf kafka_2.12-2.8.0.tgz
        ```

    1. Install [kafkacat](https://github.com/edenhill/kcat):

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Make sure you can use it to [connect to the source and target clusters over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

1. Configure a firewall and [security groups](../../managed-kafka/operations/connect/index.md#configuring-security-groups) if required for MirrorMaker connection to the target and source clusters.

### Configure MirrorMaker {#configure-mirrormaker}

1. [Connect to the MirrorMaker VM over SSH](../../compute/operations/vm-connect/ssh.md).
1. Download an [SSL certificate](../../managed-kafka/operations/connect#get-ssl-cert) for connecting to the {{ mkf-name }} cluster.
1. In the home directory, create a folder named `mirror-maker` to store Java Keystore certificates and MirrorMaker configuration files:

   ```bash
   mkdir --parents /home/<home_directory>/mirror-maker
   ```

1. Choose a password of at least 6 characters for a certificate store, create the store, and add the SSL certificate for cluster connection:

   ```bash
   sudo keytool --noprompt -importcert -alias {{ crt-alias }} \
      -file {{ crt-local-dir }}{{ crt-local-file }} \
      -keystore /home/<home_directory>/mirror-maker/keystore \
      -storepass <certificate_store_password>
   ```

1. Create a MirrorMaker configuration file named `mm2.properties` in the `mirror-maker` folder:

   ```text
   # Kafka clusters
   clusters=cloud, source
   source.bootstrap.servers=<source_cluster_broker_FQDN>:9092
   cloud.bootstrap.servers=<source_cluster_broker_1_FQDN>:9091, ..., <source_cluster_broker_N_FQDN>:9091

   # Source and target cluster settings
   source->cloud.enabled=true
   cloud->source.enabled=false
   source.cluster.alias=source
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
   source.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="admin-source" password="<password>";

   # Target cluster authentication parameters
   cloud.client.id=mm2_producer_test
   cloud.group.id=mm2_producer_group
   cloud.ssl.enabled.protocols=TLSv1.2,TLSv1.1,TLSv1
   cloud.ssl.truststore.location=/home/<home_directory>/mirror-maker/keystore
   cloud.ssl.truststore.password=<certificate_store_password>
   cloud.ssl.protocol=TLS
   cloud.security.protocol=SASL_SSL
   cloud.sasl.mechanism=SCRAM-SHA-512
   cloud.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="admin-cloud" password="<password>";

   # Enable heartbeats and checkpoints
   source->target.emit.heartbeats.enabled=true
   source->target.emit.checkpoints.enabled=true
   ```

   MirrorMaker configuration notes:

   * It performs one-way replication (`source->cloud.enabled = true`, `cloud->source.enabled = false`).
   * In the `topics` parameter, list the topics you want to migrate. You can also specify a regular expression for selecting topics. To migrate all topics, specify `.*`. This configuration replicates all topics.
   * Topic names in the target cluster cluster match those in the source cluster.
   * `<R>` stands for the [replication factor](../../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor) for MirrorMaker service topics. Its value should not exceed the lesser of the broker counts in the source and target clusters.
   * `<M>` stands for the [default replication factor](../../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor) defined for topics in the target cluster.
   * `<T>` stands for the number of concurrent MirrorMaker processes. To distribute replication load evenly, we recommend a value of at least `2`. For more information, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#georeplication-config-syntax).

   You can get the {{ mkf-name }} broker FQDNs with the [list of hosts in the cluster](../../managed-kafka/operations/cluster-hosts.md).

### Start replication {#replication-start}

Run MirrorMaker on the VM as follows:

```bash
<Apache_Kafka_installation_path>/bin/connect-mirror-maker.sh /home/<home_directory>/mirror-maker/mm2.properties
```

### Check the target cluster topic for data {#check-data-mkf}

{% include [check-topics](../_tutorials_includes/check-mkf-topic.md) %}

To learn more about using MirrorMaker 2.0, see [this {{ KF }} article](https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0).

### Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Delete the {{ mkf-full-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
    * [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
    * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
