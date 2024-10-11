# Status monitoring of geographically distributed devices


In this tutorial, you will configure status monitoring for devices (e.g., vending machines) connected to [{{ iot-full-name }}](../../iot-core/index.yaml) and located at various sites throughout the city. You can monitor the status of vending machines on the [{{ datalens-full-name }}](../../datalens/index.yaml) map and charts. To emulate sensors, we will use [{{ sf-full-name }}](../../functions/index.yaml). If you have any connected sensors, use them. [{{ mpg-full-name }}](../../managed-postgresql/index.yaml) will be used to store data.

The source code used in this tutorial is available on [GitHub](https://github.com/yandex-cloud/examples/tree/master/iot/Scenarios).

To configure monitoring of sensor readings:
1. [Prepare your cloud](#configure-cloud).
1. [Create a {{ mpg-name }} cluster](#postgresql-step).
1. [Create the required {{ iot-name }} resources](#resources-step).
1. [Create a device emulator in {{ sf-name }}](#emulator-step).
1. [Create a function for processing data in {{ sf-name }}](#processing-function-step).
1. [Configure monitoring in {{ datalens-name }}](#configure-datalens).

If you no longer need the resources you created, [delete them](#cleanup).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The support cost includes:
* Fee for using a [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for the number of [messages](../../message-queue/concepts/message.md) (see [{{ iot-full-name }} pricing](../../iot-core/pricing.md)).
* Fee for the number of {{ sf-name }} [function calls](../../functions/concepts/function.md) (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for the {{ mpg-name }} [cluster](../../managed-postgresql/concepts/index.md) computing resources and storage (see [{{ mpg-full-name }} pricing](../../managed-postgresql/pricing.md)).

## Prepare your cloud {#configure-cloud}

* [Create](../../iam/operations/sa/create.md) a service account named `my-emulator-function-service-account` for data sending. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-functions-invoker }}`, `iot.devices.writer`, and `{{ roles-viewer }}` [roles](../../iam/concepts/access-control/roles.md) to it.
* Create a service account named `my-db-function-service-account` for data processing. Assign the `{{ roles-functions-invoker }}` and `{{ roles-editor }}` roles to it.
* [Create](../../vpc/operations/network-create.md) a cloud network and at least one [subnet](../../vpc/operations/subnet-create.md) in the `{{ region-id }}-a`, `{{ region-id }}-b`, or `{{ region-id }}-d` availability zone.
* [Create](../../vpc/operations/security-group-create.md) a security group named `my-pg-sg` and [add](../../vpc/operations/security-group-add-rule.md) a rule for incoming traffic:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

## Create a cluster in {{ mpg-name }} {#postgresql-step}

The example is based on the minimum values of [host](../../managed-postgresql/concepts/instance-types.md) parameters. For real tasks, it is better to choose hosts with a guaranteed 100% vCPU share.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Specify a name for the cluster, e.g., `my-pg-database`.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** list, select `PRODUCTION`.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** list, select `15`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, specify:

      * **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}**: `{{ ui-key.yacloud.mdb.forms.resource_presets_field_gen_v3 }}`.
      * **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}**: `standard`.
      * Class: `{{ s3-c2-m8 }}`.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Select `network-hdd`.
      * Specify the size of `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify:

      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `user1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: Set a password to access the database.

          {% include [password-save](../../_includes/iot-core/password-save.md) %}

      * **{{ ui-key.yacloud.mdb.forms.database_field_lc-collate }}**: `C`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_lc-ctype }}**: `C`.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**:

      1. Select the cloud network where you created the `my-pg-sg` security group.
      1. Select the `my-pg-sg` security group.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**:

      1. Leave a single host.
      1. Click ![image](../../_assets/console-icons/pencil.svg).
      1. In the window that opens, enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** and click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

  1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, enable **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** and **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

  It may take a few minutes to create a cluster.

{% endlist %}

## Create the required {{ iot-name }} resources {#resources-step}

[Registry](../../iot-core/concepts/index.md#registry) and [device](../../iot-core/concepts/index.md#device) are the main components of the {{ iot-name }} service used for exchanging data and commands. Devices can only exchange data if created in the same registry.

### Create a registry and configure authorization with your login and password {#registry-step}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Click **{{ ui-key.yacloud.iot.button_create-registry }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the registry, e.g., `my-registry`.
  1. In the **{{ ui-key.yacloud.common.password }}** field, set a password to access the registry. The password must be at least 14 characters long and contain lowercase letters, capital letters, and numbers. To create a password, you can use the [password generator](https://passwordsgenerator.net/).

      {% include [password-save](../../_includes/iot-core/password-save.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% include [iot-authorization](../_tutorials_includes/iot-authorization.md) %}

### Create devices and configure authorization with your login and password {#device-step}

Create three devices: `my-device-1`, `my-device-2`, and `my-device-3`.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Select the registry you created in the previous step.
  1. In the left-hand menu, select **{{ ui-key.yacloud.iot.label_devices }}**.
  1. Click **{{ ui-key.yacloud.iot.button_add-device }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter the device name: `my-device-1`.
  1. In the **{{ ui-key.yacloud.common.password }}** field, set a password to access the device. The password must be at least 14 characters long and contain lowercase letters, capital letters, and numbers. To create a password, you can use the [password generator](https://passwordsgenerator.net/).

      {% include [password-save](../../_includes/iot-core/password-save.md) %}

  1. Optionally, add an alias:

      1. Click **{{ ui-key.yacloud.iot.button_add-alias }}**.
      1. Fill in the fields: enter an alias, e.g., `events`, and the [topic](../../iot-core/concepts/topic/index.md) type after `$devices/{id}`, e.g., `events`.

          This will allow you to use the `events` alias instead of the `$devices/<device_ID>/events` topic.

      1. Repeat the steps for each alias you add.

  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Similarly, create `my-device-2` and `my-device-3`.

{% endlist %}

{% include [iot-authorization](../_tutorials_includes/iot-authorization.md) %}

## Create a device emulator in {{ sf-name }} {#emulator-step}

The emulator will send data from the devices to the {{ mpg-name }} cluster.

To run the emulator, create a [function](../../functions/concepts/function.md) to emulate sending data from device sensors and a [trigger](../../functions/concepts/trigger/index.md) to call this function once per minute.

### Create a function that emulates transmitting data from the device {#emulation_function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the function, e.g., `my-device-emulator-function`.
      1. Click **{{ ui-key.yacloud.common.create }}**.

  1. Create a function version:

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `Node.js 18`.
      1. Disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**:

          * File name: `device-emulator.js`.
          * File contents: Function code from [GitHub](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/DashboardForGeoDistributedDevices/device-emulator.js).

      1. Similarly, create a file named `package.json` with the following content:

          ```json
          {
            "name": "my-app",
            "version": "1.0.0",
            "dependencies": {
              "yandex-cloud": "*"
            }
          }
          ```

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `device-emulator.handler`.

      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
          * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `my-emulator-function-service-account`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

              Key | Description | Data
              :--- | :--- | :---
              `CASH_DRAWER_SENSOR_VALUE`  | Percentage of used cash box space          | `67.89`
              `TEMPERATURE_SENSOR_VALUE`  | Baseline temperature in the pickup box | `10.34`
              `POWER_SENSOR_VALUE`        | Baseline mains voltage            | `24.12`
              `SERVICE_DOOR_SENSOR_VALUE` | State of the open service door sensor | `False`
              `ITEM1_SENSOR_VALUE`        | Stock of product 1                       | `50.65`
              `ITEM2_SENSOR_VALUE`        | Stock of product 2                       | `80.97`
              `ITEM3_SENSOR_VALUE`        | Stock of product 3                       | `30.33`
              `ITEM4_SENSOR_VALUE`        | Stock of product 4                       | `15.15`
              `REGISTRY_ID`               | ID of the registry you created   | See the [management console]({{ link-console-main }})<br>in {{ iot-name }}

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Test the emulation function {#test-emulation-function}

1. (Optional) To get detailed information from the sensors, [subscribe](../../iot-core/operations/subscribe.md#one-device) your registry to the {{ iot-name }} device [topic](../../iot-core/concepts/topic/index.md).

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc iot mqtt subscribe \
        --username <registry_ID> \
        --password <registry_password> \
        --topic '$devices/<device_ID>/events/#' \
        --qos 1
      ```

      Where:
      * `--username` and `--password`: Credentials for authentication with a username and password.
      * `--topic`: Device topic for sending data or topic alias.
      * `--qos`: Quality of service (QoS).

      The command should run without interruption until you finish testing the function.

      For more information about the `yc iot mqtt subscribe` command, see the [CLI reference](../../cli/cli-ref/managed-services/iot/mqtt/subscribe.md).

    {% endlist %}

1. Test the emulation function:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. Select the `my-device-emulator-function` function.
      1. In the left-hand menu, select **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** list, select `$latest`, the most recent version of the function.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.

          If the function is successful, the **{{ ui-key.yacloud.serverless-functions.item.testing.label_result-success }}** status will be displayed in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field and the result will appear in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field:

          ```json
          {
            "statusCode" : 200
          }
          ```

          If you subscribed to the {{ iot-name }} device topic before running the test, you will get the following JSON object in the terminal:

          ```json
          {
            "DeviceId":"areulpu7dnou********",
            "TimeStamp":"2024-06-19T08:29:14Z",
            "Values":[
                {"Type":"Bool","Name":"Service door sensor","Value":"False"},
                {"Type":"Float","Name":"Power Voltage","Value":"24.91"},
                {"Type":"Float","Name":"Temperature","Value":"10.51"},
                {"Type":"Float","Name":"Cash drawer fullness","Value":"67.89"},
                {"Items":[
                    {"Type":"Float", "Id":"1","Name":"Item 1","Fullness":"50.65"},
                    {"Type":"Float", "Id":"2","Name":"Item 2","Fullness":"80.97"},
                    {"Type":"Float", "Id":"3","Name":"Item 3","Fullness":"30.33"},
                    {"Type":"Float", "Id":"4","Name":"Item 4","Fullness":"15.15"}
                ]}
                ]
            }
          ```

    {% endlist %}

### Create a trigger to call the emulation function once per minute {#minute-trigger}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, enter a name for the trigger. For example, `my-emulator-function-trigger`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** field, select `{{ ui-key.yacloud_billing.common.button_cron-1min }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, specify the function parameters:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}**: `my-device-emulator-function`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}**: `$latest`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}**: `my-emulator-function-service-account`.

  1. (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** and **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** sections, set parameters to prevent data loss in case of failure:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** allow you to repeatedly call the function if the current function call fails.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** allow you to redirect messages that the trigger sends to the function.

          You can use a [standard message queue](../../message-queue/concepts/queue.md#standard-queues) as a [dead-letter queue](../../message-queue/concepts/dlq.md). If you do not have a message queue, [create one in {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).

  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

## Create a function for processing data in {{ sf-name }} {#processing-function-step}.

Create a data processing function, test it, and review the result of data processing. Then create a trigger to call the function and see the result it returns.

### Create a function for processing received data {#processing-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
  1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the function. For example, `my-db-function`.
      1. Click **{{ ui-key.yacloud.common.create }}**.

  1. Create a function version:

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `Python 3.12`.
      1. Disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**:

          * File name: `myfunction.py`.
          * File contents: Function code from [GitHub](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/DashboardForGeoDistributedDevices/myfunction.py).

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `myfunction.msgHandler`.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
          * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `my-db-function-service-account`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

              Key | Description | Data
              :--- | :--- | :---
              `VERBOSE_LOG` | Enables and disables writing data | `True`
              `DB_HOSTNAME` | Host FQDN in {{ mpg-name }} | See the [management console]({{ link-console-main }})<br>in {{ mpg-name }}
              `DB_PORT`     | Port to connect to the cluster in {{ mpg-name }} | `6432`
              `DB_NAME`     | Cluster name in {{ mpg-name }} | `db1`
              `DB_USER`     | Username to connect to the cluster in {{ mpg-name }} | `user1`
              `DB_PASSWORD` | Password to connect to the DB in {{ mpg-name }} | Password you set in {{ mpg-name }}

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Test the data processing function {#test-processing-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `my-db-function` function.
  1. In the left-hand menu, select **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** list, select `$latest`, the most recent version of the function.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** field, paste the following data:

      ```json
      {
        "messages": [
        {
          "event_metadata": {
            "event_id": "160d239876d9714800",
            "event_type": "yandex.cloud.events.iot.IoTMessage",
            "created_at": "2020-05-08T19:16:21.267616072Z",
            "folder_id": "b112345678910"
          },
          "details": {
            "registry_id": "are1234567890",
            "device_id": "are0987654321",
            "mqtt_topic": "$devices/are0987654321/events",
            "payload": "ewogICAgICAgICAgICAiRGV2aWNlSWQiOiJhcmU1NzBrZTA1N29pcjg1bDlmciIsCiAgICAgICAgICAgICJUaW1lU3RhbXAiOiIyMDIwLTA2LTExVDExOjA3OjIwWiIsCiAgICAgICAgICAgICJWYWx1ZXMiOlsKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkJvb2wiLCJOYW1lIjoiU2VydmljZSBkb29yIHNlbnNvciIsIlZhbHVlIjoiRmFsc2UifSwKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwiTmFtZSI6IlBvd2VyIFZvbHRhZ2UiLCJWYWx1ZSI6IjI1LjA2In0sCiAgICAgICAgICAgICAgICB7IlR5cGUiOiJGbG9hdCIsIk5hbWUiOiJUZW1wZXJhdHVyZSIsIlZhbHVlIjoiMTEuMjEifSwKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwiTmFtZSI6IkNhc2ggZHJhd2VyIGZ1bGxuZXNzIiwiVmFsdWUiOiI2Ny44OSJ9LAogICAgICAgICAgICAgICAgeyJJdGVtcyI6WwogICAgICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwgIklkIjoiMSIsIk5hbWUiOiJJdGVtIDEiLCJGdWxsbmVzcyI6IjUwLjY1In0sCiAgICAgICAgICAgICAgICAgICAgeyJUeXBlIjoiRmxvYXQiLCAiSWQiOiIyIiwiTmFtZSI6Ikl0ZW0gMiIsIkZ1bGxuZXNzIjoiODAuOTcifSwKICAgICAgICAgICAgICAgICAgICB7IlR5cGUiOiJGbG9hdCIsICJJZCI6IjMiLCJOYW1lIjoiSXRlbSAzIiwiRnVsbG5lc3MiOiIzMC4zMyJ9LAogICAgICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwgIklkIjoiNCIsIk5hbWUiOiJJdGVtIDQiLCJGdWxsbmVzcyI6IjE1LjE1In0KICAgICAgICAgICAgICAgIF19CiAgICAgICAgICAgICAgICBdCiAgICAgICAgICAgIH0="
          }
        }]
      }
      ```

  1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.

      If the function is successful, you will see the **{{ ui-key.yacloud.serverless-functions.item.testing.label_result-success }}** status in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field and the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field will display this result:

      ```json
      {
        "statusCode" : 200 ,
        "headers" : {
          "Content-Type" : "text/plain"
        },
      "isBase64Encoded" : false
      }
      ```

{% endlist %}

### View the data processing result in {{ mpg-name }} {#processing-function-results}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select the `my-pg-database` cluster.
  1. In the left-hand menu, select **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
  1. In the **{{ ui-key.yacloud.clickhouse.cluster.explore.label_password }}** field, enter the password you set to access the database and click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.
  1. Select the `public` folder.
  1. View the data processing result in the `iot_events` and `iot_position` tables.

{% endlist %}

### Create a trigger to call the data processing function {#processing-function-trigger}

The trigger will invoke the function when messages appear in the [device topic](../../iot-core/concepts/topic/devices-topic.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, enter a name for the trigger. For example, `my-db-func-trigger`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**, specify the registry and device parameters:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_registry }}**: `my-registry`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_device }}**: `Any device`
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}**: `$devices/#`.

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, specify the function parameters:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}**: `my-db-function`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}**: `$latest`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}**: `my-db-function-service-account`.

  1. (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** and **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** sections, set parameters to prevent data loss in case of failure:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** allow you to repeatedly call the function if the current function call fails.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** allow you to redirect messages that the trigger sends to the function.

          You can use a standard message queue as a dead-letter queue. If you do not have a message queue, [create one in {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).

  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

### View the trigger result in {{ mpg-name }} {#processing-function-trigger-results}

Shortly after creating the trigger, you can check how it works.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select the `my-pg-database` cluster.
  1. In the left-hand menu, select **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
  1. In the **{{ ui-key.yacloud.clickhouse.cluster.explore.label_password }}** field, specify the password you set to access the database and click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.
  1. Select the `public` folder.
  1. View the changes in the `iot_events` table.

{% endlist %}

## Configure monitoring in {{ datalens-name }} {#configure-datalens}

To monitor the state of your devices, configure a [connection](../../datalens/concepts/connection.md), create a [dataset](../../datalens/dataset/index.md), [charts](../../datalens/concepts/chart/index.md), and a [dashboard](../../datalens/concepts/dashboard.md).

### Set up a connection to {{ mpg-name }} {#connect-mpg}

{% list tabs group=instructions %}

- {{ datalens-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
  1. Click **Create connection**.
  1. Select the **{{ PG }}** connector.

      When connecting to an external data source (which is not a {{ yandex-cloud }} resource), grant access to the source [for the {{ datalens-name }} IP address ranges](../../datalens/concepts/connection.md#changing-connection-ranges).

  1. Select a cloud and folder.
  1. Select the `my-pg-database` cluster and a host.
  1. In the **Port** field, specify `6432`.
  1. Select `db1` as the database and `user1` as the user.
  1. In the **Password** field, specify the password you set to access the database in {{ mpg-name }}.
  1. Click **Create connection**.
  1. In the window that opens, specify the `MyPGConnection` name for the connection and click **Create**.

{% endlist %}

### Create a dataset {#create-dataset}

{% list tabs group=instructions %}

- {{ datalens-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
  1. Click **Create dataset**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Add**.
  1. Select a `MyPGConnection` connection.
  1. In the left-hand menu, select the `public.iot_events` and `public.iot_position` tables and drag them to the right.
  1. Click **Save**.
  1. In the window that opens, specify `My-pg-dataset` and click **Create**.

      The dataset will appear in the list.

{% endlist %}

### Create a chart for temperature and mains voltage {#create-chart}

{% list tabs group=instructions %}

- {{ datalens-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
  1. Click **Create chart**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and select the `My-pg-dataset` you created previously.
  1. Select **Line chart** as your [chart type](../../datalens/visualization-ref/line-chart.md).
  1. From the **Dimensions** section in the left-hand menu, drag the dimensions to the **Line chart** section as follows:
      * `event_datetime`, to the **X** section.

          A timeline will appear in the lower part of the chart on the X-axis.
      * `temperature` and `power_voltage`, to the **Y** section.

      The temperature and mains voltage values will appear on the Y-axis of the chart.
  1. Click **Save**.
  1. In the window that opens, specify the chart name or use the generated `My-pg-dataset — Line chart` name and click **Save**.

{% endlist %}

### Create a chart with a map{#create-chart-map}

{% list tabs group=instructions %}

- {{ datalens-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
  1. Create a field to define device coordinates:
      1. In the left-hand menu, select **Datasets**.
      1. Select `My-pg-dataset` from the list of datasets.
      1. Go to the **Fields** tab.
      1. In the right part of the window, click ![image](../../_assets/console-icons/plus.svg) **Add field**.
      1. In the window that opens, in the **Field name** field, enter `Position`.
      1. In the **Formula** field, insert `GEOPOINT([latitude],[longitude])`.
      1. Click **Create**.
      1. Click **Save**.
  1. Create a chart:
      1. At the top right, click **Create chart**.
      1. Select `Map` as the [chart type](../../datalens/visualization-ref/map-chart.md).
      1. From the **Dimensions** section in the left-hand menu, drag the dimensions to the **Map** section as follows:
          * `Position`, to the **Geopoints** section.
          * `item1_fullness`, `item2_fullness`, `item3_fullness`, `item4_fullness`, and `cash_drawer`, to the **Tooltips** section.

              On the right side of the window, you will see a scalable map with vending machines displayed as dots on the map and tooltips displayed as legend lines when you hover over the dots.
      1. Click **Save**.
      1. In the window that opens, specify the chart name or use the generated `My-pg-dataset — Map` name and click **Save**.

{% endlist %}

### Create a dashboard {#create-dashboard}

{% list tabs group=instructions %}

- {{ datalens-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_datalens }}**.
  1. Click **Create dashboard**.
  1. Add the `My-pg-dataset — Map` and `My-pg-dataset — Line chart` charts, which you created at the previous steps, to the dashboard:
      1. In the bottom panel, click **Chart**.
      1. In the **Chart** field of the window that opens, click **Select** and select `My-pg-dataset — Map`.
      1. Click **Add**.
      1. Repeat the steps to add `My-pg-dataset — Line chart`.
  1. Configure the selector:
      1. In the bottom panel, click **Selector**.
      1. In the **Dataset** field, click **Select** and select `My-pg-dataset`.
      1. In the **Field** list, select `device_id`.
      1. In the **Default value** list, select the ID of any one device you created in {{ iot-name }}.
      1. In the **Header** field, enter `Device`.
      1. Click **Add**.
  1. Configure links:
      1. At the top right, click **Links**.
      1. In the window that opens, select the `My-pg-dataset — Map` chart from the list.
      1. In the **In.link** drop-down list, select `Ignore`.

          Maps do not support the **Links** parameter.

      1. In the list, select `My-pg-dataset — Line chart`.
      1. In the **In.link** drop-down list, select `In.link`.
      1. Click **Save**.

  1. Click **Save**.
  1. In the window that opens, enter a name for the dashboard: `MyDash`.
  1. Click **Create**.

{% endlist %}

After completing the tutorial, you will be able to monitor sensor readings on a map and chart.

## How to delete the resources you created {#cleanup}

To stop paying for the resources you created:

1. [Delete](../../iot-core/operations/device/device-delete.md) the devices in {{ iot-name }}.
1. [Delete](../../iot-core/operations/registry/registry-delete.md) the registry in {{ iot-name }}.
1. [Delete](../../functions/operations/trigger/trigger-delete.md) the triggers for function calls in {{ sf-name }}.
1. [Delete](../../functions/operations/function/function-delete.md) the functions in {{ sf-name }}.
1. [Delete](../../managed-postgresql/operations/cluster-delete.md) the cluster in {{ mpg-name }}.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.