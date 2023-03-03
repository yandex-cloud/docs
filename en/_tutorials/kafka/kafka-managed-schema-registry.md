To use [{{ mkf-msr }}](../../managed-kafka/concepts/managed-schema-registry.md#msr) with {{ mkf-name }}:

1. [Create the producer and consumer scripts on the local machine](#create-scripts).
1. [Check that {{ mkf-msr }} runs correctly](#check-schema-registry).
1. [Delete the resources you created](#clear-out).

## Before you begin {#before-you-begin}

1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) with any suitable configuration. When creating a cluster, enable **Schema registry** and **Public access**.

   1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `messages` for exchanging messages between the producer and the consumer.
   1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `user` and [grant it the rights](../../managed-kafka/operations/cluster-accounts.md#grant-permission) for the `messages` topic:
      * `ACCESS_ROLE_CONSUMER`,
      * `ACCESS_ROLE_PRODUCER`.

1. In the network hosting the {{ mkf-name }} cluster, [create a VM](../../compute/operations/vm-create/create-linux-vm.md) with Ubuntu 20.04 and a public IP address.


1. To allow traffic between the {{ mkf-name }} cluster and the virtual machine, [configure security groups](../../managed-kafka/operations/connect.md#configuring-security-groups).


## Create producer and consumer scripts {#create-scripts}

{% include [Schema registry scripts explanation](./schema-registry-scripts-explanation.md) %}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

1. Install the necessary Python packages:

   ```bash
   sudo apt-get update && \
   sudo pip3 install avro confluent_kafka
   ```

1. To use an encrypted connection, install an SSL certificate.

   ```bash
   sudo mkdir -p /usr/share/ca-certificates && \
   sudo wget "{{ crt-web-path }}" \
             -O /usr/share/ca-certificates/{{ crt-local-file }} && \
   sudo chmod 655 /usr/share/ca-certificates/{{ crt-local-file }}
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
           "<FQDN of first broker host>:9091",
           ...
           "<FQDN of the Nth broker host>:9091",
           ]),
           "group.id": "avro-consumer",
           "security.protocol": "SASL_SSL",
           "ssl.ca.location": "/usr/share/ca-certificates/{{ crt-local-file }}",
           "sasl.mechanism": "SCRAM-SHA-512",
           "sasl.username": "user",
           "sasl.password": "<password of the user named user>",
           "schema.registry.url": "https://<FQDN or IP address of the {{ mkf-msr }} server>:443",
           "schema.registry.basic.auth.credentials.source": "SASL_INHERIT",
           "schema.registry.ssl.ca.location": "/usr/share/ca-certificates/{{ crt-local-file }}",
           "auto.offset.reset": "earliest"
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
           "security.protocol": 'SASL_SSL',
           "ssl.ca.location": '/usr/share/ca-certificates/{{ crt-local-file }}',
           "sasl.mechanism": 'SCRAM-SHA-512',
           "sasl.username": 'user',
           "sasl.password": '<password of the user named user>',
           "on_delivery": delivery_report,
           "schema.registry.basic.auth.credentials.source": 'SASL_INHERIT',
           "schema.registry.url": 'https://<FQDN or IP address of the {{ mkf-msr }} server>:443',
           "schema.registry.ssl.ca.location": "/usr/share/ca-certificates/{{ crt-local-file }}"
       },
       default_key_schema=key_schema,
       default_value_schema=value_schema
   )

   avroProducer.produce(topic="messages", key=key, value=value)
   avroProducer.flush()
   ```

## Check that {{ mkf-msr }} runs correctly {#check-schema-registry}

{% include [Check schema registry](./check-schema-registry.md) %}

## Delete the resources you created {#clear-out}

{% include [Clear out](./clear-out.md) %}
