There are two ways to migrate topics from a {{ KF }} _source cluster_ to a {{ mkf-name }} _target cluster_:

* [Using the built-in {{ mkf-full-name }} MirrorMaker connector](#kf-connnector).

   This method is easy to configure and does not require you to create an intermediate VM.

* [Using the MirrorMaker 2.0 utility](#kf-mirrormaker).

   This method requires that you install and configure the utility on an intermediate VM. Use this method only if it's not possible to migrate data using the built-in MirrorMaker connector for whatever reason.

## Data migration using {{ mkf-full-name }} Connector {#kf-connector}

1. [Create a connector](#create-connector).
1. [Check the target cluster topic for data](#check-data-mkf-connector).

### Before you begin {#before-you-begin-connector}

1. Prepare the target cluster:
   * Enable [topic management](../managed-kafka/concepts/topics.md#management) via the Admin API.
   * Create an [admin user](../managed-kafka/operations/cluster-accounts.md#create-account) named `admin-cloud`.
   * Enable [Auto create topics enable](../managed-kafka/concepts/settings-list.md#settings-auto-create-topics).
   * Configure [security groups](../managed-kafka/operations/connect.md#configuring-security-groups), if required, to connect to the target cluster.

1. Create a source cluster user named `admin-source` that is authorized to manage topics via the Admin API.
1. Configure a firewall in the source cluster, if required to connect to the cluster from outside.

### Create a connector {#create-connector}

[For the target cluster, clreate a connector](../managed-kafka/operations/cluster-connector.md#create-connector) of the `MirrorMaker` type, configured as follows:

* **Topics**: List of topics to migrate. You can also specify a regular expression for selecting topics. To migrate all topics, specify `.*`.
* Under **Source cluster**, specify the parameters for connecting to the source cluster:
   * **Alias**: A prefix to indicate the source cluster in the connector settings. Defaults to `source`. Topics in the target cluster are created with the indicated prefix.
   * **Bootstrap servers**: A comma-separated list of the FQDNs of the source cluster's broker hosts with the port numbers to connect to.
   * **SASL username**, **SASL password**: Username and password for the previously created `admin-source` user.
   * **SASL mechanism**: `SCRAM-SHA-512` mechanism for username and password encryption.
   * **Security protocol**: Select a protocol for connecting the connector:
      * `SASL_PLAINTEXT`: For connecting to the source cluster without SSL.
      * `SASL_SSL`: For SSL connections to the source cluster.

* Under **Target cluster**, select **Use this cluster**.

Once created, the connector is automatically activated and data migration begins.

### Check the target cluster topic for data {#check-data-mkf-connector}

{% include [check-topics](_tutorials_includes/check-mkf-topic.md) %}

## Migrating data using MirrorMaker {#kf-mirrormaker}

1. [Configure MirrorMaker](#configure-mirrormaker).
1. [Start replication](#replication-start).
1. [Check the target cluster topic for data](#check-data-mkf).

If you no longer need these resources, [delete them](#clear-out).

### Before you begin {#before-you-begin}

#### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

* Manually

   1. [Create a {{ mkf-name }} target cluster](../managed-kafka/operations/cluster-create.md):

      * With [topic management](../managed-kafka/concepts/topics#management) via the Admin API.
      * With the `admin-cloud` [admin user](../managed-kafka/operations/cluster-accounts.md#create-account).
      * With [Auto create topics enable](../managed-kafka/concepts/settings-list.md#settings-auto-create-topics) activated.

   1. {% if audience != "internal" %}[Create a new Linux VM](../compute/operations/vm-create/create-linux-vm.md){% else %}Create a new Linux VM{% endif %} for MirrorMaker on the same network the target cluster is on. To connect to the cluster from the user's local machine instead of the {{ yandex-cloud }} cloud network, enable public access when creating it.

* Using Terraform

   1. If you don't have {{ TF }}, {% if audience != "internal" %}[install it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install it{% endif %}.
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and {% if audience != "internal" %}[specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}specify the parameter values{% endif %}.
   1. Download the [kafka-mirror-maker.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/kafka-mirror-maker.tf) configuration file to the same working directory.

      This file describes:

      * Network.
      * Subnet.
      * Default security group and rules required to connect to the cluster and VM from the internet.
      * A {{ mkf-name }} cluster with [topic management](../managed-kafka/concepts/topics#management) enabled via the Admin API, the `admin-cloud` [admin user](../managed-kafka/operations/cluster-accounts.md#create-account), and [Auto create topics enable](../managed-kafka/concepts/settings-list.md#settings-auto-create-topics).
      * A virtual machine with public internet access.

   1. In `kafka-mirror-maker.tf`, specify:

      * {{ mkf-name }} admin user password.
      * ID of the public {% if audience != "internal" %}[image](../compute/operations/images-with-pre-installed-software/get-list){% else %}image{% endif %} with Ubuntu and no GPU. For example, for [Ubuntu 20.04 LTS]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/marketplace/products/yc/ubuntu-20-04-lts){% endif %}.
      * Username and path to the {% if audience != "internal" %}[public key](../compute/operations/vm-connect/ssh.md#creating-ssh-keys){% else %}public key{% endif %} file to use to access to the virtual machine. By default, the specified username is ignored in the image used. Instead, a user with the `ubuntu` username is created. Use it to connect to the instance.

   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

#### Configure additional settings {#additional-settings}

1. Create a source cluster user named `admin-source` that is authorized to manage topics via the Admin API.

1. {% if audience != "internal" %}[Connect to a virtual machine over SSH](../compute/operations/vm-connect/ssh.md){% else %}Connect to a virtual machine over SSH{% endif %}.

   1. Install the JDK:

      ```bash
      sudo apt update && sudo apt install --yes default-jdk
      ```

   1. [Download](https://kafka.apache.org/downloads) and unpack the {{ KF }} archive with the same version number as the version installed in the target cluster. For example, for version 2.8:

      ```bash
      wget https://archive.apache.org/dist/kafka/2.8.0/kafka_2.12-2.8.0.tgz && \
      tar -xvf kafka_2.12-2.8.0.tgz
      ```

   1. Install the [kafkacat](https://github.com/edenhill/kcat) utility:

      ```bash
      sudo apt update && sudo apt install --yes kafkacat
      ```

      Make sure that you can use it to [connect to the source and target clusters via SSL](../managed-kafka/operations/connect.md#connection-string).

1. Configure a firewall and [security groups](../managed-kafka/operations/connect.md#configuring-security-groups), if required, to connect MirrorMaker to the target and the source clusters.

### Configure MirrorMaker {#configure-mirrormaker}

1. {% if audience != "internal" %}[Connect to the MirrorMaker VM over SSH](../compute/operations/vm-connect/ssh.md){% else %}Connect to the MirrorMaker VM over SSH{% endif %}.
1. Download an [SSL certificate](../managed-kafka/operations/connect#get-ssl-cert) for connecting to the {{ mkf-name }} cluster.
1. In the home directory, create a subfolder called `mirror-maker` to store Java Keystore certificates and MirrorMaker configuration files.

   ```bash
   mkdir --parents /home/<home directory>/mirror-maker
   ```

1. Select a password for and create the certificate store and add an SSL certificate for connecting to the cluster:

   ```bash
   sudo keytool --noprompt -importcert -alias {{ crt-alias }} \
      -file {{ crt-local-dir }}{{ crt-local-file }} \
      -keystore /home/<home directory>/mirror-maker/keystore \
      -storepass <certificate store password, at least 6 characters>
   ```

1. In the `mirror-maker` folder, create a MirrorMaker configuration file called `mm2.properties`:

   ```text
   # Kafka clusters
   clusters=cloud, source
   source.bootstrap.servers=<FQDN of source cluster broker>:9092
   cloud.bootstrap.servers=<FQDN of 1 target cluster broker>:9091, ..., <FQDN of N target cluster broker>:9091

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
   cloud.ssl.truststore.location=/home/<home directory>/mirror-maker/keystore
   cloud.ssl.truststore.password=<certificate store password>
   cloud.ssl.protocol=TLS
   cloud.security.protocol=SASL_SSL
   cloud.sasl.mechanism=SCRAM-SHA-512
   cloud.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="admin-cloud" password="<password>";

   # Enable heartbeats and checkpoints
   source->target.emit.heartbeats.enabled=true
   source->target.emit.checkpoints.enabled=true
   ```

   Notes on MirrorMaker configuration:

   * It performs one-way replication (`source->cloud.enabled = true`, `cloud->source.enabled = false`).
   * In the `topics` parameter, list topics you want to migrate. You can also specify a regular expression for selecting topics. To migrate all topics, specify `.*`. In this configuration, all the topics are replicated.
   * Topic names in the target cluster are the same as in the source.
   * `<R>` is the parameter that sets the [replication factor for MirrorMaker service topics](../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor). The value of this parameter should not exceed the smaller of the number of brokers in the source or the number of brokers in the target cluster.
   * `<M>` is the [default replication factor](../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor) defined for topics in the target cluster.
   * `<T>` is the number of concurrent MirrorMaker processes. A value of at least `2` is recommended for even replication load distribution. For more information, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#georeplication-config-syntax).

   You can request {{ mkf-name }} broker FQDNs with a [list of hosts in the cluster](../managed-kafka/operations/cluster-hosts.md#list-hosts).

### Start replication {#replication-start}

Launch MirrorMaker on the VM as follows:

```bash
<Kafka install path>/bin/connect-mirror-maker.sh /home/<home directory>/mirror-maker/mm2.properties
```

### Check the target cluster topic for data {#check-data-mkf}

{% include [check-topics](_tutorials_includes/check-mkf-topic.md) %}

To learn more about MirrorMaker 2.0, see the [{{ KF }} documentation](https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0).

### Delete the resources you created {#clear-out}

{% list tabs %}

* Manually

   If you no longer need these resources, delete them:

   * [Delete the {{ mkf-full-name }} cluster](../managed-kafka/operations/cluster-delete.md).
   * {% if audience != "internal" %}[Delete the virtual machine](../compute/operations/vm-control/vm-delete.md){% else %}Delete a virtual machine{% endif %}.
   * If you reserved public static IP addresses, release and {% if audience != "internal" %}[delete them](../vpc/operations/address-delete.md){% else %}delete them{% endif %}.

* Using Terraform

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `kafka-mirror-maker.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in the `kafka-mirror-maker.tf` configuration file.

{% endlist %}
