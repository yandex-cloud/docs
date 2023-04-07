# Fetching data from {{ RMQ }} to {{ mch-full-name }}

A {{ mch-name }} cluster can get data from {{ RMQ }} in real time. {{ mch-name }} automatically inserts data sent to specific queue {{ RMQ }} exchanges into a table run on the [{{ RMQ }} engine]({{ ch.docs }}/engines/table-engines/integrations/rabbitmq/).

To set up data delivery from {{ RMQ }} to {{ mch-name }}:
1. [Set up integration with {{ RMQ }} for the {{ mch-name }} cluster](#configure-mch-for-rmq).
1. [In the {{ mch-name }} cluster, create a table on the {{ RMQ }} engine](#create-rmq-table).
1. [Send the test data to the {{ RMQ }} queue](#send-sample-data-to-rmq).
1. [Check that the test data is present in the {{ mch-name }} cluster table](#fetch-sample-data).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

  1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with any configuration with the `db1` database. To connect to the cluster from the user's local machine instead of the {{ yandex-cloud }} cloud network, enable public access to the cluster hosts when creating it.

     {% note info %}

     You can set up {{ RMQ }} integration when creating a cluster. In this article, integration will be configured [later](#configure-mch-for-rmq).

     {% endnote %}

  1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md)for{{ RMQ }}. To connect to the cluster from the user's local machine instead of the {{ yandex-cloud }} cloud network, enable public access when creating it.

- Using {{ TF }}

  1. If you do not have {{ TF }} yet, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Download the [clickhouse-cluster-and-vm-for-rabbitmq.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/clickhouse-cluster-and-vm-for-rabbitmq.tf) configuration file to the same working directory.

     This file describes:
     * Network.
     * Subnet.
     * Default security group and rules required to connect to the cluster and VM from the internet.
     * {{ mch-name }} cluster.
     * Virtual machine.
  1. Specify in `clickhouse-cluster-and-vm-for-rabbitmq.tf`:
     * Username and password that will be used to access a {{ mch-name }} cluster.
     * The ID of the public Ubuntu [image](../../compute/operations/images-with-pre-installed-software/get-list.md) without GPU for the VM. For example, `fd879gb88170to70d38a` for Ubuntu 20.04 LTS.
     * Username and path to the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file to use to access to the virtual machine. By default, the specified username is ignored in the image used. Instead, a user with the `ubuntu` username is created. Use it to connect to the instance.
  1. Run the `terraform init` command in the directory with the configuration file. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.
  1. Make sure the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point to them.
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

1. Install the `amqp-publish` and `amqp-declare-queue` utilities to work with {{ RMQ }} and [jq](https://stedolan.github.io/jq/) for stream processing JSON files:

   ```bash
   sudo apt update && sudo apt install amqp-tools --yes && sudo apt-get install jq --yes
   ```

1. Check if you can create a queue named `cars` in {{ RMQ }} using `amqp-declare-queue`:

   ```bash
   amqp-declare-queue \
       --url=amqp://<username>:<password>@<IP address or FQDN of the RabbitMQ server>:5672 \
       --queue=cars
   ```

1. Install the `clickhouse-client` utility to connect to the database in the {{ mch-name }} cluster.
   1. Connect the [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

      ```bash
      sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
      sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
      echo "deb https://repo.{{ ch-domain }}/deb/stable/ main/" | sudo tee \
      /etc/apt/sources.list.d/clickhouse.list
      ```

   1. Install the dependencies:

      ```bash
      sudo apt update && sudo apt install clickhouse-client --yes
      ```

   1. Download the configuration file for `clickhouse-client`:

      {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

   Check that you can use `clickhouse-client` [to connect to the {{ mch-name }} cluster over SSL](../../managed-clickhouse/operations/connect.md#connection-string).

## Set up integration with {{ RMQ }} for the {{ mch-name }} cluster {#configure-mch-for-rmq}

{% list tabs %}

- Manually

  In the [{{ mch-name }} cluster settings](../../managed-clickhouse/operations/update.md#change-clickhouse-config), specify the username and password for {{ RMQ }} authentication in **DBMS settings** → **Rabbitmq**.

- Using {{ TF }}

  Add the `clickhouse.config.rabbitmq` block with the username and password for {{ RMQ }} authentication to the cluster description:

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

## In the {{ mch-name }} cluster, create a table on the {{ RMQ }} engine {#create-rmq-table}

As an example in {{ RMQ }}, let's input JSON data from the car sensors to the `cars` queue at the `exchange` point in {{ RMQ }}:
* String ID of the device, `device_id`.
* Date and time when the data was generated, `datetime`, in `YYYY-MM-DD HH:MM:SS` format.
* Car coordinates:
  * `latitude`: Latitude.
  * `longitude`: Longitude.
  * `altitude`: Altitude above sea level.
* `speed`: Current speed.
* `battery_voltage`: Battery voltage (used for electric cars. For cars with internal combustion engine, this parameter is `null`).
* `cabin_temperature`: Temperature in the interior of the car.
* `fuel_level`: Fuel level (used for cars with internal combustion engine. For electric cars, this parameter is `null`).

This data will be transmitted as {{ RMQ }} messages. Each message will contain a JSON object as the following string:

```json
{"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

The {{ mch-name }} cluster will insert data into a table in [JSONEachRow format]({{ ch.docs }}/interfaces/formats/#jsoneachrow) which converts strings from {{ RMQ }} messages to the appropriate column values.

Create a table in the {{ mch-name }} cluster to accept data from {{ RMQ }}:
1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.
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
       rabbitmq_host_port = '<Internal IP address of VM with RabbitMQ>:5672',
       rabbitmq_routing_key_list = 'cars',
       rabbitmq_exchange_name = 'exchange',
       rabbitmq_format = 'JSONEachRow';
   ```

This table will be automatically filled with messages read from the `cars` queue at the `exchange` of {{ RMQ }}. When reading the data, {{ mch-name }} uses the [authentication credentials provided earlier](#configure-mch-for-rmq).

## Send the test data to the {{ RMQ }} queue {#send-sample-data-to-rmq}

1. Create a `sample.json` file with the following test data:

   ```json
   {
     "device_id": "iv9a94th6rztooxh5ur2",
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
     "device_id": "rhibbh3y08qmz3sdbrbu",
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
     "device_id": "iv9a94th6rztooxh5ur2",
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

1. Send the data from the `sample.json` file to the previously created `cars` queue of the `exchange` using `jq` and `amqp-publish`.

   ```bash
   jq \
   --raw-output \
   --compact-output . ./sample.json |\
   amqp-publish \
   --url=amqp://<RabbitMQ username>:<password>@<IP address or FQDN of the RabbitMQ server>:5672 \
   --routing-key=cars \
   --exchange=exchange
   ```

## Check that the test data is present in the {{ mch-name }} cluster table {#fetch-sample-data}

To access the data, use a materialized view (`MATERIALIZED VIEW`). When a materialized view is added to a table on the `{{ RMQ }}` engine, it starts collecting data in the background. This lets you continuously receive messages from {{ RMQ }} and convert them to the required format using `SELECT`.

{% note info %}

Although you can read data directly from the table, we recommend using a materialized view, because every message from the queue can be read by {{ CH }} only once.

{% endnote %}

To create a materialized view for the `db1.cars` table:

1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.
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

To get all the data from the `db1.cars_view` materialized view:
1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.
1. Run this query:

   ```sql
   SELECT * FROM db1.cars_view;
   ```

The query will return a table with data sent to {{ RMQ }}.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs %}

- Manually

  * [Delete the {{ mch-full-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
  * [Delete the virtual machine](../../compute/operations/vm-control/vm-delete.md).
  * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

- Using {{ TF }}

  To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):
  1. In the terminal window, switch to the directory containing the infrastructure plan.
  1. Delete the `clickhouse-cluster-and-vm-for-rabbitmq.tf` configuration file.
  1. Make sure the {{ TF }} configuration files are correct using this command:

     ```bash
     terraform validate
     ```

     If there are any errors in the configuration files, {{ TF }} will point to them.
  1. Confirm the resources have been updated.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     All resources described in the `clickhouse-cluster-and-vm-for-rabbitmq.tf` configuration file will be deleted.

{% endlist %}