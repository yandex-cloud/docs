
{% note info %}

In {{ mkf-name }}, you can use a built-in [{{ mkf-msr }}](../../managed-kafka/concepts/managed-schema-registry.md#msr) data format schema registry. For more information, see [{#T}](../../managed-kafka/tutorials/managed-schema-registry.md). If you need [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html), use the information from this guide.

{% endnote %}

To use Confluent Schema Registry together with {{ mkf-name }}:

1. [Create a topic for notifications about changes in data format schemas](#create-schemas-topic).
1. [Install and configure Confluent Schema Registry on a VM](#configure-vm).
1. [Create producer and consumer scripts](#create-scripts).
1. [Make sure that Confluent Schema Registry is working correctly](#check-schema-registry).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) with any suitable configuration.

    1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `messages` for exchanging messages between the producer and the consumer.
    1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `user` and [grant it the rights](../../managed-kafka/operations/cluster-accounts.md#grant-permission) for the `messages` topic:
        * `ACCESS_ROLE_CONSUMER`
        * `ACCESS_ROLE_PRODUCER`


1. In the network hosting the {{ mkf-name }} cluster, [create a VM](../../compute/operations/vm-create/create-linux-vm.md) with [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) from {{ marketplace-name }} and with a public IP address.



1. If you are using security groups, [configure them](../../managed-kafka/operations/connect.md#configuring-security-groups) to allow all required traffic between the {{ mkf-name }} cluster and the VM.

   {% include [preview-pp.md](../../_includes/preview-pp.md) %}

1. In the VM security group, [add a rule](../../vpc/operations/security-group-add-rule.md) for incoming traffic that allows connections via port `8081` which is used by the producer and consumer to access the schema registry:

    * **Port range**: `8081`.
    * **Protocol**: `TCP`.
    * **Destination**: `CIDR`.
    * **CIDR blocks**: `0.0.0.0/0` or address ranges of the subnets where the producer and consumer run.


## Create a topic for notifications about changes in data format schemas {#create-schemas-topic}

1. [Create a service topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `_schemas` with the following settings:

   * **Number of partitions**: `1`.
   * **Cleanup policy**: `Compact`.

   {% note warning %}

   Confluent Schema Registry requires the specified **Number of partitions** and **Cleanup policy** settings to operate.

   {% endnote %}

1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `registry` and [grant it the rights](../../managed-kafka/operations/cluster-accounts.md#grant-permission) for the `_schemas` topic:
    * `ACCESS_ROLE_CONSUMER`
    * `ACCESS_ROLE_PRODUCER`

    Confluent Schema Registry will interact with the `_schemas` service topic on behalf of this user.

## Install and configure Confluent Schema Registry on a VM {#configure-vm}

1. [Connect to the virtual machine over SSH](../../compute/operations/vm-connect/ssh.md).

1. Add the Confluent Schema Registry repository:

    ```bash
    wget -qO - https://packages.confluent.io/deb/6.2/archive.key | sudo apt-key add - && \
    sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/6.2 stable main"
    ```

1. Install the packages:

    ```bash
    sudo apt-get update && \
    sudo apt-get install \
         confluent-schema-registry \
         openjdk-11-jre-headless \
         python3-pip --yes
    ```

1. [Get an SSL certificate](../../managed-kafka/operations/connect.md#get-ssl-cert).

1. Create secure storage for the certificate:

    ```bash
    sudo keytool \
         -keystore /etc/schema-registry/client.truststore.jks \
         -alias CARoot \
         -import -file {{ crt-local-dir }}{{ crt-local-file }} \
         -storepass <password for the secure certificate store> \
         --noprompt
    ```

1. Create the `/etc/schema-registry/jaas.conf` file with settings for connecting to the cluster:

    ```scala
    KafkaClient {
      org.apache.kafka.common.security.scram.ScramLoginModule required
      username="registry"
      password="<password for the registry account>";
    };
    ```

1. Edit the `/etc/schema-registry/schema-registry.properties` file that configures Confluent Schema Registry:

    1. Comment out the line:

        ```ini
        kafkastore.bootstrap.servers=PLAINTEXT://localhost:9092
        ```

    1. Uncomment the line with the `listeners` parameter. It configures the network address and port that Confluent Schema Registry listens to. The default port for all network interfaces is `8081`:

        ```ini
        listeners=http://0.0.0.0:8081
        ```

    1. Add the following lines at the end of the file:

        ```ini
        kafkastore.bootstrap.servers=SASL_SSL://<FQDN of the 1st broker host:9091>,<FQDN of the 2nd broker host:9091>,...,<FQDN of the Nth broker host:9091>
        kafkastore.ssl.truststore.location=/etc/schema-registry/client.truststore.jks
        kafkastore.ssl.truststore.password=<password for a secure certificate store>
        kafkastore.sasl.mechanism=SCRAM-SHA-512
        kafkastore.security.protocol=SASL_SSL
        ```

        You can get a list of broker hosts [with a list of cluster hosts](../../managed-kafka/operations/cluster-hosts.md).

1. Edit the file with the description of the systemd module `/lib/systemd/system/confluent-schema-registry.service`.

    1. Go to the `[Service]` section.
    1. Add the `Environment` parameter with Java settings:

        ```ini
        ...

        [Service]
        Type=simple
        User=cp-schema-registry
        Group=confluent
        Environment="LOG_DIR=/var/log/confluent/schema-registry"
        Environment="_JAVA_OPTIONS='-Djava.security.auth.login.config=/etc/schema-registry/jaas.conf'"
        ...
        ```

1. Update the details about the systemd modules:

    ```bash
    sudo systemctl daemon-reload
    ```

1. Start the Confluent Schema Registry service:

    ```bash
    sudo systemctl start confluent-schema-registry.service
    ```

1. Enable automatic start of Confluent Schema Registry after OS restart:

    ```bash
    sudo systemctl enable confluent-schema-registry.service
    ```

## Create producer and consumer scripts {#create-scripts}

{% include [Schema registry scripts explanation](./schema-registry-scripts-explanation.md) %}

1. Install the necessary Python packages:

    ```bash
    sudo pip3 install avro confluent_kafka
    ```

1. Create a Python script for the consumer.

    {% include [Consumer script algorithm](./consumer-script-algorithm.md) %}

    `consumer.py`

    ```python
    #!/usr/bin/python3

    from confluent_kafka.avro import AvroConsumer
    from confluent_kafka.avro.serializer import SerializerError


    c = AvroConsumer(
        {
            "bootstrap.servers": ','.join([
                "<FQDN of the 1st broker host>:9091",
                ...
                "<FQDN of the Nth broker host>:9091",
            ]),
            "group.id": "avro-consumer",
            "security.protocol": "SASL_SSL",
            "ssl.ca.location": "{{ crt-local-dir }}{{ crt-local-file }}",
            "sasl.mechanism": "SCRAM-SHA-512",
            "sasl.username": "user",
            "sasl.password": "<password of the user named user>",
            "schema.registry.url": "http://<FQDN or IP address of the Confluent Schema Registry server>:8081",
        }
    )

    c.subscribe(["messages"])

    while True:
        try:
            msg = c.poll(10)

        except SerializerError as e:
            print("Message deserialization failed for {}: {}".format(msg, e))
            break

        if msg is None:
            continue

        if msg.error():
            print("AvroConsumer error: {}".format(msg.error()))
            continue

        print(msg.value())

    c.close()
    ```

1. Create a Python script for the producer.

    {% include [Producer script algorithm](./producer-script-algorithm.md) %}

    `producer.py`

    ```python
    #!/usr/bin/python3

    from confluent_kafka import avro
    from confluent_kafka.avro import AvroProducer


    value_schema_str = """
    {
        "namespace": "my.test",
        "name": "value",
        "type": "record",
        "fields": [
            {
                "name": "name",
                "type": "string"
            }
        ]
    }
    """

    key_schema_str = """
    {
        "namespace": "my.test",
        "name": "key",
        "type": "record",
        "fields": [
            {
                "name": "name",
                "type": "string"
            }
        ]
    }
    """

    value_schema = avro.loads(value_schema_str)
    key_schema = avro.loads(key_schema_str)
    value = {"name": "Value"}
    key = {"name": "Key"}


    def delivery_report(err, msg):
        """Called once for each message produced to indicate delivery result.
        Triggered by poll() or flush()."""
        if err is not None:
            print("Message delivery failed: {}".format(err))
        else:
            print("Message delivered to {} [{}]".format(msg.topic(), msg.partition()))


    avroProducer = AvroProducer(
        {
            "bootstrap.servers": ','.join([
                "<FQDN of the 1st broker host>:9091",
                ...
                "<FQDN of the Nth broker host>:9091",
            ]),
            "security.protocol": "SASL_SSL",
            "ssl.ca.location": "{{ crt-local-dir }}{{ crt-local-file }}",
            "sasl.mechanism": "SCRAM-SHA-512",
            "sasl.username": "user",
            "sasl.password": "<password of the user named user>",
            "on_delivery": delivery_report,
            "schema.registry.url": "http://<FQDN or IP address of the Schema Registry server>:8081",
        },
        default_key_schema=key_schema,
        default_value_schema=value_schema,
    )

    avroProducer.produce(topic="messages", key=key, value=value)
    avroProducer.flush()
    ```

## Make sure that Confluent Schema Registry is working correctly {#check-schema-registry}

{% include [Check schema registry](./check-schema-registry.md) %}

## Delete the resources you created {#clear-out}

{% include [Clear out](./clear-out.md) %}
