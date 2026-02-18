# Fetching data from {{ RMQ }} to {{ mch-full-name }}


You can supply data from {{ RMQ }} to a {{ mch-name }} cluster in real time. {{ mch-name }} will automatically insert the data routed into particular exchange points of the specified {{ RMQ }} queues into a [{{ RMQ }}]({{ ch.docs }}/engines/table-engines/integrations/rabbitmq/) table.

To set up data delivery from {{ RMQ }} to {{ mch-name }}:

1. [Set up {{ RMQ }} integration for your {{ mch-name }} cluster](#configure-mch-for-rmq).
1. [Create a {{ RMQ }} table in the {{ mch-name }} cluster](#create-rmq-table).
1. [Send the test data to the {{ RMQ }} queue](#send-sample-data-to-rmq).
1. [Make sure the test data appears in the {{ mch-name }} cluster table](#fetch-sample-data).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mch-name }} cluster fee, which covers the use of computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* VM fee, which covers the use of computing resources, storage, and, optionally, public IP address (see [{{ compute-name }} pricing](../../compute/pricing.md)).


## Getting started {#before-you-begin}

### Set up your infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with your preferred configuration and add the database named `db1`. Enable public access to the cluster during creation so you can connect to it from your local machine. Connections from within the {{ yandex-cloud }} network are enabled by default.

        {% include [public-access](../../_includes/mdb/note-public-access.md) %}

        Integration with {{ RMQ }} is available during cluster setup. In this example, however, we will configure the integration [at a later stage](#configure-mch-for-rmq).

    1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) for {{ RMQ }}. Enable public access to the VM during creation so you can connect to it from your local machine. Connections from the {{ yandex-cloud }} network are enabled by default.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [clickhouse-cluster-and-vm-for-rabbitmq.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-fetch-data-from-rabbitmq/blob/main/clickhouse-cluster-and-vm-for-rabbitmq.tf) configuration file to your current working directory.

        This file describes:

        * Network.
        * Subnet.
        * Default security group and inbound internet rules for your cluster and VM.
        * {{ mch-name }} cluster.
        * Virtual machine.

    1. In the `clickhouse-cluster-and-vm-for-rabbitmq.tf` file, specify the following:

        * Username and password that will be used to access the {{ mch-name }} cluster.
        * ID of the public, non-GPU [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) [image](../../compute/operations/images-with-pre-installed-software/get-list.md) to use for the VM.
        * Username and path to the SSH [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for VM access. By default, the pre-configured image ignores the specified username and automatically creates a user named `ubuntu`. Use it to connect to the VM.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Configure additional settings {#additional-settings}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to a virtual machine over SSH.

    1. Install {{ RMQ }}:

        ```bash
        sudo apt update && sudo apt install rabbitmq-server --yes
        ```

    1. Create a user for {{ RMQ }}:

        ```bash
        sudo rabbitmqctl add_user <username> <password>
        ```

    1. Grant this user permissions to connect to the server:

        ```bash
        sudo rabbitmqctl set_permissions -p / <username> ".*" ".*" ".*" && \
        sudo rabbitmqctl set_topic_permissions -p / <username> amq.topic "cars" "cars"
        ```

1. Install the `amqp-publish` and `amqp-declare-queue` tools for {{ RMQ }} and [jq](https://stedolan.github.io/jq/) for processing JSON streams:

    ```bash
    sudo apt update && sudo apt install amqp-tools --yes && sudo apt-get install jq --yes
    ```

1. Use `amqp-declare-queue` to create a queue named `cars` in {{ RMQ }}:

    ```bash
    amqp-declare-queue \
        --url=amqp://<username>:<password>@<IP_address_or_FQDN_of_the_RabbitMQ_server>:5672 \
        --queue=cars
    ```

1. Install `clickhouse-client` to connect to the database in your {{ mch-name }} cluster.

    1. Add the {{ CH }} [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages):

        ```bash
        sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
        echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
        /etc/apt/sources.list.d/clickhouse.list
        ```

    1. Install the dependencies:

        ```bash
        sudo apt update && sudo apt install clickhouse-client --yes
        ```

    1. Download the `clickhouse-client` configuration file:

        {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

    Verify that you can [establish an SSL connection to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) via `clickhouse-client`.

## Set up the {{ RMQ }} integration for the {{ mch-name }} cluster {#configure-mch-for-rmq}

{% list tabs group=instructions %}

- Manually {#manual}

    In the [{{ mch-name }} cluster settings](../../managed-clickhouse/operations/change-server-level-settings.md#yandex-cloud-interfaces), navigate to the **{{ ui-key.yacloud.mdb.forms.section_settings }}** → **Rabbitmq** section and specify the username and password for {{ RMQ }} authentication.

- {{ TF }} {#tf}

    Add the `clickhouse.config.rabbitmq` block containing {{ RMQ }} username and password to the cluster configuration:

    ```hcl
    resource "yandex_mdb_clickhouse_cluster" "clickhouse-cluster" {
      ...
      clickhouse {
        ...
        config {
          rabbitmq {
            username = "<username>"
            password = "<password>"
          }
        }
        ...
      }
    }
    ```

{% endlist %}

## Create a {{ RMQ }} engine table {#create-rmq-table} in your {{ mch-name }} cluster

Suppose, you publish the following JSON car sensor data to the {{ RMQ }} exchange named `exchange`, which routes it to the `cars` queue:

* `device_id`: Device string identifier.
* `datetime`: Date and time of data generation in `YYYY-MM-DD HH:MM:SS` format.
* Car coordinates:

    * `latitude`: Latitude.
    * `longitude`: Longitude.
    * `altitude`: Height above mean sea level.

* `speed`: Current speed.
* `battery_voltage`: Battery voltage for electric cars. `null` for ICE vehicles.
* `cabin_temperature`: Temperature inside the car.
* `fuel_level`: Fuel level for ICE cars. `null` for electric cars.

This data will be transmitted as {{ RMQ }} messages. Each message will contain a string containing a serialized JSON object with the following structure:

```json
{"device_id":"iv9a94th6rzt********","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

For table inserts, the {{ mch-name }} cluster will use the [JSONEachRow format]({{ ch.docs }}/interfaces/formats/#jsoneachrow) that parses rows from {{ RMQ }} messages into the required column values.

In the {{ mch-name }} cluster, create a table to store data incoming from {{ RMQ }}:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) to the `db1` database on your {{ mch-name }} cluster via `clickhouse-client`.

1. Run this query:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.cars (
        device_id String,
        datetime DateTime,
        latitude Float32,
        longitude Float32,
        altitude Float32,
        speed Float32,
        battery_voltage Nullable(Float32),
        cabin_temperature Float32,
        fuel_level Nullable(Float32)
    ) ENGINE = RabbitMQ
    SETTINGS
        rabbitmq_host_port = '<internal_IP_address_of_VM_with_RabbitMQ>:5672',
        rabbitmq_routing_key_list = 'cars',
        rabbitmq_exchange_name = 'exchange',
        rabbitmq_format = 'JSONEachRow';
    ```

This table will be automatically populated with messages consumed from the `cars` queue, which is bound to {{ RMQ }} `exchange`. When reading the data, {{ mch-name }} uses the [authentication credentials provided earlier](#configure-mch-for-rmq).

## Send the test data to the {{ RMQ }} queue {#send-sample-data-to-rmq}

1. Create a file named `sample.json` with test data:

    ```json
    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-05 17:27:00",
        "latitude": 55.70329032,
        "longitude": 37.65472196,
        "altitude": 427.5,
        "speed": 0,
        "battery_voltage": 23.5,
        "cabin_temperature": 17,
        "fuel_level": null
    }

    {
        "device_id": "rhibbh3y08qm********",
        "datetime": "2020-06-06 09:49:54",
        "latitude": 55.71294467,
        "longitude": 37.66542005,
        "altitude": 429.13,
        "speed": 55.5,
        "battery_voltage": null,
        "cabin_temperature": 18,
        "fuel_level": 32
    }

    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-07 15:00:10",
        "latitude": 55.70985913,
        "longitude": 37.62141918,
        "altitude": 417.0,
        "speed": 15.7,
        "battery_voltage": 10.3,
        "cabin_temperature": 17,
        "fuel_level": null
    }
    ```

1. Use `jq` and `amqp-publish` to send data from `sample.json` to the previously created `cars` queue via `exchange`.

    ```bash
    jq \
    --raw-output \
    --compact-output . ./sample.json |\
    amqp-publish \
    --url=amqp://<RabbitMQ_username>:<password>@<IP_address_or_FQDN_of_the_RabbitMQ_server>:5672 \
    --routing-key=cars \
    --exchange=exchange
    ```

## Make sure the test data appears in the {{ mch-name }} cluster table {#fetch-sample-data}

To access the data, use a materialized view. Once a materialized view is attached to a `{{ RMQ }}` table, it starts gathering data in the background automatically. This enables the system to continuously consume messages from {{ RMQ }} and convert them to the required format using `SELECT`.

{% note info %}

A message from the queue can be read by {{ CH }} only once. Therefore, instead of reading data directly from the table, use a materialized view.

{% endnote %}

To create a materialized view for the `db1.cars` table:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) to the `db1` database on your {{ mch-name }} cluster via `clickhouse-client`.

1. Run the following queries:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.cars_data_source (
        device_id String,
        datetime DateTime,
        latitude Float32,
        longitude Float32,
        altitude Float32,
        speed Float32,
        battery_voltage Nullable(Float32),
        cabin_temperature Float32,
        fuel_level Nullable(Float32)
    ) ENGINE MergeTree()
      ORDER BY device_id;

    CREATE MATERIALIZED VIEW db1.cars_view TO db1.cars_data_source
      AS SELECT * FROM db1.cars;
    ```

To retrieve all data from the `db1.cars_view` materialized view:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) to the `db1` database on your {{ mch-name }} cluster via `clickhouse-client`.

1. Run this query:

    ```sql
    SELECT * FROM db1.cars_view;
    ```

The query results will show all data sent to {{ RMQ }}.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Delete the {{ mch-full-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
    * [Delete the virtual machine](../../compute/operations/vm-control/vm-delete.md).
    * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
