{{ KFC }} is a tool for streaming data between {{ KF }} and other data stores.

Data in {{ KFC }} is handled using processes called _workers_. You can deploy the tool either in distributed mode with multiple workers or standalone mode with a single worker.

Data is moved using _connectors_ that are run in separate worker threads.

For more information about Kafka Connect, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connect).

Next, we'll configure {{ KFC }} to interact with a {{ mkf-name }} cluster. We'll deploy the tool on a [{{ yandex-cloud }} VM](../../compute/concepts/vm.md) in standalone mode. SSL encryption will be used to protect the connection.

We'll also set up a simple connector, [FileStreamSource](https://docs.confluent.io/home/connect/filestream_connector.html). {{ KFC }} will use it to read data from a test JSON file and pass it to a cluster topic.

{% note info %}

You can use any other {{ KFC }} connector to interact with {{ mkf-name }} clusters.

{% endnote %}

To configure {{ KFC }} to work with a {{ mkf-name }} cluster:

1. [Configure the VM](#prepare-vm).
1. [Configure {{ KFC }}](#configure-kafka-connect).
1. [Run {{ KFC }} and test it](#test-kafka-connect).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration.

    1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `messages` for exchanging messages between {{ KFC }} and the {{ mkf-name }} cluster.
    1. [Create an account](../../managed-kafka/operations/cluster-accounts.md#create-account) with the `user` name and [grant it rights](../../managed-kafka/operations/cluster-accounts.md#grant-permission) to the `messages` topic:
        * `ACCESS_ROLE_CONSUMER`
        * `ACCESS_ROLE_PRODUCER`

1. In the same network as the {{ mkf-name }} cluster, [create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) with Ubuntu 20.04 and a public IP address.

1. Prepare the VM to work with {{ KFC }}:

    1. [Connect to the VM over SSH](../../compute/operations/vm-connect/ssh.md).

    1. Install the JDK:

        ```bash
        sudo apt update && \
        sudo apt install openjdk-11-jre-headless --yes
        ```

    1. [Download](https://downloads.apache.org/kafka/) the {{ KF }} archive and unpack it:

        ```bash
        wget https://downloads.apache.org/kafka/2.6.2/kafka_2.12-2.6.2.tgz && \
        tar -xvf kafka_2.12-2.6.2.tgz
        ```

    1. Install the [Kafkacat](https://docs.confluent.io/platform/current/app-development/kafkacat-usage.html) utility:

        ```bash
        sudo apt install kafkacat
        ```

## Configure the VM {#prepare-vm}

1. [Connect to the VM over SSH](../../compute/operations/vm-connect/ssh.md).

1. [Get an SSL certificate](../../managed-kafka/operations/connect#get-ssl-cert).

1. {% include [keytool-importcert](../../_includes/mdb/keytool-importcert.md) %}

1. Create a folder with worker settings and copy the store there:

    ```bash
    sudo mkdir -p /etc/kafka-connect-worker && \
    sudo cp ssl /etc/kafka-connect-worker/client.truststore.jks
    ```

1. Create a `/var/log/sample.json` file with test data. This file contains data from car sensors in JSON format:

    {% cut "sample.json" %}

    ```json
    {"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-05 17:27:00","latitude":55.70329032,"longitude":37.65472196,"altitude":427.5,"speed":0,"battery_voltage":23.5,"cabin_temperature":17,"fuel_level":null}
    {"device_id":"rhibbh3y08qmz3sdbrbu","datetime":"2020-06-06 09:49:54","latitude":55.71294467,"longitude":37.66542005,"altitude":429.13,"speed":55.5,"battery_voltage":null,"cabin_temperature":18,"fuel_level":32}
    {"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-07 15:00:10","latitude":55.70985913,"longitude":37.62141918,"altitude":417,"speed":15.7,"battery_voltage":10.3,"cabin_temperature":17,"fuel_level":null}
    ```

    {% endcut %}

## Configure {{ KFC }} {#configure-kafka-connect}

1. Create a file named `/etc/kafka-connect-worker/worker.properties` with worker settings:

    {% cut "worker.properties" %}

    ```ini
    # AdminAPI connect properties
    bootstrap.servers=<broker host FQDN>:9091
    sasl.mechanism=SCRAM-SHA-512
    security.protocol=SASL_SSL
    ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
    ssl.truststore.password=<certificate store password>
    sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="user" password="<user account password>";
    
    # Producer connect properties
    producer.sasl.mechanism=SCRAM-SHA-512
    producer.security.protocol=SASL_SSL
    producer.ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
    producer.ssl.truststore.password=<certificate store password>
    producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="user" password="<user account password>";
    
    # Worker properties
    plugin.path=/etc/kafka-connect-worker/plugins
    key.converter=org.apache.kafka.connect.json.JsonConverter
    value.converter=org.apache.kafka.connect.json.JsonConverter
    key.converter.schemas.enable=true
    value.converter.schemas.enable=true
    offset.storage.file.filename=/etc/kafka-connect-worker/worker.offset
    ```

    {% endcut %}

    {{ KFC }} will connect to the {{ mkf-name }} cluster under the `user` account [created earlier](#before-you-begin).

    You can request the FQDNs of broker hosts with a [list of hosts in the cluster](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

1. Create a file named `/etc/kafka-connect-worker/file-connector.properties` with connector settings:

    ```ini
    name=local-file-source
    connector.class=FileStreamSource
    tasks.max=1
    file=/var/log/sample.json
    topic=messages
    ```

    Where:
    * `file`: The name of the file that the connector will read data from.
    * `topic`: The name of the {{ mkf-name }} cluster topic that the connector will pass data to.

## Run {{ KFC }} and test it {#test-kafka-connect}

1. To send test data to the cluster, run the worker on the VM:

    ```bash
    cd ~/kafka_2.12-2.6.2/bin/ && \
    sudo ./connect-standalone.sh \
         /etc/kafka-connect-worker/worker.properties \
         /etc/kafka-connect-worker/file-connector.properties
    ```

1. Connect to the cluster [using Kafkacat](../../managed-kafka/operations/connect.md#bash) and get the data from the cluster topic:

    ```bash
    kafkacat -C \
        -b <broker host FQDN>:9091 \
        -t messages \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=user \
        -X sasl.password=<user account password> \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexCA.crt -Z -K:
    ```

    You can request the FQDNs of broker hosts with a [list of hosts in the cluster](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

    The command output will contain the contents of the `/var/log/sample.json` test file passed in the previous step.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

* [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
* If you reserved a public static IP address for the VM, [delete it](../../vpc/operations/address-delete.md).
* [Delete the cluster {{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).

