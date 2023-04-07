# Using Confluent Schema Registry with {{ mkf-short-name }}

{% note info %}

Besides Confluent Schema Registry, you can use [{{ mkf-msr }}](../../managed-kafka/concepts/managed-schema-registry.md#msr) integrated in a cluster.

{% endnote %}

{{ KF }} uses a binary format for storing and passing messages. Messages don't contain any information about their structure. As a result, to interpret data in binary format, the consumer needs a _data format schema_. It describes the format of data input or output.

Based on the data format schema, the producer generates and the consumer interprets messages from topics. If data format schemas differ between [producers and consumers](../../managed-kafka/concepts/producers-consumers.md), the application may throw errors because of incorrect message interpretation.

The developers of the producer and consumer must:

* Update data format schemas regularly and on time.
* Enable the producer and consumer to support several data format schema versions, if necessary.

[Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html) is one of the software solutions that helps avoid the problem of data format schema synchronization between producers and consumers.

It works as follows:

1. The producer delivers data format schemas to the Confluent _schema registry_ in a [supported format](https://docs.confluent.io/platform/current/schema-registry/serdes-develop/index.html):

   * [Avro](https://avro.apache.org/).
   * [JSON Schema](https://json-schema.org/).
   * [Protobuf](https://developers.google.com/protocol-buffers/).

1. Confluent Schema Registry lets you store data format schemas in the {{ KF }} service topic named `_schemas`. Each schema is assigned a unique version number.
1. The producer specifies the schema version number in a message being sent.
1. The consumer receives the message and reads the data format schema version.
1. If there's no necessary data format schema in the local cache, the consumer looks it up in the schema registry. After getting the necessary schema, it correctly interprets the received message.

To use {{ mkf-name }} with Confluent Schema Registry:

1. [Create a topic for notifications about changes in data format schemas](#create-schemas-topic).
1. [Install and configure Confluent Schema Registry on a VM](#configure-vm).
1. [Create producer and consumer scripts](#create-scripts).
1. [Make sure that Confluent Schema Registry is working correctly](#check-schema-registry).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) with any suitable configuration.

   1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `messages` for exchanging messages between the producer and the consumer.
   1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `user` and [grant it the rights](../../managed-kafka/operations/cluster-accounts.md#grant-permission) for the `messages` topic:
      * `ACCESS_ROLE_CONSUMER`.
      * `ACCESS_ROLE_PRODUCER`.


1. In the network hosting the {{ mkf-name }} cluster, [create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) with Ubuntu 20.04 and a public IP address.



1. If you are using security groups, [configure them](../../managed-kafka/operations/connect.md#configuring-security-groups) to allow all required traffic between the {{ mkf-name }} cluster and the VM.

   {% include [preview-pp.md](../../_includes/preview-pp.md) %}

1. In the VM security group, [add a rule](../../vpc/operations/security-group-add-rule.md) for incoming traffic that allows connections via port `8081` which is used by the producer and consumer to access the schema registry:

   * **Port range**: `8081`.
   * **Protocol**: `TCP`.
   * **Source type**: `CIDR`.
   * **CIDR blocks**: `0.0.0.0/0` or address ranges of the subnets where the producer and consumer run.


## Create a topic for notifications about changes in data format schemas {#create-schemas-topic}

1. [Create a service topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `_schemas` with the following settings:

   * **Number of partitions**: `1`.
   * **Cleanup policy**: `Compact`.

   Confluent Registry Schema requires the specified parameter values to run.

1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `registry` and [grant it the rights](../../managed-kafka/operations/cluster-accounts.md#grant-permission) for the `_schemas` topic:
   * `ACCESS_ROLE_CONSUMER`.
   * `ACCESS_ROLE_PRODUCER`.

   On behalf of this user, Confluent Schema Registry interacts with the `_schemas` service topic.

## Install and configure Confluent Schema Registry on a VM {#configure-vm}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

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
     password="<registry user password>";
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

The above scripts send and receive messages in the `messages` topic as a `key:value` pair. In the example, data format schemas are described in [Avro](https://avro.apache.org/) format.

{% note info %}

Python scripts are provided for demonstration. You can prepare and send data format schemas and the data itself by creating a similar script in another language.

{% endnote %}

1. Install the necessary Python packages:

   ```bash
   sudo pip3 install avro confluent_kafka
   ```

1. Create a Python script for the consumer.

   The script works as follows:

   1. Connect to the `messages` topic and Confluent Schema Registry.
   1. In a continuous cycle, read messages sent to the `messages` topic.
   1. When receiving a message, request the necessary schemas in Confluent Schema Registry to parse the message.
   1. Parse binary data from the message according to the schemas for the key and value and display the result on the screen.

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

   The script works as follows:

   1. Connect to Confluent Schema Registry and pass it the data format schemas for the key and value.
   1. Generate the key and value based on the passed schemas.
   1. Send a message consisting of the `key:value` pair to the `messages` topic. The schema versions are added to the message automatically.

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

1. Start the consumer:

   ```bash
   python3 ./consumer.py
   ```

1. In a separate terminal, start the producer:

   ```bash
   python3 ./producer.py
   ```

1. Make sure that the data sent by the producer is received and correctly interpreted by the consumer:

   ```text
   {'name': 'Value'}
   ```

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete the virtual machine](../../compute/operations/vm-control/vm-delete.md).
* [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
* If you reserved a public static IP address for the created VM, [delete it](../../vpc/operations/address-delete.md).
