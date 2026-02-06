---
title: Connecting to an {{ KF }} cluster in {{ mkf-full-name }}
description: Follow this guide to connect to {{ KF }} cluster hosts using command line tools and from a Docker container.
---

# Connecting to an {{ KF }} cluster from applications

This section provides settings for connecting to {{ mkf-name }} cluster hosts using [command line tools](#command-line-tools) and from a [Docker container](#docker). To learn how to connect from your application code, see [Code examples](code-examples.md).

You can only connect to public {{ KF }} cluster hosts using an [SSL certificate](index.md#get-ssl-cert). The examples below assume that the `{{ crt-local-file }}` certificate is located in this directory:

* `{{ crt-local-dir }}` for Ubuntu.
* `$HOME\.kafka\` for Windows.


Connecting without an SSL certificate is only supported for non-public hosts. If this is the case, internal virtual network traffic will not be encrypted when connecting to a database.

Before connecting, [configure security groups](index.md#configuring-security-groups) for the cluster, if required.


The examples for Linux were tested in the following environment:

* {{ yandex-cloud }} VM running Ubuntu 20.04 LTS.
* OpenJDK: `11.0.24`.
* Bash: `5.0.16`.

The examples for Windows were tested in the following environment:

* {{ yandex-cloud }} virtual machine running Windows Server 2019 Datacenter.
* Microsoft OpenJDK: `11.0.11`.
* PowerShell: `5.1.17763.1490 Desktop`.

## Command line tools {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### kafkacat {#bash-zsh}

[kafkacat](https://github.com/edenhill/kcat), or `kcat`, is an open source tool for producing and consuming data without installing Java Runtime Environment.

Before connecting, install the required dependencies:

```bash
sudo apt update && sudo apt install -y kafkacat
```

{% note info %}

On Ubuntu 24.04 or higher, use `kcat`.

{% endnote %}

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

  1. Run the following command to receive messages from the topic:

      ```bash
      kafkacat -C \
               -b <broker_FQDN>:9092 \
               -t <topic_name> \
               -X security.protocol=SASL_PLAINTEXT \
               -X sasl.mechanism=SCRAM-SHA-512 \
               -X sasl.username="<consumer_login>" \
               -X sasl.password="<consumer_password>" -Z
      ```

     This command will continuously read new messages from the topic.

  1. In a separate terminal, run the following command to send a message to the topic:

      ```bash
      echo "test message" | kafkacat -P \
             -b <broker_FQDN>:9092 \
             -t <topic_name> \
             -k key \
             -X security.protocol=SASL_PLAINTEXT \
             -X sasl.mechanism=SCRAM-SHA-512 \
             -X sasl.username="<producer_login>" \
             -X sasl.password="<producer_password>" -Z
      ```

- Connecting with SSL {#with-ssl}

  1. Run the following command to receive messages from the topic:

     {% include [default-get-string](../../../_includes/mdb/mkf/default-get-string.md) %}

     This command will continuously read new messages from the topic.

  1. In a separate terminal, run the following command to send a message to the topic:

     {% include [default-get-string](../../../_includes/mdb/mkf/default-send-string.md) %}

{% endlist %}

{% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

### {{ KF }} tools for Linux (Bash)/macOS (Zsh) {#kafka-sh}

{% include [kafka-cli-tools-intro](../../../_includes/mdb/mkf/kafka-cli-tools-intro.md) %}

Before connecting:

1. Install OpenJDK:

    ```bash
    sudo apt update && sudo apt install --yes default-jdk
    ```

1. Download the [archive with binary files](https://kafka.apache.org/downloads) for the {{ KF }} version running in your cluster. Your Scala version is irrelevant.

1. Unpack the archive.

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

    1. {% include [connect-properties-no-ssl](../../../_includes/mdb/mkf/connect-properties-no-ssl.md) %}

    1. Run the following command to receive messages from the topic:

        ```bash
        <path_to_directory_with_Apache_Kafka_files>/bin/kafka-console-consumer.sh \
          --consumer.config <path_to_file_with_consumer_configuration> \
          --bootstrap-server <broker_FQDN>:9092 \
          --topic <topic_name> \
          --property print.key=true \
          --property key.separator=":"
        ```

        This command will continuously read new messages from the topic.

    1. In a separate terminal, run the following command to send a message to the topic:

        ```bash
        echo "key:test message" | <path_to_directory_with_Apache_Kafka_files>/bin/kafka-console-producer.sh \
          --producer.config <path_to_file_with_producer_configuration> \
          --bootstrap-server <broker_FQDN>:9092 \
          --topic <topic_name> \
          --property parse.key=true \
          --property key.separator=":"
        ```

- Connecting with SSL {#with-ssl}

    1. Go to the folder where the Java certificate store will reside:

        ```bash
        cd /etc/security
        ```

    1. {% include [keytool-importcert](../../../_includes/mdb/keytool-importcert.md) %}

    1. Create two configuration files to connect to the cluster: one for the producer and one for the consumer.

        These files have the same content and differ only in user credentials:

        ```ini
        sasl.mechanism=SCRAM-SHA-512
        sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
          username="<producer_or_consumer_login>" \
          password="<producer_or_consumer_password>";
        security.protocol=SASL_SSL
        ssl.truststore.location=/etc/security/ssl
        ssl.truststore.password=<certificate_store_password>
        ```

    1. Run the following command to receive messages from the topic:

        ```bash
        <path_to_directory_with_Apache_Kafka_files>/bin/kafka-console-consumer.sh \
          --consumer.config <path_to_file_with_consumer_configuration> \
          --bootstrap-server <broker_FQDN>:9091 \
          --topic <topic_name> \
          --property print.key=true \
          --property key.separator=":"
        ```

        This command will continuously read new messages from the topic.

    1. In a separate terminal, run the following command to send a message to the topic:

        ```bash
        echo "key:test message" | <path_to_directory_with_Apache_Kafka_files>/bin/kafka-console-producer.sh \
          --producer.config <path_to_file_with_producer_configuration> \
          --bootstrap-server <broker_FQDN>:9091 \
          --topic <topic_name> \
          --property parse.key=true \
          --property key.separator=":"
        ```

{% endlist %}

{% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

### {{ KF }} tools for Windows (PowerShell) {#powershell}

{% include [kafka-cli-tools-intro](../../../_includes/mdb/mkf/kafka-cli-tools-intro.md) %}

While mentioning `.sh` scripts, the documentation for the tools is relevant for Windows as well. The tools are the same across platforms, and only the scripts that run them differ, as shown below:

* `bin/kafka-console-producer.sh` for Linux (Bash)/macOS (Zsh).
* `bin\windows\kafka-console-producer.bat` for Windows (PowerShell).

Before connecting:

1. Install the latest available version of [Microsoft OpenJDK](https://docs.microsoft.com/en-us/java/openjdk/download).

1. Download the [archive with binary files](https://kafka.apache.org/downloads) for the {{ KF }} version running in your cluster. Your Scala version is irrelevant.

1. Unpack the archive.

   {% note tip %}

   Unpack the {{ KF }} files to the disk root folder, e.g., `C:\kafka_2.12-2.6.0\`.

   If the path to the {{ KF }} executables and batch files is too long, you will get the `The input line is too long` error when trying to run them.

   {% endnote %}

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

  1. {% include [connect-properties-no-ssl](../../../_includes/mdb/mkf/connect-properties-no-ssl.md) %}

  1. Run the following command to receive messages from the topic:

      ```powershell
      <path_to_directory_with_Apache_Kafka_files>\bin\windows\kafka-console-consumer.bat `
          --consumer.config <path_to_file_with_consumer_configuration> `
          --bootstrap-server <broker_FQDN>:9092 `
          --topic <topic_name> `
          --property print.key=true `
          --property key.separator=":"
      ```

     This command will continuously read new messages from the topic.

  1. In a separate terminal, run the following command to send a message to the topic:

      ```powershell
      echo "key:test message" | <path_to_directory_with_Apache_Kafka_files>\bin\windows\kafka-console-producer.bat `
          --producer.config <path_to_file_with_producer_configuration> `
          --bootstrap-server <broker_FQDN>:9092 `
          --topic <topic_name> `
          --property parse.key=true `
          --property key.separator=":"
      ```

- Connecting with SSL {#with-ssl}

  1. Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ KF }} driver can use this certificate for secure connections to the cluster hosts. Set a password in the `--storepass` parameter for additional storage protection:

     ```powershell
     keytool.exe -importcert -alias {{ crt-alias }} `
       --file $HOME\.kafka\{{ crt-local-file }} `
       --keystore $HOME\.kafka\ssl `
       --storepass <certificate_store_password> `
       --noprompt
     ```

  1. Create two configuration files to connect to the cluster: one for the producer and one for the consumer.

     These files have the same content and differ only in user credentials:

     ```ini
     sasl.mechanism=SCRAM-SHA-512
     sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
       username="<producer_or_consumer_login>" \
       password="<producer_or_consumer_password>";
     security.protocol=SASL_SSL
     ssl.truststore.location=<$HOME_variable_value>\\.kafka\\ssl
     ssl.truststore.password=<certificate_store_password>
     ```

     Specify the full path to the certificate store as the `ssl.truststore.location` parameter value. Here is an example:

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

  1. Run the following command to receive messages from the topic:

      ```powershell
      <path_to_directory_with_Apache_Kafka_files>\bin\windows\kafka-console-consumer.bat `
          --consumer.config <path_to_file_with_consumer_configuration> `
          --bootstrap-server <broker_FQDN>:9091 `
          --topic <topic_name> `
          --property print.key=true `
          --property key.separator=":"
      ```

     This command will continuously read new messages from the topic.

  1. In a separate terminal, run the following command to send a message to the topic:

      ```powershell
      echo "key:test message" | <path_to_directory_with_Apache_Kafka_files>\bin\windows\kafka-console-producer.bat `
          --producer.config <path_to_file_with_producer_configuration> `
          --bootstrap-server <broker_FQDN>:9091 `
          --topic <topic_name> `
          --property parse.key=true `
          --property key.separator=":"
      ```

{% endlist %}

{% include [fqdn](../../../_includes/mdb/mkf/fqdn-host.md) %}

{% include [shell-howto](../../../_includes/mdb/mkf/connstr-shell-howto.md) %}

## Before you connect from a Docker container {#docker}

To connect to a {{ mkf-name }} cluster from a Docker container, add the following lines to your Dockerfile:

{% list tabs group=connection %}


- Connecting without SSL {#without-ssl}

  ```bash
  RUN apt-get update && \
      apt-get install kafkacat --yes
  ```


- Connecting with SSL {#with-ssl}

  ```bash
  RUN apt-get update && \
      apt-get install wget kafkacat --yes && \
      mkdir --parents {{ crt-local-dir }} && \
      wget "{{ crt-web-path }}" \
           --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
      chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
  ```

{% endlist %}
