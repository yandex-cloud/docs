# Connecting to topics in an Apache Kafka® cluster

You can connect to {{ mkf-name }} cluster hosts:

- Over the internet if you configured public access for the cluster [when creating it](cluster-create.md). You can only connect to such clusters over an [SSL connection](#get-ssl-cert).
- From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../vpc/concepts/network.md). If the cluster isn't publicly available, you don't need to use an SSL connection to connect to such VMs.


You can connect to the {{ KF }} cluster both with encryption (`SASL_SSL`, port 9091) and without it (`SASL_PLAINTEXT`, port 9092).

To connect to an {{ KF }} cluster:

1. [Create accounts](cluster-accounts.md#create-account) for clients (producers and consumers) with access to the necessary topics.
1. Connect the clients to the cluster:
   * Producers using the [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi).
   * Consumers using the [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

There are ready-made {{ KF }} API implementations for most popular programming languages. See code examples for connecting to a cluster in [{#T}](#connection-string).

## Get an SSL certificate {#get-ssl-cert}

To use an encrypted SSL connection, you need to get an SSL certificate:


```bash
sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
```

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mkf-conn-strings-env.md) %}

Before connecting to cluster hosts over an SSL connection, [prepare a certificate](#get-ssl-cert). In the examples below, it is assumed that the `YandexCA.crt` certificate is located in the `/usr/local/share/ca-certificates/Yandex/` folder.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mkf-connection-strings](../../_includes/mdb/mkf-conn-strings.md) %}

First, launch the consumer application that will continuously read new messages from the topic. Then launch the producer application that will send one or more `test message` messages with the `key` key to the {{ KF }} topic. The consumer application displays messages sent to the topic.
