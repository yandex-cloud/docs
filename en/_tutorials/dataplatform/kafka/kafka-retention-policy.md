# Monitoring message loss in an {{ KF }} topic

A consumer group may lose messages in an {{ KF }} topic due to a combination of these two factors:
1. The topic or entire cluster uses the `Delete` log cleanup policy with a short `Log retention` period.
1. One or more consumer groups are too slow to read messages from the topic resulting in deletion of unread messages. 

You can monitor message loss using {{ mkf-name }} [metrics](../../../managed-kafka/metrics.md) delivered to [{{ monitoring-name }}](../../../monitoring/concepts/index.md). `kafka_group_topic_partition_offset` falling below `kafka_log_Log_LogStartOffset` signals that a consumer group has lost messages.

In this tutorial, you will:
* Simulate a message loss in a {{ mkf-name }} test cluster topic using [topic connection tools](https://kafka.apache.org/downloads).
* Plot a graph of the `kafka_group_topic_partition_offset`, `kafka_log_Log_LogStartOffset`, and `kafka_log_Log_LogEndOffset` metrics with the help of {{ monitoring-full-name }} and observe the patterns occurring during a message loss.

To simulate and monitor a message loss in an {{ KF }} topic:

1. [Set up topic connection tools](#test-cluster-prepare).
1. [Prepare message send and receive commands](#prepare-commands).
1. [Run the message receive command](#start-receive).
1. [Build monitoring charts](#create-chart).
1. [Test sending and receiving a message](#send-message).
1. [Enable message deletion](#activate-retention-policy).
1. [Test sending and receiving a message once again](#send-second-message).
1. [Review the monitoring charts](#check-charts).

If you no longer need the resources you created, [delete them](#clear-out).

## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ KF }} cluster fee: Covers the use of computational resources allocated to hosts (including ZooKeeper hosts) and disk storage (see [{{ KF }} pricing](../../../managed-kafka/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).

## Getting started {#before-you-begin}

1. [Create a {{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-create.md) in any suitable configuration. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** when creating your cluster.
1. [Create a topic](../../../managed-kafka/operations/cluster-topics.md#create-topic) for message exchange between producer and consumer with the following settings:
    * **{{ ui-key.yacloud.common.name }}**: `messages`
    * **{{ ui-key.yacloud.kafka.label_partitions }}**: `1`
1. [Create a user](../../../managed-kafka/operations/cluster-accounts.md#create-account) named `user` and [grant them permissions](../../../managed-kafka/operations/cluster-accounts.md#grant-permission) for the `messages` topic:
    * `ACCESS_ROLE_CONSUMER`
    * `ACCESS_ROLE_PRODUCER`
1. [Configure security groups](../../../managed-kafka/operations/connect/index.md#configuring-security-groups).
1. [Get an SSL certificate](../../../managed-kafka/operations/connect/index.md#get-ssl-cert).
   
   {% note info %}

   You can only connect to public hosts using an SSL certificate.

   {% endnote %}

1. Select a cluster host with the `KAFKA` role and get its [FQDN](../../../managed-kafka/operations/connect/index.md#get-fqdn).
1. Name the consumer group, e.g., `test-consumer-group`.

## Set up topic connection tools {#test-cluster-prepare}

{% list tabs group=instructions %}

- CLI for Bash {#bash}

    1. Install OpenJDK:

       ```bash
       sudo apt update && sudo apt install --yes default-jdk
       ```

    1. Download the [archive with binary files](https://kafka.apache.org/downloads) for the {{ KF }} version run by the cluster. Your Scala version is irrelevant.

    1. Unpack the archive.

    1. Go to the folder where the Java certificate store will be located:

       ```bash
       cd /etc/security
       ```

    1. {% include [keytool-importcert](../../../_includes/mdb/keytool-importcert.md) %}

    1. Create a configuration file for connecting to the cluster:

       {% note info %}

       In this tutorial, we will use a single user as both producer and consumer to keep things simple. Therefore, you only need to create one configuration file to both send and receive messages.

       {% endnote %}

       ```ini
       sasl.mechanism=SCRAM-SHA-512
       sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
         username="user" \
         password="<user_password>";
       security.protocol=SASL_SSL
       ssl.truststore.location=/etc/security/ssl
       ssl.truststore.password=<certificate_store_password>
       ```

- CLI for PowerShell {#powershell}

    1. Install the latest available version of [Microsoft OpenJDK](https://docs.microsoft.com/en-us/java/openjdk/download).

    1. Download the [archive with binary files](https://kafka.apache.org/downloads) for the {{ KF }} version run by the cluster. Your Scala version is irrelevant.

    1. Unpack the archive.

       {% note tip %}

       Unpack the {{ KF }} files to the disk's root folder, e.g., `C:\kafka_2.12-2.6.0\`.

       If the path to the {{ KF }} executables and batch files is too long, you will get the `The input line is too long` error when trying to run them.

       {% endnote %}

    1. Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ KF }} driver can use this certificate for secure connections to the cluster hosts. Set a password in the `--storepass` parameter for additional storage protection:

       ```powershell
       keytool.exe -importcert -alias {{ crt-alias }} `
       --file $HOME\.kafka\{{ crt-local-file }} `
       --keystore $HOME\.kafka\ssl `
       --storepass <certificate_store_password> `
       --noprompt
       ```

    1. Create a configuration file for connecting to the cluster:

       {% note info %}

       In this tutorial, we will use a single user as both producer and consumer to keep things simple. Therefore, you only need to create one configuration file to both send and receive messages.

       {% endnote %}

       ```ini
       sasl.mechanism=SCRAM-SHA-512
       sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
         username="user" \
         password="<user_password>";
       security.protocol=SASL_SSL
       ssl.truststore.location=<$HOME_variable_value>\\.kafka\\ssl
       ssl.truststore.password=<certificate_store_password>
       ```

       Specify the full path to the certificate store as the `ssl.truststore.location` parameter value, for example:

       ```ini
       ssl.truststore.location=C:\\Users\\Administrator\\.kafka\\ssl
       ```

       The certificate store is located at `$HOME\.kafka\ssl`, but you cannot use environment variables in the value. To expand the variable, run this command:

       ```powershell
       echo $HOME
       ```

       {% note warning %}

       Use `\\` instead of `\` when specifying the `ssl.truststore.location` parameter value, otherwise you will not be able to access the certificate store when running commands.

       {% endnote %}

{% endlist %}

## Prepare message send and receive commands {#prepare-commands}

{% list tabs group=instructions %}

- CLI for Bash {#bash}

    * Command to send a message to the `messages` topic:

        ```bash
        echo "key:test message" | <path_to_folder_with_Apache_Kafka_files>/bin/kafka-console-producer.sh \
          --producer.config <path_to_configuration_file> \
          --bootstrap-server <host_FQDN>:9091 \
          --topic messages \
          --property parse.key=true \
          --property key.separator=":"
        ```

    * Command to receive a message from the `messages` topic:

        ```bash
        <path_to_folder_with_Apache_Kafka_files>/bin/kafka-console-consumer.sh \
          --consumer.config <path_to_configuration_file> \
          --bootstrap-server <host_FQDN>:9091 \
          --group test-consumer-group \
          --topic messages \
          --property print.key=true \
          --property key.separator=":"
        ```

- CLI for PowerShell {#powershell}

    * Command to send a message to the `messages` topic:

        ```powershell
        echo "key:test message" | <path_to_folder_with_Apache_Kafka_files>\bin\windows\kafka-console-producer.bat `
            --producer.config <path_to_configuration_file> `
            --bootstrap-server <host_FQDN>:9091 `
            --topic messages `
            --property parse.key=true `
            --property key.separator=":"
        ```

    * Command to receive a message from the `messages` topic:

        ```powershell
        <path_to_folder_with_Apache_Kafka_files>\bin\windows\kafka-console-consumer.bat `
            --consumer.config <path_to_configuration_file> `
            --bootstrap-server <host_FQDN>:9091 `
            --group test-consumer-group `    
            --topic messages `
            --property print.key=true `
            --property key.separator=":"
        ```

{% endlist %}

## Run the message receive command {#start-receive}

1. Run the [message receive command](#prepare-commands).

1. Wait 10 to 15 seconds and then interrupt the command by pressing **Ctrl** + **C**. Make sure the terminal displays the following message:

    ```
    Processed a total of 0 messages
    ```
   
   This message means the consumer has successfully connected to the topic.

1. Confirm completing the command.

The consumer group named `test-consumer-group` has now been registered and can be used as a label for metrics.

## Create monitoring charts {#create-chart}

Use [{{ monitoring-full-name }}]({{ link-monitoring }}) to [plot](../../../monitoring/operations/metric/metric-explorer.md#add-graph) the `kafka_group_topic_partition_offset`, `kafka_log_Log_LogStartOffset`, and `kafka_log_Log_LogEndOffset` metrics on the same chart:
* For `kafka_group_topic_partition_offset`, specify these labels:
    * `service = managed-kafka`
    * `name = kafka_group_topic_partition_offset`
    * `host = <host_FQDN>`
    * `topic = messages`
    * `group = test-consumer-group`
* For `kafka_log_Log_LogStartOffset`, specify these labels: 
    * `service = managed-kafka`
    * `name = kafka_log_Log_LogStartOffset`
    * `host = <host_FQDN>`
    * `topic = messages`
* For `kafka_log_Log_LogEndOffset`, specify these labels:
    * `service = managed-kafka`
    * `name = kafka_log_Log_LogEndOffset`
    * `host = <host_FQDN>`
    * `topic = messages`

{% note warning %}

In our example, the `messages` test topic includes only one partition, so you do not need to specify the `partition` label. If the topic in your solution has multiple partitions, specify `partition` when plotting the listed metrics.

{% endnote %}

{% note info %}

To monitor message loss, you only need the `kafka_group_topic_partition_offset` and `kafka_log_Log_LogStartOffset` metrics; however, the additional `kafka_log_Log_LogEndOffset` metric will make the chart more instructive.

{% endnote %}

## Test sending and receiving a message {#send-message}

1. Run the [message send command](#prepare-commands).

1. After about three minutes, run the [message receive command](#prepare-commands). Make sure the terminal displays `key:test message`.

1. Press **Ctrl** + **C** to interrupt the command for receiving messages from the topic. 

Message deletion being disabled, three minutes later the message is still available to consumers.

## Enable message deletion {#activate-retention-policy}

[Configure](../../../managed-kafka/operations/cluster-topics.md#update-topic) the `messages` topic as follows:

   * **{{ ui-key.yacloud.kafka.label_topic-cleanup-policy }}**: `Delete`
   * **{{ ui-key.yacloud.kafka.label_topic-retention-ms }}**: `60000`

{% note info %}

After you change the topic settings, the cluster will take some time to update.

{% endnote %}

Messages will now be automatically deleted 60 seconds after being written to the topic.

## Test sending and receiving a message once again {#send-second-message}

1. Run the [message send command](#prepare-commands).

1. After about three minutes, run the [message receive command](#prepare-commands). Make sure the message has not been received this time.

1. Press **Ctrl** + **C** to interrupt the command for receiving messages from the topic. 

All messages are deleted 60 seconds after they are written to the topic, leading to message loss for the "slow" consumer group.

## Review the monitoring charts {#check-charts}

Navigate to [{{ monitoring-full-name }}]({{ link-monitoring }}) and review the behavior of the previously created metrics:
* `kafka_log_Log_LogStartOffset`: Partition's first offset. Increases as messages are getting written to the topic.
* `kafka_log_Log_LogEndOffset`: Partition's last offset. Increases as messages get deleted from the topic.
* `kafka_group_topic_partition_offset`: Partition's current consumer group offset. Increases as the consumer group is reading messages from the topic.

The chart visualizes the following patterns:
1. At the starting point, all the three metrics are at `0`.
1. After [the first message is sent](#send-message), `kafka_log_Log_LogEndOffset` increases to `1`.
1. Three minutes later, as soon as the first message arrives, `kafka_group_topic_partition_offset` also increases to `1`. As messages do not get deleted, `kafka_log_Log_LogStartOffset` remains equal to `0`.
1. One minute after you [enable message deletion](#activate-retention-policy), the system deletes the message from the topic and `kafka_log_Log_LogStartOffset` gets the value of `1`. Now, all the three metrics are at `1`.
1. After [the second message is sent](#send-second-message), `kafka_log_Log_LogEndOffset` increases to `2`. One minute later, the system deletes the message from the topic and `kafka_log_Log_LogStartOffset` also gets the value of `2`. `kafka_group_topic_partition_offset` still equals `1`.
1. As soon as you run the message receive command for a second time, `kafka_group_topic_partition_offset` also increases to `2`, even though the message has not been received.

Summary:
1. The `kafka_group_topic_partition_offset` value normally lies between `kafka_log_Log_LogStartOffset` and `kafka_log_Log_LogEndOffset`. `kafka_group_topic_partition_offset` falling below `kafka_log_Log_LogStartOffset` signals that this consumer group has lost messages.
1. The difference between `kafka_log_Log_LogEndOffset` and `kafka_group_topic_partition_offset` shows how many of the new messages have not yet been read, i.e., the consumer group's lag behind the producers.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [Delete](../../../managed-kafka/operations/cluster-delete.md) the {{ mkf-name }} cluster.
* Release and [delete](../../../vpc/operations/address-delete.md) the static public IP addresses.
