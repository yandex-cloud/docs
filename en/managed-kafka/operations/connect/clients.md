---
title: Connecting to an {{ KF }} cluster in {{ mkf-full-name }}
description: Follow this guide to connect to hosts in an {{ KF }} cluster using command line tools and Docker container.
---

# Connecting to an {{ KF }} cluster from applications

This section provides settings for connecting to {{ mkf-name }} cluster hosts using the [command line tools](#command-line-tools) and [Docker container](#docker). To learn how to connect from your application code, see [Code examples](code-examples.md).

You can connect to public {{ KF }} cluster hosts only if you use an [SSL certificate](index.md#get-ssl-cert). The examples below assume that the `{{ crt-local-file }}` certificate is located in the directory:

* `{{ crt-local-dir }}` for Ubuntu.
* `$HOME\.kafka\` for Windows.

Connecting without an SSL certificate is only supported for non-public hosts. For connections to the database, traffic inside the virtual network is not encrypted in this case.

Before connecting, [configure security groups](index.md#configuring-security-groups) for the cluster, if required.

The examples for Linux were tested in the following environment:

* {{ yandex-cloud }} virtual machine running Ubuntu 20.04 LTS
* Bash: `5.0.16`

The examples for Windows were tested in the following environment:

* {{ yandex-cloud }} virtual machine running Windows Server 2019 Datacenter.
* Microsoft OpenJDK: `11.0.11`.
* PowerShell: `5.1.17763.1490 Desktop`.

## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash)/macOS (Zsh) {#bash-zsh}

To connect to an {{ KF }} cluster from the command line, use `kafkacat`, an open source application that can work as a universal data producer or consumer. For more information, see the [documentation](https://github.com/edenhill/kafkacat).

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y kafkacat
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Run this command for receiving messages from a topic:

      ```bash
      kafkacat -C \
               -b <broker_FQDN>:9092 \
               -t <topic_name> \
               -X security.protocol=SASL_PLAINTEXT \
               -X sasl.mechanism=SCRAM-SHA-512 \
               -X sasl.username="<consumer_username>" \
               -X sasl.password="<consumer_password>" -Z
      ```

      The command will continuously read new messages from the topic.

   1. In a separate terminal, run the command for sending a message to a topic:

      ```bash
      echo "test message" | kafkacat -P \
             -b <broker_FQDN>:9092 \
             -t <topic_name> \
             -k key \
             -X security.protocol=SASL_PLAINTEXT \
             -X sasl.mechanism=SCRAM-SHA-512 \
             -X sasl.username="<consumer_username>" \
             -X sasl.password="<producer_username>" -Z
      ```

- Connecting via SSL {#with-ssl}

   1. Run this command for receiving messages from a topic:

      {% include [default-get-string](../../../_includes/mdb/mkf/default-get-string.md) %}

      The command will continuously read new messages from the topic.

   1. In a separate terminal, run the command for sending a message to a topic:

      {% include [default-get-string](../../../_includes/mdb/mkf/default-send-string.md) %}

{% endlist %}

{% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

### Windows (PowerShell) {#powershell}

Before connecting:

1. Install the latest available version of [Microsoft OpenJDK](https://docs.microsoft.com/en-us/java/openjdk/download).

1. Download the [archive with binary files](https://kafka.apache.org/downloads) for the {{ KF }} version run by the cluster. Your Scala version is irrelevant.

1. Unpack the archive.

   {% note tip %}

   Unpack the {{ KF }} files to the root directory of the disk, for example, `C:\kafka_2.12-2.6.0\`.

   If the path to the {{ KF }} executable and batch files is too long, you will get the error saying `The input line is too long` when trying to run these files.

   {% endnote %}

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Run this command for receiving messages from a topic:

      ```powershell
      <path_to_the_directory_with_Apache_Kafka_files>\bin\windows\kafka-console-consumer.bat `
          --bootstrap-server <broker_FQDN>:9092 `
          --topic <topic_name> `
          --property print.key=true `
          --property key.separator=":" `
          --consumer-property security.protocol=SASL_PLAINTEXT `
          --consumer-property sasl.mechanism=SCRAM-SHA-512 `
          --consumer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<consumer_username>' password='<consumer_password>';"
      ```

      The command will continuously read new messages from the topic.

   1. In a separate terminal, run the command for sending a message to a topic:

      ```powershell
      echo "key:test message" | <path_to_the_directory_with_Apache_Kafka_files>\bin\windows\kafka-console-producer.bat `
          --bootstrap-server <broker_FQDN>:9092 `
          --topic <topic_name> `
          --property parse.key=true `
          --property key.separator=":" `
          --producer-property acks=all `
          --producer-property security.protocol=SASL_PLAINTEXT `
          --producer-property sasl.mechanism=SCRAM-SHA-512 `
          --producer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<producer_login>' password='<producer_password>';"
      ```

- Connecting via SSL {#with-ssl}

   1. Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ KF }} driver can use this certificate for secure connections to the cluster hosts. Set the password using the `-storepass` parameter for additional storage protection:

      ```powershell
      keytool.exe -importcert -alias {{ crt-alias }} `
        --file $HOME\.kafka\{{ crt-local-file }} `
        --keystore $HOME\.kafka\ssl `
        --storepass <certificate_store_password> `
        --noprompt
      ```

   1. Run this command for receiving messages from a topic:

      ```powershell
      <path_to_the_directory_with_Apache_Kafka_files>\bin\windows\kafka-console-consumer.bat `
          --bootstrap-server <broker_FQDN>:9091 `
          --topic <topic_name> `
          --property print.key=true `
          --property key.separator=":" `
          --consumer-property security.protocol=SASL_SSL `
          --consumer-property sasl.mechanism=SCRAM-SHA-512 `
          --consumer-property ssl.truststore.location=$HOME\.kafka\ssl `
          --consumer-property ssl.truststore.password=<certificate_store_password> `
          --consumer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<consumer_username>' password='<consumer_password>';"
      ```

      The command will continuously read new messages from the topic.

   1. In a separate terminal, run the command for sending a message to a topic:

      ```powershell
      echo "key:test message" | <path_to_the_directory_with_Apache_Kafka_files>\bin\windows\kafka-console-producer.bat `
          --bootstrap-server <broker_FQDN>:9091 `
          --topic <topic_name> `
          --property parse.key=true `
          --property key.separator=":" `
          --producer-property acks=all `
          --producer-property security.protocol=SASL_SSL `
          --producer-property sasl.mechanism=SCRAM-SHA-512 `
          --producer-property ssl.truststore.location=$HOME\.kafka\ssl `
          --producer-property ssl.truststore.password=<certificate_store_password> `
          --producer-property sasl.jaas.config="org.apache.kafka.common.security.scram.ScramLoginModule required username='<producer_password>' password='<producer_password>';"
      ```

{% endlist %}

{% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

## Before you connect from a Docker container {#docker}

To connect to a {{ mkf-name }} cluster from a Docker container, add the following lines to the Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

   ```bash
   RUN apt-get update && \
       apt-get install kafkacat --yes
   ```


- Connecting via SSL {#with-ssl}

   ```bash
   RUN apt-get update && \
       apt-get install wget kafkacat --yes && \
       mkdir --parents {{ crt-local-dir }} && \
       wget "{{ crt-web-path }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
       chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
   ```

{% endlist %}
