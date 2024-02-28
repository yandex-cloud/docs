In this tutorial, you will set up storing information received from a device in the {{ mpg-name }} cluster database. To connect your device to {{ iot-full-name }}, you will need an MQTT broker. All steps are performed in the [management console]({{ link-console-main }}).

To start writing information from your device to the database:

1. [Prepare your cloud](#before-you-begin).
1. [Create a service account](#create-sa).
1. [Create the required {{ iot-full-name }} resources](#resources).
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

The infrastructure support costs include:

* Fee for a {{ PG }} DB cluster (see [{{ mpg-full-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for messaging between {{ iot-name }} resources (see [{{ iot-full-name }} pricing](../../iot-core/pricing.md)).
* Fee for function calls and computing resources allocated to execute the functions (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter the service account name: `my-db-function-service-account`.
   1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `{{ roles-functions-invoker }}` and `{{ roles-editor }}` [roles](../../iam/concepts/access-control/roles.md).
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Create the required {{ iot-full-name }} resources {#resources}

{% note info %}

This tutorial assumes [username and password-based authorization](../../iot-core/concepts/authorization.md#log-pass), so you do not need to add any certificate to your registry and device. In your projects, you can use [authorization using certificates](../../iot-core/concepts/authorization.md#certs).

{% endnote %}

### Create a registry {#registry}

{% list tabs group=instructions %}

- Management console {#console}

    1. In [the management console]({{ link-console-main }}), select the folder where you want to create a registry.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
    1. Click **{{ ui-key.yacloud.iot.button_create-registry }}**.
    1. In the **{{ ui-key.yacloud.common.name }}** field, enter `my-registry`.
    1. Enter the password.

        * The minimum password length is 14 characters.
        * The password must contain uppercase and lowercase letters and numbers.

        {% note warning %}

        Save your password as you will not be able to read it from {{ iot-full-name }}.

        {% endnote %}

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create a device {#device}

{% list tabs group=instructions %}

- Management console {#console}

   Once a registry is created, you will see its settings.

   1. Go to the **{{ ui-key.yacloud.iot.label_devices }}** tab.
   1. Click **{{ ui-key.yacloud.iot.button_add-device }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter `my-device`.
   1. Enter the password.

      * The minimum password length is 14 characters.
      * The password must contain uppercase and lowercase letters and numbers.

      {% note warning %}

      Save your password as you will not be able to read it from {{ iot-full-name }}.

      {% endnote %}

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Connect your device to the MQTT broker {#connect}

{% include [connect-mqtt-broker](./connect-mqtt-broker.md) %}

## Prepare the database {#db}

### Create a cluster {#cluster}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter `my-pg-database`.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** field, select `PRODUCTION`.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select `12`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**:
      * Specify the `{{ ui-key.yacloud.component.compute.resources.label_platform-standard-v2 }}` platform.
      * Select the `burstable` type.
      * Specify the `b2.medium` class.

      {% note warning %}

      The `b2.medium` class was only selected as part of testing. In real projects, we do not recommend using hosts with a guaranteed vCPU share under 100%.

      {% endnote %}

   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Select `network-ssd`.
      * Set the size to 10 GB.

      {% note info %}

      The type and size of the disk should be selected according to the projects to be implemented. The above values are used for testing.

      {% endnote %}

   1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify the DB attributes:

      * Database name. It must be unique within the folder and contain only Latin letters, numbers, and underscores.
      * DB owner username. It may only contain Latin letters, numbers, and underscores.
      * User password. It must be from 8 to 128 characters long.

      For the database created with the cluster, the character set and collate settings are specified as `LC_CTYPE=C` and `LC_COLLATE=C`. You cannot change these settings after the database is created, but you can [create a new database](../../managed-postgresql/operations/databases.md#add-db) with the right settings.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, click ![image](../../_assets/console-icons/pencil.svg) and enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable the **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** option.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

For more information about creating a cluster, see [How to create a PostgreSQL cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster).

Afterwards, the cluster settings can be [updated](../../managed-postgresql/operations/update.md).

### Connect to the cluster {#connect-to-cluster}

After creating the cluster, you will be automatically redirected to the **{{ ui-key.yacloud.mdb.clusters.label_title }}** page.

Wait for the cluster status to change to `Alive`.

{% list tabs group=instructions %}

- Management console {#console}

   1. Select the `my-pg-database` cluster.
   1. Go to the **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}** tab.
   1. In the **{{ ui-key.yacloud.clickhouse.cluster.explore.label_username }}** field, specify the name of the user who owns the DB created in the previous step.
   1. In the **{{ ui-key.yacloud.clickhouse.cluster.explore.label_password }}** field, enter the password specified when creating the cluster.
   1. Click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.

{% endlist %}

### Create a table {#table}

As a sample data source, the scenario uses an air sensor that measures the following parameters:

* Humidity
* Carbon dioxide (CO<sub>2</sub>) level
* Pressure
* Temperature

The sensor outputs the result in JSON format. Here is an example:

```json
{
"DeviceId":"0e3ce1d0-1504-4325-972f-55c9********",
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

{% list tabs group=instructions %}

- Management console {#console}

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

   1. Click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_execute }}**.

   Wait until a message that the query is executed appears.

{% endlist %}

## Create a function for processing data {#func}

The function will receive messages from the MQTT broker and write data to the table created in the previous step.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
   1. Enter a function name.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create a function version {#func-version}

After creating the function, you will be automatically redirected to the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** page.

{% list tabs group=instructions %}

- Management console {#console}

   1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}** field, choose `python37`.
      * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, keep the default value, **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}**.

   1. Create a file named `myfunction.py`.
   1. In the file editing area, insert the function code from [Github](https://github.com/yandex-cloud/examples/blob/master/iot/Samples/PostgreSQL/myfunction.py).

      {% note info %}

      The query used to write data to the DB is generated in the `makeInsertStatement` method. If you need to remove or add parameters, make changes to this method.

      {% endnote %}

   1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `myfunction.msgHandler`.
   1. Specify the following version parameters:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`

   1. In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, select `my-db-function-service-account`.

   1. Add environment variables:

      * `VERBOSE_LOG`: Parameter that displays detailed information about the function execution. Set it to `True`.
      * `DB_HOSTNAME`: Name of the {{ PG }} DB host to connect to.
      * `DB_PORT`: Port to connect to.
      * `DB_NAME`: Name of the database to connect to.
      * `DB_USER`: Username for the connection.
      * `DB_PASSWORD`: Password that you entered when [creating your cluster](#cluster).

      To define the values of connection parameters:

      1. In the [management console]({{ link-console-main }}), select the folder where you created the cluster.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
      1. Select the `my-pg-database` cluster.
      1. In the line with the appropriate DB, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
      1. On the **PowerShell** tab, find a sample connection string.
      1. Move the values of the `host`, `port`, `dbname`, and `user` variables to the appropriate **{{ ui-key.yacloud.common.value }}** field of the function environment variables.

   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Create a trigger for {{ iot-full-name }} {#trigger}

The trigger will accept copies of messages from the device topic and pass them to the function for processing.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a registry.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, enter a name for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_description }}** field, enter a description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_registry }}** field, enter `my-registry`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_device }}** field, enter `my-device`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}** field, specify the topic that the device sends data to:

         ```
         $devices/<device_ID>/events
         ```

         Where `<device_ID>` is the ID of your device.

         The trigger will fire as soon as new data appears in the specified topic.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:

      * Select the data processing function that you created earlier.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** field, specify `$latest`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** field, specify `my-db-function-service-account`.

   1. Leave the other fields empty or fill them in at your discretion.
   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the resources you created:

1. [Delete](../../iot-core/operations/device/device-delete.md) a device.
1. [Delete](../../iot-core/operations/registry/registry-delete.md) a registry.
1. [Delete](../../managed-postgresql/operations/cluster-delete.md) a {{ PG }} cluster.
1. [Delete](../../functions/operations/trigger/trigger-delete.md) a trigger.
1. [Delete](../../functions/operations/function/function-delete.md) a function.