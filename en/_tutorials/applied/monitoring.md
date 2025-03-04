# Monitoring sensor readings and event notifications


In this tutorial, you will set up monitoring and notifications about changes in the readings of the sensors connected to [{{ iot-name }}](../../iot-core/). To emulate sensors, we will use [{{ sf-full-name }}](../../functions/). If you have any connected sensors, use them.

You do not need to create or configure [VMs](../../compute/concepts/vm.md) to work with the tutorial, as all operations are based on serverless computing in {{ sf-name }}. The source code used in this tutorial is available on [GitHub](https://github.com/yandex-cloud/examples/tree/master/iot/Scenarios/ServerRoomMonitoring).

To configure monitoring of sensor readings in the server room:
1. [Get your cloud ready](#before-you-begin).
1. [Create the required {{ iot-name }} resources](#resources-step).
1. [Create a device emulator in {{ sf-name }}](#emulator-step).
1. [Set up sensor reading monitoring](#configure-monitoring).

If you no longer need the resources, [delete them](#cleanup).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The support cost includes:
* Fee for the number of {{ iot-name }} messages (see [{{ iot-full-name }} pricing](../../iot-core/pricing.md)).
* Fee for the number of {{ sf-name }} [function calls](../../functions/concepts/function.md) (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for logging user [metrics](../../monitoring/concepts/data-model.md#metric) via the [{{ monitoring-name }}](../../monitoring/index.yaml) API (see [{{ monitoring-full-name }} pricing](../../monitoring/pricing.md)).

### Create service accounts {#create-sa}

1. [Create](../../iam/operations/sa/create.md) a service account named `my-emulator-function-service-account` to send data. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-functions-invoker }}` and `iot.devices.writer` [roles](../../iam/concepts/access-control/roles.md) to it.
1. [Create](../../iam/operations/sa/create.md) a service account named `my-metrics-function-service-account` to process data. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-functions-invoker }}` and `{{ roles-editor }}` [roles](../../iam/concepts/access-control/roles.md) to it.

## Create the required {{ iot-name }} resources {#resources-step}

[Registry](../../iot-core/concepts/index.md#registry) and [device](../../iot-core/concepts/index.md#device) are the main components of the {{ iot-name }} service used for exchanging data and commands. Devices can only exchange data if created in the same registry.

### Create a registry and configure authorization with your login and password {#registry-step}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Click **{{ ui-key.yacloud.iot.button_create-registry }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the registry, e.g., `my-registry`.
  1. In the **{{ ui-key.yacloud.common.password }}** field, set a password to access the registry. To create a password, you can use the [password generator](https://passwordsgenerator.net/).

      {% include [password-save](../../_includes/iot-core/password-save.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Create a device and configure authorization using your login and password {#device-step}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Select the registry you created in the previous step.
  1. Select **{{ ui-key.yacloud.iot.label_devices }}** in the left-hand menu.
  1. Click **{{ ui-key.yacloud.iot.button_add-device }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter the device name, e.g., `my-device`.
  1. In the **{{ ui-key.yacloud.common.password }}** field, set a password to access the device. To create a password, you can use the [password generator](https://passwordsgenerator.net/).

      {% include [password-save](../../_includes/iot-core/password-save.md) %}

  1. Optionally, add an alias:
      1. Click **{{ ui-key.yacloud.iot.button_add-alias }}**.
      1. Fill in the fields: enter an alias, e.g., `events`, and the [topic](../../iot-core/concepts/topic/index.md) type after `$devices/{id}`, e.g., `events`.

          You can now use the `events` alias instead of the `$devices/{id}/events` topic.
      1. Repeat the steps for each alias you add.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Repeat the steps for each device you want to create.

{% endlist %}

## Create a device emulator in {{ sf-name }} {#emulator-step}

The emulator sends data from device sensors and handles data for monitoring and [alerts](../../monitoring/concepts/alerting/alert.md).

### Create a function that emulates transmitting data from the device {#emulation-function}

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
          * File contents: Function code from [GitHub](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/ServerRoomMonitoring/device-emulator.js).
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
              Key | Description | Value
              :--- | :--- | :---
              `HUMIDITY_SENSOR_VALUE`    | Baseline humidity sensor reading         | `80.15`
              `TEMPERATURE_SENSOR_VALUE` | Baseline temperature sensor reading       | `25.25`
              `RACK_DOOR_SENSOR_VALUE`   | State of the open rack door sensor             | `False`
              `ROOM_DOOR_SENSOR_VALUE`   | State of the open server room door sensor | `False`
              `SMOKE_SENSOR_VALUE`       | State of the smoke sensor                             | `False`
              `WATER_SENSOR_VALUE`       | State of the water sensor                             | `False`
              `IOT_CORE_DEVICE_ID`       | ID of the device you created         | See the [management console]({{ link-console-main }})<br>{{ iot-name }}
              `DEVICE_ID`                | User-defined device name                 | Specified by the user

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Test the emulation function {#test-emulation-function}

Optionally, to get detailed information from the sensors, [subscribe](../../iot-core/operations/subscribe.md#one-device) the registry to the {{ iot-name }} device [topic](../../iot-core/concepts/topic/index.md).

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Run this command:

  ```bash
  yc iot mqtt subscribe \
    --username <registry_ID> \
    --password <registry_password> \
    --topic '$devices/<device_ID>/events' \
    --qos 1
  ```

  Where:
  * `--username` and `--password`: Credentials for authentication with a username and password.
  * `--topic`: Device topic for sending data or topic alias.
  * `--qos`: Quality of service (QoS).

  The command should continue running until the test is complete.

{% endlist %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `my-device-emulator-function` function.
  1. In the left-hand menu, select **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** list, select `$latest`, which is the last created function.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.

      If the function is successful, the **{{ ui-key.yacloud.serverless-functions.item.testing.label_result-success }}** status will be displayed in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** field and the result will appear in the **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** field:

      ```json
      {
        "statusCode" : 200
      }
      ```

      If you subscribed to the {{ iot-name }} device topic, you will get the following JSON strings in the terminal:

      ```json
      {
        "DeviceId":"my-device-id",
        "TimeStamp":"2024-06-14T15:29:59Z",
        "Values":[
            {"Type":"Float","Name":"Humidity","Value":"80.84"},
            {"Type":"Float","Name":"Temperature","Value":"25.46"},
            {"Type":"Bool","Name":"Water sensor","Value":"False"},
            {"Type":"Bool","Name":"Smoke sensor","Value":"False"},
            {"Type":"Bool","Name":"Room door sensor","Value":"False"},
            {"Type":"Bool","Name":"Rack door sensor","Value":"False"}
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
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, enter a name for the trigger, e.g., `my-emulator-function-trigger`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** field, enter `* * * * ? *` (invoke once per minute).
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, enter the parameters previously set for the function:
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}**: `my-device-emulator-function`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}**: `$latest`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}**: `my-emulator-function-service-account`.
  1. Optionally, configure the **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** and **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** section parameters. They provide data security.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** allow you to repeatedly call the function if the current function call fails.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** allow you to redirect messages that consumers could not process in common [queues](../../message-queue/concepts/queue.md).

          You can configure a standard message queue as a DLQ. If you do not have a message queue yet, [create one in {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

### Create a function for processing received data {#processing-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
  1. Create a function:
      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the function, e.g., `my-monitoring-func`.
      1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a function version:
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `Python 3.12`.
      1. Disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**:
          * File name: `monitoring.py`.
          * File contents: Function code from [GitHub](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/ServerRoomMonitoring/monitoring.py).

              In this function, the data to send to the monitoring service is in the `makeAllMetrics` method. If you want to add or remove parameters, make changes to this method.

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `monitoring.msgHandler`.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
          * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `my-metrics-function-service-account`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

              Key | Description | Value
              :--- | :--- | :---
              `VERBOSE_LOG`       | Turning data logging on and off | `True`
              `METRICS_FOLDER_ID` | ID of the folder where the services are deployed and for which you will create a dashboard in {{ monitoring-name }}. | See the [management console]({{ link-console-main }})

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

### Test the data processing function {#test-processing-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `my-monitoring-func` function.
  1. In the left-hand menu, select **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** list, select `$latest`, which is the last created function.
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
            "payload": "eyJWYWx1ZXMiOiBbeyJUeXBlIjogIkZsb2F0IiwgIlZhbHVlIjogIjI1Ljc0IiwgIk5hbWUiOiAiSHVtaWRpdHkifSwgeyJUeXBlIjogIkZsb2F0IiwgIlZhbHVlIjogIjgwLjY1IiwgIk5hbWUiOiAiVGVtcGVyYXR1cmUifSwgeyJUeXBlIjogIkJvb2wiLCAiVmFsdWUiOiAiRmFsc2UiLCAiTmFtZSI6ICJXYXRlciBzZW5zb3IifSwgeyJUeXBlIjogIkJvb2wiLCAiVmFsdWUiOiAiRmFsc2UiLCAiTmFtZSI6ICJTbW9rZSBzZW5zb3IifSwgeyJUeXBlIjogIkJvb2wiLCAiVmFsdWUiOiAiRmFsc2UiLCAiTmFtZSI6ICJSb29tIGRvb3Igc2Vuc29yIn0sIHsiVHlwZSI6ICJCb29sIiwgIlZhbHVlIjogIkZhbHNlIiwgIk5hbWUiOiAiUmFjayBkb29yIHNlbnNvciJ9XSwgIlRpbWVTdGFtcCI6ICIyMDIwLTA1LTIxVDIzOjEwOjE2WiIsICJEZXZpY2VJZCI6ICIwZTNjZTFkMC0xNTA0LTQzMjUtOTcyZi01NWM5NjEzMTk4MTQifQ=="
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

### Create a trigger to call the data processing function with a signal {#signal-trigger}

The trigger will call the function when a message appears in the [device topic](../../iot-core/concepts/topic/devices-topic.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, enter a name for the trigger, e.g., `my-monitoring-func-trigger`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_iot }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_iot }}**, enter the parameters previously set for the registry and device:
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_registry }}**: `my-registry`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_device }}**: `my-device`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_mqtt-topic }}**: `$devices/<device_ID>/events`, where `<device_ID>` is the device ID in **{{ iot-name }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, enter the parameters previously set for the function:
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}**: `my-monitoring-func`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}**: `$latest`.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}**: `my-metrics-function-service-account`.
  1. Optionally, configure the **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** and **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** section parameters. They provide data security.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}** allow you to repeatedly call the function if the current function call fails.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** allow you to redirect messages that consumers could not process in common [queues](../../message-queue/concepts/queue.md).

          You can configure a standard message queue as a DLQ. If you do not have a message queue yet, [create one in {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

  All data from the device will be automatically sent to **{{ monitoring-name }}**.

{% endlist %}

## Set up sensor reading monitoring {#configure-monitoring}

Sensor readings are monitored using a dashboard in [{{ monitoring-full-name }}](../../monitoring/). The controller sends them to the server every 60 seconds via the MQTT protocol. When the sensor readings reach the set values, {{ monitoring-name }} sends notifications to users.

{% cut "Data transfer format" %}

```json
{
  "DeviceId":"e7a68b2d-464e-4222-88bd-c9e8********",
  "TimeStamp":"2020-05-21T10:16:43Z",
  "Values":[{
    "Type":"Float",
    "Name":"Humidity",
    "Value":"12.456"
  },
  {
    "Type":"Float",
    "Name":"Temperature",
    "Value":"-23.456"
  },
  {
    "Type":"Bool",
    "Name":"Water sensor",
    "Value":"false"
  },
  {
    "Type":"Bool",
    "Name":"Smoke sensor",
    "Value":"false"
  },
  {
    "Type":"Bool",
    "Name":"Room door sensor",
    "Value":"true"
  },
  {
    "Type":"Bool",
    "Name":"Rack door sensor",
    "Value":"false"}
    ]
 }
```

{% endcut %}

Set up monitoring of the sensor readings: create [charts](../../monitoring/concepts/visualization/widget.md#chart) on the [dashboard](../../monitoring/concepts/visualization/dashboard.md), [notification channel](../../monitoring/concepts/alerting/notification-channel.md), and [alert](../../monitoring/concepts/alerting/alert.md).

### Create a dashboard {#create-dashboard}

{% list tabs group=instructions %}

- {{ monitoring-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Navigate to the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** tab.
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
  1. At the top right, click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
  1. In the window that opens, enter a name for the dashboard and click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

{% endlist %}

### Create charts {#create-diagrams}

Create a chart of the temperature change:

{% list tabs group=instructions %}

- {{ monitoring-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Navigate to the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** tab.
  1. Next to the dashboard name you need, click ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud_monitoring.actions.common.edit }}**.
  1. In the bottom section, click **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
  1. Create a query for the chart:

      1. In the query editor, click ![image](../../_assets/console-icons/plus.svg).
      1. In the list of services (**service=**), select `{{ ui-key.yacloud_monitoring.services.label_custom }}`.
      1. In the list of chart types (**name=**), select `Temperature`, which is room temperature.
      1. In the **device_id=** list, select the ID of the device that you want to create a chart for.

  1. At the top right, click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

  Create other charts in a similar way:

    * `Humidity`: Room air humidity.
    * `Water sensor`: Water on the floor (yes/no).
    * `Smoke sensor`: Smoke in the room (yes/no).
    * `Room door sensor`: Room door status (door open/door closed).
    * `Rack door sensor`: Server rack door status (door open/door closed).

  The dashboard is available via a link to all {{ yandex-cloud }} users with the `{{ roles-viewer }}` role. You can customize it, zoom in or out, and enable or disable automatic data updates.

{% endlist %}

### Test the charts on the dashboard {#test-dashboard}

If you change the baselines in the environment variables of the emulating device function, you will see these changes in the charts.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Select the `my-device-emulator-function` function.
  1. Click the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** tab.
  1. Replace some original variable values with any other under **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}** in the **{{ ui-key.yacloud_components.forms.label_value }}** field at the bottom of the window.

      Key | Original value | New value
      :--- | :--- | :---
      `HUMIDITY_SENSOR_VALUE`    | `80.15` | `40`
      `TEMPERATURE_SENSOR_VALUE` | `25.25` | `15`
      `RACK_DOOR_SENSOR_VALUE`   | `False` | `True`
      `ROOM_DOOR_SENSOR_VALUE`   | `False` | `True`
      `SMOKE_SENSOR_VALUE`       | `False` | `True`
      `WATER_SENSOR_VALUE`       | `False` | `True`

  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}** and wait until the operation is complete.

{% endlist %}

{% list tabs group=instructions %}

- {{ monitoring-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}** and see how the chart metrics have changed.

{% endlist %}

### Create a notification channel {#create-channel}

Customize a list of recipients and select a notification method.

{% list tabs group=instructions %}

- {{ monitoring-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Navigate to the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}** tab.
  1. Click **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
  1. In the **{{ ui-key.yacloud_monitoring.channel.field_name }}** field, specify the channel name, e.g., `my-message-channel`.
  1. In the **{{ ui-key.yacloud_monitoring.channel.field_method }}** list, select `{{ ui-key.yacloud_monitoring.channel.title_method-email }}`.

      You can also set up notifications through text messages, push notifications, or Telegram.

  1. In the **{{ ui-key.yacloud_monitoring.channel.field_recipients }}** list, select an account.

      You can select multiple recipients for notifications. You can specify the accounts of users who have access to your [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) as recipients. Learn more about [how to add users to {{ yandex-cloud }}](../../iam/operations/users/create.md).
  1. Click **{{ ui-key.yacloud_monitoring.channel.button_create }}**.

{% endlist %}

### Create an alert {#create-alerts}

Create an alert based on the room temperature sensor readings and connect the created notification channel to it.

{{ monitoring-short-name }} will send this alert to the recipients if the temperature sensor in the server room shows a certain temperature within a certain period (`5 minutes`):
* `50 degrees`: `Warning` alert.
* `70 degrees`: `Alarm` alert (critical value).

{% list tabs group=instructions %}

- {{ monitoring-short-name }} interface {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are using to complete this tutorial.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the alert.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}**, click ![image](../../_assets/console-icons/plus.svg) and fill out the fields:
      1. In the list of services (**service=**), select `{{ ui-key.yacloud_monitoring.services.label_custom }}`.
      1. In the list of **name=** alert types, select `Temperature`.
      1. In the **device_id=** list, select the ID of the device that you want to create an alert for.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}**, set the conditions to trigger the alert:
      1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}** list, select `{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.avg }}`.
      1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** list, select `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
      1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** field, enter `50`.
      1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** field, enter `70`.
      1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window }}** list, select `5 minutes`.
  1. Under **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}**, click **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.edit-notify-methods }}**, and then **{{ ui-key.yacloud_monitoring.actions.common.add }}**.
  1. In the **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.notification-method }}** field of the window that opens, select `my-message-channel` and click **{{ ui-key.yacloud_monitoring.actions.common.add }}**.
  1. At the bottom of the window, click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

You can create and configure alerts for any metric in {{ monitoring-name }}.

Once you complete this tutorial:
* You will be able to track the sensor readings on the charts.
* If the sensor readings reach the specified values, you will receive notifications.

## How to delete the resources you created {#cleanup}

To stop paying for the resources you created:
* [Delete the registry in {{ iot-name }}](../../iot-core/operations/registry/registry-delete.md).
* [Delete the device in {{ iot-name }}](../../iot-core/operations/device/device-delete.md).
* [Delete the functions in {{ sf-name }}](../../functions/operations/function/function-delete.md).
* [Delete the triggers for function calls in {{ sf-name }}](../../functions/operations/trigger/trigger-delete.md).
* [Delete the dashboard in {{ monitoring-name }}](../../monitoring/operations/dashboard/delete-dashboard.md).
* [Delete the alert in {{ monitoring-name }}](../../monitoring/operations/alert/delete-alert.md).
* Delete the [notification channel](../../monitoring/concepts/alerting/notification-channel.md) in {{ monitoring-name }}.
