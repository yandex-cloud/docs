In this tutorial, you will set up storing information received from a device in the {{ mpg-name }} cluster database. To connect your device to {{ iot-full-name }}, you will need an MQTT broker. All steps are performed in the [management console]({{ link-console-main }}).

To start writing information from your device to the database:

1. [Prepare your cloud](#before-you-begin).
1. [Create a service account](#create-sa).
1. [Create the required resources {{ iot-full-name }}](#resources).
   1. [Create a registry](#registry).
   1. [Create a device](#device).
1. [Connect your device to the MQTT broker](#connect).
1. [Prepare the database](#db).
   1. [Create a cluster](#cluster).
   1. [Connect to the cluster](#connect-to-cluster).
   1. [Create a table](#table).
1. [Create a function for processing data](#func).
1. [Create a trigger for {{ iot-full-name }}](#trigger).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of this infrastructure includes:

* Fee for a {{ PG }} DB cluster (see [ pricing {{ mpg-full-name }}](../../managed-postgresql/pricing.md)).
* Fee for messaging between {{ iot-name }} resources (see [{{ iot-full-name }} pricing](../../iot-core/pricing.md)).
* Fee for function calls and computing resources allocated to execute the functions (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).

## Create a service account {#create-sa}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. Click **Create service account**.
   1. Enter the service account name: `my-db-function-service-account`.
   1. Click ![](../../_assets/plus-sign.svg) **Add role** and select the `{{ roles-functions-ivoker }}` and `{{ roles-editor }}` [roles](../../iam/concepts/access-control/roles.md).
   1. Click **Create**.

{% endlist %}

## Create the required {{ iot-full-name }} resources {#resources}

{% note info %}

This tutorial assumes [username and password-based authorization](../../iot-core/concepts/authorization.md#log-pass), so you do not need to add any certificate to your registry and device. In your projects, you can use [authorization using certificates](../../iot-core/concepts/authorization.md#certs).

{% endnote %}

### Create a registry {#registry}

{% list tabs %}

- Management console

    1. In [the management console]({{ link-console-main }}), select the folder where you want to create a registry.
    1. In the list of services, select **{{ iot-name }}**.
    1. Click **Create registry**.
    1. In the **Name field**, enter `my-registry`.
    1. Enter the password.

        * Minimum password length is 14 characters.
        * The password must contain uppercase and lowercase letters and numbers.

        {% note warning %}

        Save your password as you won't be able to read it from {{ iot-full-name }}.

        {% endnote %}

    1. Click **Create**.

{% endlist %}

### Create a device {#device}

{% list tabs %}

- Management console

   Once a registry is created, you will see its settings.

   1. Go to the **Devices **tab.
   1. Click **Add device**.
   1. In the **Name** field, enter `my-device`.
   1. Enter the password.

      * Minimum password length is 14 characters.
      * The password must contain uppercase and lowercase letters and numbers.

      {% note warning %}

      Save your password as you won't be able to read it from {{ iot-full-name }}.

      {% endnote %}

   1. Click **Create**.

{% endlist %}

## Connect your device to the MQTT broker {#connect}

{% include [connect-mqtt-broker](./connect-mqtt-broker.md) %}

## Prepare the database {#db}

### Create a cluster {#cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
   1. In the list of services, select **{{ mpg-name }}**.
   1. Click **Create cluster**.
   1. In the **Cluster name** field, enter `my-pg-database`.
   1. In the **Environment** field, select `PRODUCTION`.
   1. In the **Version** field, select `12`.
   1. Under **Host class**:
      * Specify the `Intel Cascade Lake` platform.
      * Select the `burstable` type.
      * Specify the `b2.medium` class.

      {% note warning %}

      The `b2.medium` class was only selected as part of testing. In real projects, it isn't recommended to use hosts with a guaranteed vCPU share under 100%.

      {% endnote %}

   1. Under **Storage size**:

      * Choose `network-ssd`.
      * Set the size to 10 GB.

      {% note info %}

      The type and size of the disk should be selected according to the projects to be implemented. The above values are used for testing.

      {% endnote %}

   1. Under **Database**, specify the DB attributes:

      * Database name. The DB name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      * The name of the user who is the DB owner. The username may only contain Latin letters, numbers, and underscores.
      * User password. From 8 to 128 characters.

      For the database created with the cluster, the character set and collate settings are specified as `LC_CTYPE=C` and `LC_COLLATE=C`. You can't change these settings after the database is created, but you can [create a new database](../../managed-postgresql/operations/databases.md#add-db) with the right settings.

   1. Under **Hosts**, click ![image](../../_assets/edit.svg) and enable **Public access**.
   1. Under **Additional settings**, enable **Access from the management console**.
   1. Click **Create cluster**.

{% endlist %}

For more information about creating a cluster, see [How to create a PostgreSQL cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster).

Afterwards, the cluster settings can be [updated](../../managed-postgresql/operations/update.md).

### Connect to the cluster {#connect-to-cluster}

After creating the cluster, you'll be automatically redirected to the **Clusters** page.

Wait for the cluster status to change to `Alive`.

{% list tabs %}

- Management console

   1. Select the `my-pg-database` cluster.
   1. Go to the **SQL** tab.
   1. In the **DB username** field, specify the name of the user who owns the DB created in the previous step.
   1. In the **Password** field, enter the password specified when creating the cluster.
   1. Click **Connect**.

{% endlist %}

### Create a table {#table}

As a sample data source, the scenario uses an air sensor that measures the following parameters:

* Humidity.
* The level of carbon dioxide (CO<sub>2</sub>).
* Pressure.
* Temperature.

The sensor outputs the result in JSON format, e.g.:

```json
{
"DeviceId":"0e3ce1d0-1504-4325-972f-55c961319814",
"TimeStamp":"2020-05-21T22:53:16Z",
"Values":[
    {"Type":"Float","Name":"Humidity","Value":"25.281837"},
    {"Type":"Float","Name":"CarbonDioxide","Value":"67.96608"},
    {"Type":"Float","Name":"Pressure","Value":"110.7021"},
    {"Type":"Float","Name":"Temperature","Value":"127.708824"}
    ]
}
```

Write the received information to a DB table using a function.

Once you [connect to the cluster](#connect-to-cluster), create a table. To do this:

{% list tabs %}

- Management console

   1. In the edit window, enter the following query:

      {% note warning %}

      The query below is given as an example. If your device sends different information, change the columns in the table you're creating.

      {% endnote %}

      ```sql
      CREATE TABLE iot_events (
          event_id varchar(24) not null,
          device_id varchar(50) not null,
          event_datetime timestamptz not null,
          humidity float8 null,
          carbon_dioxide float8 null,
          pressure float8 null,
          temperature float8 null
      )
      ```

   1. Click **Run**.

   Wait until a message that the query is executed appears.

{% endlist %}

## Create a function for processing data {#func}

The function will receive messages from the MQTT broker and write data to the table created in the previous step.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
   1. In the list of services, select **{{ sf-name }}**.
   1. Click **Create function**.
   1. Enter a function name.
   1. Click **Create**.

{% endlist %}

### Create a function version {#func-version}

After creating the function, you'll be automatically redirected to the **Editor** page.

{% list tabs %}

- Management console

   1. Under **Code**:

      * In the **Runtime environment** field, choose `python37`.
      * In the **Method** field, leave the default value: **Code editor**.

   1. Create a file named `myfunction.py`.
   1. In the file editing area, insert the function code from [Github](https://github.com/yandex-cloud/examples/blob/master/iot/Samples/PostgreSQL/myfunction.py).

      {% note info %}

      The query used to write data to the DB is generated in the `makeInsertStatement` method. If you need to remove or add parameters, make changes to this method.

      {% endnote %}

   1. In the **Entry point** field, specify `myfunction.msgHandler`.
   1. Specify the following version parameters:

      * **Timeout, s**: 10.
      * **RAM**: 128 MB.

   1. In the **Service account** field, select `my-db-function-service-account`.

   1. Add environment variables:

      * `VERBOSE_LOG`: Parameter that displays detailed information about the function execution. Set it to `True`.
      * `DB_HOSTNAME`: Name of the {{ PG }} DB host to connect to.
      * `DB_PORT`: Port to connect to.
      * `DB_NAME`: Name of the database to connect to.
      * `DB_USER`: Username for the connection.
      * `DB_PASSWORD`: Password that you entered when [creating your cluster](#cluster).

      To define the values of connection parameters:

      1. In the [management console]({{ link-console-main }}), select the folder where you created the cluster.
      1. In the list of services, select **{{ mpg-name }}**.
      1. Select the `my-pg-database` cluster.
      1. In the line with the appropriate DB, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Connect**.
      1. On the **Shell** tab, find a sample connection string.
      1. Move the values of the `host`, `port`, `dbname`, and `user` variables to the appropriate **Value** field of the function environment variables.

   1. Click **Create version**.

{% endlist %}

## Create a trigger for {{ iot-full-name }} {#trigger}

The trigger will accept copies of messages from the device topic and pass them to the function for processing.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a registry.
   1. In the list of services, select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.
   1. Click **Create trigger**.
   1. Under **Basic parameters**:

      * In the **Name** field, enter a name for the trigger.
      * In the **Description** field, enter a description for the trigger.
      * In the **Type** field, select **{{ iot-name }} (device)**.

   1. Under **message settings{{ iot-full-name }}**:

      * In the **Registry** field, enter `my-registry`.
      * In the **Device** field, enter `my-device`.
      * In the **Topic** field, specify the topic that the device sends data to:

         ```
         $devices/<device id>/events
         ```

         Where `<device id>` is the ID of your device.

         The trigger works when new data appears in the specified topic.

   1. Under **Function settings**:

      * Select the data processing function that you created earlier.
      * In the **Tag version** field, specify `$latest`.
      * In the **Service account** field, specify `my-db-function-service-account`.

   1. Leave the other fields empty or fill them in at your discretion.
   1. Click **Create trigger**.

{% endlist %}

## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the created resources:

1. [Delete](../../iot-core/operations/device/device-delete.md) the device.
1. [Delete](../../iot-core/operations/registry/registry-delete.md) the registry.
1. [Delete](../../managed-postgresql/operations/cluster-delete.md) the {{ PG }} cluster.
1. [Delete](../../functions/operations/trigger/trigger-delete.md) the trigger.
1. [Delete](../../functions/operations/function/function-delete.md) the function.
