# Monitoring sensor readings and event notifications

In this scenario, you'll set up monitoring and notifications about changes in sensor readings connected to {{ iot-full-name }}. Sensors are emulated using the {{ sf-full-name }} service. If your sensors are connected, use them.

You don't need to create or configure any VMs for this use case: all operations are based on serverless computing in {{ sf-name }}. The source code used in this scenario is available on [GitHub](https://github.com/yandex-cloud/examples/tree/master/iot/Scenarios/ServerRoomMonitoring).

To configure monitoring of sensor readings in the server room:
1. [Prepare your cloud](#before-you-begin)
1. [Required paid resources](#paid-resources)
1. [Create the necessary resources {{ iot-full-name }}](#resources-step)
   1. [Create a registry](#registry-step)
   1. [Create a device](#device-step)
1. [Create a device emulator based on {{ sf-full-name }}](#emulator-step)
   1. [Create a function that emulates transmitting data from the device](#emulation-function)
   1. [Test the data transmission emulation function](#test-emulation-function)
   1. [Create a trigger to call the emulation function once per minute](#minute-trigger)
   1. [Create a function for processing data received](#processing-function)
   1. [Test the data processing function](#test-processing-function)
   1. [Create a trigger to call the data processing function with a signal](#signal-trigger)
1. [Set up sensor reading monitoring](#configure-monitoring)
   1. [Create charts](#create-widgets)
   1. [Create a dashboard](#create-dashboard)
   1. [Test the charts on the dashboard](#test-dashboard)
   1. [Create alerts](#create-alerts)
1. [Delete the created cloud resources](#cleanup)

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

If you don't have the {{ yandex-cloud }} command line interface yet, [install and initialize it](../../cli/quickstart.md#install).


### Required paid resources {#paid-resources}

The cost includes:
* Fee for the number of messages {{ iot-full-name }} (see [pricing](../../iot-core/pricing.md)).
* Fee for the number of function calls {{ sf-full-name }} (see [pricing](../../functions/pricing.md)).
* Fee for logging user metrics via the service API {{ monitoring-full-name }} .


## Create the necessary {{ iot-short-name }} resources {#resources-step}

[Registry](../../iot-core/concepts/index.md#registry) and [device](../../iot-core/concepts/index.md#device) are the main components of the service {{ iot-short-name }} used for exchanging data and commands. Devices can only exchange data if they were created in the same registry.

### Create a registry and configure authorization using your login and password {#registry-step}

To create a registry:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ iot-short-name }}**.
1. Click **Create registry**.
1. In the **Name** field, enter a name for the registry. For example, `my-registry`.
1. In the **Password** field, set the password to access the registry.

   To create a password, you can use the [password generator](https://passwordsgenerator.net/).
   Don't forget to save your password, you'll need it.
1. (optional) In the **Description** field, add additional information about the registry.
1. Click **Create**.

You can also complete authorization using certificates. Learn more [about authorization in {{ iot-short-name }}](../../iot-core/concepts/authorization.md).

### Create a device and configure authorization using your login and password {#device-step}

To create a device:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ iot-short-name }}**.
1. Select the registry you created in the previous step.
1. In the left part of the window, select **Devices**.
1. Click **Add device**.
1. In the **Name** field, enter the device name. For example, `my-device`.
1. In the **Password** field, set the password to access the device.

   To create a password, you can use the [password generator](https://passwordsgenerator.net/).
   Don't forget to save your password, you'll need it.
1. (optional) In the **Description** field, add additional information about the device.
1. (optional) Add an alias:
   1. Click **Add alias**.
   1. Fill in the fields: enter an alias (for example, `events`) and the topic type after `$devices/<deviceID>` (for example, `events`).

      You can use the `events` alias instead of the `$devices/<deviceID>/events` topic.
   1. Repeat the steps for each alias you add.
1. Click **Create**.
1. Repeat the steps for each device you want to create.

You can also complete authorization using certificates. Learn more [about authorization in {{ iot-short-name }}](../../iot-core/concepts/authorization.md).

## Create a device emulator in {{ sf-name }} {#emulator-step}

The emulator sends data from device sensors and handles data for monitoring and alerts.

You'll need:
* Create and test a [function](../../functions/concepts/function.md) that emulates transmitting data from each device sensor.
* Create a [trigger](../../functions/concepts/trigger/index.md) to call the emulation function once per minute.
* Create and test a function for processing received data.
* Create a trigger to call the data processing function by a signal.

### Create a function that emulates transmitting data from the device {#emulation-function}

To create a function:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. In the left part of the window, select **Functions**.
1. Click **Create function**.
1. In the **Name** field, enter the name of the function. For example, `my-device-emulator-function`.
1. (optional) In the **Description** field, add additional information about the function.
1. Click **Create**.
1. In the **Editor** window that opens, select `nodejs12` from the **Runtime environment** list.
1. Select **Method**: **Code editor**.
1. In the left part of the **Code editor** window, click **Create file**.
1. In the **New file** window that opens, enter the name `device-emulator.js`.
1. Click **Create**.
1. Select the created file in the left part of the **Code editor** window.
1. In the right part of the **Code editor** window, insert the function code from [GitHub](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/ServerRoomMonitoring/device-emulator.js).
1. In the **Entry point** field, enter `device-emulator.handler`.
1. In the **Timeout, sec** field, enter `10`.
1. In the **Memory** field, leave the value `128 MB`.
1. Create a service account that the function will use to send data to {{ iot-short-name }}:
   1. Click **Create an account**.
   1. In the **Create service account** window that opens, enter an account name in the **Name** field. For example, `my-emulator-function-service-account`.
   1. Add the `serverless.functions.invoker` and `iot.devices.writer` roles for invoking the function and writing data to resources:
      1. Click the ![image](../../_assets/plus-sign.svg).
      1. Select a role from the list.
      1. Click **Create**.
1. Set **Environment variables** for each sensor in the server room:
   1. Click **Add environment variable**.
   1. Fill in the **Key** and **Value** fields for the environment variables:

      | Key | Description | Value |
      :----- | :----- | :-----
      | `HUMIDITY_SENSOR_VALUE` | Baseline humidity sensor reading. | `80.15` |
      | `TEMPERATURE_SENSOR_VALUE` | Baseline temperature sensor reading. | `25.25` |
      | `RACK_DOOR_SENSOR_VALUE` | State of the open rack door sensor. | `False` |
      | `ROOM_DOOR_SENSOR_VALUE` | State of the open server room door sensor. | `False` |
      | `SMOKE_SENSOR_VALUE` | State of the smoke sensor. | `False` |
      | `WATER_SENSOR_VALUE` | State of the water sensor. | `False` |
      | `IOT_CORE_DEVICE_ID` | ID of the device you created. | See in the management console for <br>**{{ iot-short-name }}**. |
      | `DEVICE_ID` | User-defined device name. | Specified by the user. |
1. In the upper-right part of the window, click **Create version**.

### Test the emulation function {#test-emulation-function}

To test the function:
1. (optional) To get detailed information from the sensors, subscribe the registry to the {{ iot-full-name }} device topic, where `$devices/<deviceID>/events` is the device topic, `<deviceID>` is the device ID in the service:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      Run the command:

      ```
      yc iot mqtt subscribe \
            --username <registry ID> \
            --password <registry password> \
            --topic '$devices/<device ID>/events' \
            --qos 1
      ```

      Where:

      * `--username` and` --password`: Parameters for authorization using a username and password.
      * `--topic`: Device topic for sending data.
      * `--message`: Message text.
      * `--qos`: Quality of service (QoS).

   {% endlist %}

   Learn more about [subscription to device topics in {{ iot-full-name }}](../../iot-core/operations/subscribe#one-device).
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. In the left part of the window, select **Testing**.
1. In the **Version tag** field, select `$latest` (most recent function).
1. Click **Run test**.

If the function is successful, the **Function status** field shows **Done** and the **Function output** field shows the following:

```
{
"statusCode" : 200
}
```

If you subscribe to the {{ iot-short-name }} device topic, you get the following JSON:

```json
{
"":"0e3ce1d0-1504-4325-972f-55c961319814",
"TimeStamp":"2020-05-21T22:38:12Z",
"Values":[
    {"Type":"Float","Name":"Humidity","Value":"25.33"},
    {"Type":"Float","Name":"Temperature","Value":"80.90"},
    {"Type":"Bool","Name":"Water sensor","Value":"False"},
    {"Type":"Bool","Name":"Smoke sensor","Value":"False"},
    {"Type":"Bool","Name":"Room door sensor","Value":"False"},
    {"Type":"Bool","Name":"Rack door sensor","Value":"False"}
    ]
}
```

Learn more about [MQTT topics in {{ iot-short-name }}](../../iot-core/concepts/topic/index.md).

### Create a trigger that invokes the function once per minute {#minute-trigger}

To create a trigger:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. Select **Triggers**.
1. Click **Create trigger**.
1. In the **Name** field, enter a name for the trigger. For example, `my-emulator-function-trigger`.
1. (optional) In the **Description** field, add additional information about the trigger.
1. Select **Type**: **Timer**.
1. In the **Cron expression** field, enter `* * * * ? *` (invoke once per minute).
1. Under **Function settings**, enter the parameters previously set for the function:
   * **Function**: `my-device-emulator-function`.
   * **Function version tag**: `$latest`.
   * **Service account**: `my-emulator-function-service-account`.
1. (optional) Set parameters under **Repeat request settings** and **Dead Letter Queue settings**. They provide data security.
   * **Repeat request settings** are useful if you want to recall the function when the current function request fails.
   * **Dead Letter Queue settings** are necessary to forward messages that consumers couldn't process in standard queues.
      You can configure a standard message queue as a DLQ. If you haven't created a message queue yet, [create one in {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).
1. Click **Create trigger**.

### Create a function for processing data received {#processing-function}

To create a function:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. In the left part of the window, select **Functions**.
1. Click **Create function**.
1. In the **Name** field, enter the name of the function. For example, `my-monitoring-func`.
1. (optional) In the **Description** field, add additional information about the function.
1. Click **Create**.
1. In the **Editor** window that opens, select `python37` in the **Runtime environment** list.
1. Select **Method**: go to the **Code editor** tab.
1. In the left part of the **Code editor** window, click **Create file**.
1. In the **New file** window that opens, enter the name `monitoring.py`.
1. Click **Create**.
1. In the left part of the **Code editor** window, select the created file.
1. In the right part of the window, insert the function code from [GitHub](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/ServerRoomMonitoring/monitoring.py).

   In this function, the data to be sent to the monitoring service is in the `makeAllMetrics` method. If you want to add or remove parameters, make changes to this method.
1. In the **Entry point** field of the **Editor** window, specify `monitoring.msgHandler`.
1. In the **Timeout, sec** field, enter `10`.
1. In the **Memory** field, leave the value `128 MB`.
1. Create a service account to be used for the function to process data from the device:
   1. Click **Create an account**.
   1. In the **Create service account** window that opens, enter an account name in the **Name** field. For example, `my-metrics-function-service-account`.
   1. Add the `serverless.functions.invoker` and `editor` roles for invoking functions and editing resources:
      1. Click the ![image](../../_assets/plus-sign.svg).
      1. Select a role from the list.
      1. Click **Create**.
   1. Configure **Environment variables**:
      1. Click **Add environment variable**.
      1. Fill in the **Key** and **Value** fields for the environment variables:
         Key | Description | Value
         :----- | :----- | :-----
         `VERBOSE_LOG` | Enabling and disabling data logging. | `True`
         `METRICS_FOLDER_ID` | ID of the folder where the services are deployed and for which you'll create a dashboard in {{ monitoring-full-name }}. | See the management console.
1. In the upper-right part of the window, click **Create version**.

### Test the data processing function {#test-processing-function}

To test the function:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. In the left part of the window, select **Testing**.
1. In the **Version tag** field, select `$latest` (most recent function).
1. In the **Payload** field, insert the following data:

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
           }
       ]
   }
   ```
1. Click **Run test**.

If the function is successful, the **Function status** field shows **Done** and the **Function output** field shows the following:

```json
{
"statusCode" : 200 ,
    "headers" : {
        "Content-Type" : "text/plain"
    },
"isBase64Encoded" : false
}
```

### Create a trigger to call the data processing function with a signal{#signal-trigger}

The trigger will call the function when a message appears in the [device topic](../../iot-core/concepts/topic/devices-topic.md).

To create a trigger:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. Select **Triggers**.
1. Click **Create trigger**.
1. In the **Name** field, enter a name for the trigger. For example, `my-monitoring-func-trigger`.
1. (optional) In the **Description** field, add additional information about the trigger.
1. Select a **Type**: **{{ iot-name }}**.
1. Under **message settings {{ iot-name }}**, enter the parameters previously set for the registry and device:
   * **Registry**: `my-registry`.
   * **Device**: `my-device`.
   * **MQTT topic**: `$devices//events`, where `<deviceID>` is the device ID in **{{ iot-short-name }}**.
1. Under **Function settings**, enter the parameters previously set for the function:
   * **Function**: `my-monitoring-func`.
   * **Function version tag**: `$latest`.
   * **Service account**: `my-metrics-function-service-account`.
1. (optional) Set parameters under **Repeat request settings** and **Dead Letter Queue settings**. They provide data security.
   * **Repeat request settings** are useful if you want to recall the function when the current function request fails.
   * **Dead Letter Queue settings** are necessary to forward messages that consumers couldn't process in standard queues.
      You can configure a standard message queue as a DLQ. If you haven't created a message queue yet, [create one in {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).
1. Click **Create trigger**.

All data from the device will be automatically sent to **{{ monitoring-name }}**.

## Set up sensor reading monitoring {#configure-monitoring}

Sensor readings are monitored using a dashboard in {{ monitoring-full-name }}. The controller sends them to the server every 60 seconds via the MQTT protocol. When the sensor readings reach the set values, {{ monitoring-full-name }} sends notifications to users.

{% cut "Data transfer format"%}

```json
 {
    "DeviceId":"e7a68b2d-464e-4222-88bd-c9e8d10a70cd",
    "TimeStamp":"2020-05-21T10:16:43Z",
    "Values":[
        {"Type":"Float","Name":"Humidity","Value":"12.456"},
        {"Type":"Float","Name":"Temperature","Value":"-23.456"},
        {"Type":"Bool","Name":"Water sensor","Value":"false"},
        {"Type":"Bool","Name":"Smoke sensor","Value":"false"},
        {"Type":"Bool","Name":"Room door sensor","Value":"true"},
        {"Type":"Bool","Name":"Rack door sensor","Value":"false"}
    ]
 }
```

{% endcut %}

Set up monitoring of sensor readings by creating dashboard charts and alerts.

### Create charts {#create-diagrams}

To create charts on a dashboard:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ monitoring-short-name }}**.
1. Go to the **Dashboards** tab.
1. Click **Create**.
1. Under **Add widget**, click **New chart**.
1. In the list of **service=** services, select **Custom Metrics**.
1. In the list of **name=** chart types, select **Temperature**.
1. In the **device_id=** list, select the ID of the device that you want to create a chart for.
1. Click **Save**.
1. Repeat the steps for each chart in the list:
   * `Temperature`: Temperature in the room.
   * `Humidity`: Humidity in the room.
   * `Water sensor`: If there is or is not water on the floor.
   * `Smoke sensor`: If there is or is not any smoke.
   * `Room door sensor`: If the door to the room is open or closed.
   * `Rack door sensor`: If the server rack door is open or closed.
1. Click **Save** to save the dashboard.
1. In the window that opens, enter a name for the dashboard and click **Save**.

The dashboard is available via a link to all users {{ yandex-cloud }} with the `viewer` role. You can configure and edit it, zoom in or out, and enable or disable automatic data updates. Learn more about [dashboards](../../monitoring/operations/dashboard/create.md).

### Test the charts on the dashboard{#test-dashboard}

If you change the baselines in the environment variables of the emulating device function, you'll see these changes in the charts.

To test the charts:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. In the left part of the window, select **Functions**. In the list of functions, select `my-device-emulator-function`.
1. Go to the **Editor** tab.
1. Replace some of the original variable values with any other in the **Environment variables** section in the **Value** field at the bottom of the window.

   | Key | Original value | New value |
   :----- | :----- | :-----
   | `HUMIDITY_SENSOR_VALUE` | `80.15` | `40` |
   | `TEMPERATURE_SENSOR_VALUE` | `25.25` | `15` |
   | `RACK_DOOR_SENSOR_VALUE` | `False` | `True` |
   | `ROOM_DOOR_SENSOR_VALUE` | `False` | `True` |
   | `SMOKE_SENSOR_VALUE` | `False` | `True` |
   | `WATER_SENSOR_VALUE` | `False` | `True` |
1. Click **Create version** at the top of the window.
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select the service **{{ monitoring-short-name }}** and see how the chart indicators changed.

### Create an alert {#create-alerts}

Create an alert based on the room temperature sensor readings and set up a list of alert recipients.

The service sends this alert to the recipients if the temperature sensor in the server room shows a certain temperature within a certain period (`5 minutes`):
* `50 degrees`: `Warning` alert.
* `70 degrees`: `Alarm` (a critical value).

To create an alert:
1. In the [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ monitoring-short-name }}**.
1. Click **Create alert**.
1. Enter a name for the alert in the **Main** section, the **Name** field.
1. Under **Metrics**, in the** Metrics** section, click ![image](../../_assets/plus-sign.svg) and fill in the fields:
   1. In the list of **service=** services, select **Custom Metrics**.
   1. In the list of **name=** alert types, select **Temperature**.
   1. In the **device_id=** list, select the ID of the device that you want to create an alert for.
1. In the **Alert settings** section, select the condition to trigger the alert:
   1. In the **Trigger condition** list, select **More**.
   1. In the **Alarm** field, enter `70`.
   1. In the **Warning** field, enter `50`.
1. Click the **Show advanced settings** link to expand additional alert parameters.
1. In the** Aggregation function** list, select **Average**.
1. In the **Evaluation window** list, select `5 minutes`.
1. Under **Notification channel**, click **Add channel**.
1. In the window that opens, click **Create channel**.
1. In the **Name** field, enter a name for the channel. For example, `my-message-channel`.
1. In the **Method** list, select **Email**.

   You can also set up SMS notifications.
1. In the **Recipients** list, select an account.

   You can select multiple recipients for notifications. You can specify the accounts of users who have access to your cloud as recipients. Learn more about [how to add users to {{ yandex-cloud }}](../../iam/operations/users/create.md).
1. Click **Create**.
1. (optional) Select the notification channel from the table and set up additional notification parameters:
   * To enable or disable sending notifications for a specific alert status, click the corresponding **Notify about statuses** column value:
      * `Alarm`.
      * `Warning`.
      * `OK`.
      * `No data`.
   * To set up sending repeated notifications, select in the **Notify again** list when you want to receive them:
      * `Never`.
      * In `5 minutes`.
      * In `10 minutes`.
      * In `30 minutes`.
      * In `1 hour`.
   * To edit the notification channel, click **...** on the right of the row.
1. Click **Create alert** at the bottom of the window.

You can create and configure alerts for any metric in {{ monitoring-full-name }}.

As a result of running this scenario:
1. You can track the sensor readings on the charts.
1. If the sensor readings reach the set values, you'll receive notifications.

## Delete the created cloud resources {#cleanup}

If you no longer need the cloud resources created in this scenario:
* [Delete the registry in the service {{ iot-full-name }}](../../iot-core/operations/registry/registry-delete.md).
* [Delete the device in the service {{ iot-full-name }}](../../iot-core/operations/device/device-delete.md).
* [Delete functions in the service {{ sf-full-name }}](../../functions/operations/function/function-delete.md).
* [Delete function triggers in the service {{ sf-full-name }}](../../functions/operations/trigger/trigger-delete.md).
* [Delete charts in the service {{ monitoring-full-name }}](../../monitoring/operations/).
* [Delete dashboards in the service {{ monitoring-full-name }}](../../monitoring/operations/).
* [Delete alerts and notification channels in the service {{ monitoring-full-name }}](../../monitoring/operations/).