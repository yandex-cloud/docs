# Status monitoring of geographically distributed devices

In this scenario, you'll configure status monitoring for devices (such as vending machines) that are connected to {{ iot-full-name }} and located at various sites in a city. Sensors are emulated using the {{ sf-full-name }} service. If your sensors are connected, use them. You can monitor the status of vending machines on the {{ datalens-full-name }} map and charts.

The source code of this scenario is available on [GitHub](https://github.com/yandex-cloud/examples/tree/master/iot/Scenarios).

To configure monitoring of sensor readings in the server room:

1. [Before you start](#before-you-begin).
{% if product == "yandex-cloud" %}1. [Required paid resources](#paid-resources).{% endif %}
1. [Create the required {{ iot-full-name }} resources](#resources-step).
    1. [Create a registry](#registry-step).
    1. [Create devices](#device-step).
1. [Create a device emulator in {{ sf-full-name }}](#emulator-step).
    1. [Create a function to emulate data transmission from devices](#emulation-function).
    1. [Test the data transmission emulation function](#test-emulation-function).
    1. [Create a trigger to call the emulation function once per minute](#minute-trigger).
1. [Create a cluster in {{ mpg-full-name }}](#postgresql-step).
1. [Create a data processing function in {{ sf-full-name }}](#processing-function-step).
    1. [Create a function for processing data received](#processing-function).
    1. [Test the data processing function](#test-processing-function).
    1. [View the data processing result in {{ mpg-short-name }}](#processing-function-results).
    1. [Create a trigger to call the data processing function](#processing-function-trigger).
    1. [View the trigger result in {{ mpg-short-name }}](#processing-function-trigger-results).
1. [Configure monitoring in {{ datalens-full-name }}](#configure-datalens).
    1. [Set up a connection to {{ mpg-short-name }}](#connect-mpg).
    1. [Create a dataset](#create-dataset).
    1. [Create a chart for temperature and mains power readings](#create-chart).
    1. [Create a chart with a map](#create-chart-map).
    1. [Create a dashboard](#create-dashboard).

If you no longer need the created resources, [delete them](#cleanup).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

If you don't have the {{ yandex-cloud }} command line interface yet, [install and initialize it](../../cli/quickstart.md#install).

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost includes:

* Fee for the number of {{ iot-full-name }} messages (see [pricing](../../iot-core/pricing.md)).
* Fee for the number of {{ sf-full-name }} function calls (see [pricing](../../functions/pricing.md).
* Fee for computing resources and cluster storage in {{ mpg-full-name }} (see [pricing](../../managed-postgresql/pricing.md)).

{% endif %}

## Create the necessary resources {{ iot-short-name }} {#resources-step}

To use {{ iot-short-name }}, you need to create a [registry](../../iot-core/concepts/index.md#registry) and [devices](../../iot-core/concepts/index.md#device) that will exchange data and commands.

### Create a registry and configure authorization using your login and password {#registry-step}

To create a registry:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.

1. Select **{{ iot-short-name }}**.

1. Click **Create registry**.

1. In the **Name** field, enter a name for the registry. For example, `my-registry`.

1. In the **Password** field, set the password to access the registry.

    The password must be at least 14 characters long and contain lowercase letters, capital letters, and numbers.
    To create a password, you can use a [password generator](https://passwordsgenerator.net/).

1. Save the password locally or remember it. The service doesn't show the password after you create it.

1. (optional) In the **Description** field, add additional information about the registry.

1. Click **Create**.

You can also complete authorization using certificates. Learn more [about authorization in {{ iot-short-name }}](../../iot-core/concepts/authorization.md).

### Create a device and configure authorization using your login and password {#device-step}

Create three devices: `my-device-1`, `my-device-2`, and `my-device-3`.

To create a device:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.

1. Select **{{ iot-short-name }}**.
1. Select the registry you created in the previous step.
1. In the left part of the window, select **Devices**.
1. Click **Add device**.
1. In the **Name** field, enter the device name. For example, `my-device-1`.
1. In the **Password** field, set the password to access the device.

    To create a password, you can use a [password generator](https://passwordsgenerator.net/).
    The password must be at least 14 characters long and contain lowercase letters, capital letters, and numbers.

1. Save the password locally or remember it. The service doesn't show the password after you create it.
1. (optional) In the **Description** field, add additional information about the device.
1. (optional) Add [aliases](../../iot-core/concepts/topic/usage.md#aliases):

    1. Click **Add alias**.
    1. Click **Edit**.
    1. Fill in the fields: enter an alias (for example, `events`) and the topic type after `$devices/<deviceID>` (for example, `events`).

        You can use the `events` alias instead of the `$devices/<deviceID>/events` topic.

    1. Repeat the steps for each alias you add.

1. Click **Create**.
1. Repeat the steps for each device you want to create.

You can also complete authorization using certificates. Learn more [about authorization in {{ iot-short-name }}](../../iot-core/concepts/authorization.md).

## Create a device emulator in {{ sf-name }} {#emulator-step}

The emulator will send data from devices to the {{ mpg-full-name }} cluster.

You'll need:

* Create and test the [function](../../functions/concepts/function.md) that emulates transmitting data from each device sensor.
* Create a [trigger](../../functions/concepts/trigger/index.md) that invokes the emulation function once per minute.

### Create a function that emulates transmitting data from the device {#emulation_function}

To create a function:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
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
1. In the right part of the **Code editor** window, insert the function code from [GitHub](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/DashboardForGeoDistributedDevices/device-emulator.js).
1. In the **Editor** window, enter `device-emulator.handler` in the **Entry point** field.
1. In the **Timeout, sec** field, enter `10`.
1. In the **Memory** field, leave the value `128 MB`.
1. Create a service account that the function will use to send data to {{ iot-short-name }}:
    1. Click **Create an account**.
    1. In the **Create service account** window that opens, enter an account name in the **Name** field. For example, `my-emulator-function-service-account`.
    1. Add the `viewer` and `iot.devices.writer` roles for retrieving the device list and writing to resources:
        1. Click the ![image](../../_assets/plus-sign.svg) icon.
        1. Select a role from the list.
        1. Click **Create**.
1. Set **Environment variables** for each sensor in the server room:
    1. Click **Add environment variable**.

    1. Fill in the **Key** and **Value** fields for the environment variables:

        | Key | Description | Value |
        | :----- | :----- | :----- |
        | `CASH_DRAWER_SENSOR_VALUE` | Fullness percentage of the cash drawer. | `67.89` |
        | `COIN_DRAWER_SENSOR_VALUE` | Fullness percentage of the coin drawer. | `67.89` |
        | `TEMPERATURE_SENSOR_VALUE` | Baseline temperature in the pickup box. | `10.34` |
        | `POWER_SENSOR_VALUE` | Baseline mains voltage. | `24.12` |
        | `SERVICE_DOOR_SENSOR_VALUE` | State of the open service door sensor. | `False` |
        | `ITEM1_SENSOR_VALUE` | Stock of product 1. | `50.65` |
        | `ITEM2_SENSOR_VALUE` | Stock of product 2. | `80.97` |
        | `ITEM3_SENSOR_VALUE` | Stock of product 3. | `30.33` |
        | `ITEM4_SENSOR_VALUE` | Stock of product 4. | `15.15` |
        | `REGISTRY_ID` | ID of the registry you created. | See the service <br>management console **{{ iot-short-name }}** |
1. In the upper-right part of the window, click **Create version**.

### Test the emulation function {#test-emulation-function}

To test the function:

1. (optional) To get detailed information from the sensors, subscribe the registry to the {{ iot-full-name }} device topic, where `$devices/<deviceID>/events/` is a device topic, and `<deviceID>` is the device ID in the service:

    {% list tabs %}

    - CLI

        Run the command:

        ```
        yc iot mqtt subscribe \
              --username <registry ID> \
              --password <registry password> \
              --topic '$devices/<device ID>/events' \
              --qos 1
        ```

        Where:

        * `--username` and `--password`: Parameters for authorization using a username and password.
        * `--topic`: Device topic for sending data.
        * `--message`: Message text.
        * `--qos`: Quality of service (QoS).

    {% endlist %}

    Learn more about [subscribing to device topics in {{ iot-full-name }}](../../iot-core/operations/subscribe#one-device).

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.

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
"DeviceId":"arealt9f3jh445it1laq",
"TimeStamp":"2020-07-21T22:38:12Z",
"Values":[
    {"Type":"Bool","Name":"Service door sensor","Value":"false"},
    {"Type":"Float","Name":"Power Voltage","Value":"24.12"},
    {"Type":"Float","Name":"Temperature","Value":"10.34"},
    {"Type":"Float","Name":"Cash drawer fullness","Value":"67.89"},
    {"Type":"Float","Name":"Coin drawer fullness","Value":"67.89"},
    {"Items":[
       {"Type":"Float", "Id":"1","Name":"Item 1","Fullness":"50.65"},
       {"Type":"Float", "Id":"2","Name":"Item 2","Fullness":"80.97"},
       {"Type":"Float", "Id":"3","Name":"Item 3","Fullness":"30.33"},
       {"Type":"Float", "Id":"4","Name":"Item 4","Fullness":"15.15"},
    ]}
    ]
}
```

Learn more about [MQTT topics in {{ iot-short-name }}](../../iot-core/concepts/topic/index.md).

### Create a trigger that invokes the function once per minute {#minute-trigger}

To create a trigger:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
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

## Create a cluster in {{ mpg-full-name }} {#postgresql-step}

The example is based on the minimum values of host parameters. For real tasks, it's better to choose hosts with a guaranteed 100% vCPU share.

To create a cluster:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ mpg-full-name }}**.
1. Select **Clusters**.
1. Click **Create cluster**.
1. Under **Basic parameters**, enter, for example, **my-pg-database** in the `Cluster name` field.
1. (optional) In the **Description** field, add additional information about the cluster.
1. In the **Environment** list, select `PRODUCTION`.
1. In the **Version** list, select `12`.
1. Under **Host class**, select `Intel Ice Lake` in the **Platform** list.
1. Select the VM type: on the **burstable** tab, select **b2.nano**.
1. Under **Storage size**, go to the **network-hdd** tab.
1. Set the storage size to 10 GB.
1. Under **Database**, enter:

    * In the **DB name** field, enter `db1`.
    * In the **User name** field, enter `user1`.
    * In the **Password** field, set the password to access the database.

        Don't forget to save your password, you'll need it.
1. Don't change the values in the **Locale for sorting** and **Charset locale** fields. The default value is `C`.
1. Under **Network**, select `default` in the list.
1. Under **Hosts**, set up a connection to your database via a public IP address (this is necessary to access the database from {{ sf-full-name }}).
    1. On the right side of the availability zone line, click ![image](../../_assets/pencil.svg).
    1. In the window that opens, select an **Availability zone**. For example, `{{ region-id }}-a`.
    1. Select a **Subnet**. For example, `default-{{ region-id }}-a`.
    1. Enable **Public access**.
    1. Click **Save**.
1. Enable **DataLens access**.
1. Click **Create cluster**.

It takes several minutes to create a cluster. As a result, a window with cluster details appears.

## Create a function for processing data in {{ sf-full-name }} {#processing-function-step}

The function processes data from devices.

### Create a function for processing received data {#processing_function}

To create a function:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. In the left part of the window, select **Functions**.
1. Click **Create function**.
1. In the **Name** field, enter the name of the function. For example, `my-db-function`.
1. (optional) In the **Description** field, add additional information about the function.
1. Click **Create**.
1. In the **Editor** window that opens, select `python37` in the **Runtime environment** list.
1. Select **Method**: go to the **Code editor** tab.
1. In the left part of the **Code editor** window, click **Create file**.
1. In the **New file** window that opens, enter the name `myfunction.py`.
1. Click **Create**.
1. In the left part of the **Code editor** window, select the created file.
1. In the right part of the window, insert the function code from [GitHub](https://github.com/yandex-cloud/examples/blob/master/iot/Scenarios/DashboardForGeoDistributedDevices/myfunction.py).
1. In the **Entry point** field of the **Editor** window, specify `myfunction.msgHandler`.
1. In the **Timeout, sec** field, enter `10`.
1. In the **Memory** field, leave the value `128 MB`.
1. Create a service account to be used for the function to process data from the device:
    1. Click **Create an account**.
    1. In the **Create service account** window that opens, enter an account name in the **Name** field. For example, `my-db-function-service-account`.
    1. Add the `serverless.functions.invoker` and `editor` roles for invoking functions and editing resources:
        1. Click the ![image](../../_assets/plus-sign.svg) icon.
        1. Select a role from the list.
        1. Click **Create**.
1. Configure **Environment variables**. You can view database connection parameters in {{ mpg-full-name }}.
    1. Click **Add environment variable**.
    1. Fill in the **Key** and **Value** fields for the environment variables:

        | Key | Description | Value |
        | :----- | :----- | :----- |
        | `VERBOSE_LOG` | Turning data logging on and off. | `True` |
        | `DB_HOSTNAME` | Hostname in {{ mpg-full-name }}. | See the<br>management console for {{ mpg-full-name }} |
        | `DB_PORT` | Port to connect to the cluster in {{ mpg-full-name }}. | `6432` |
        | `DB_NAME` | Cluster name in {{ mpg-full-name }}. | `db1` |
        | `DB_USER` | Username to connect to the cluster in {{ mpg-full-name }}. | `user1` |
        | `DB_PASSWORD` | Password to connect to the cluster in {{ mpg-full-name }}. | The password you set in {{ mpg-full-name }}. |
1. In the upper-right part of the window, click **Create version**.

### Test the data processing function {#test-processing-function}

To test the function:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.

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
                    "payload": "ewogICAgICAgICAgICAiRGV2aWNlSWQiOiJhcmU1NzBrZTA1N29pcjg1bDlmciIsCiAgICAgICAgICAgICJUaW1lU3RhbXAiOiIyMDIwLTA2LTExVDExOjA3OjIwWiIsCiAgICAgICAgICAgICJWYWx1ZXMiOlsKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkJvb2wiLCJOYW1lIjoiU2VydmljZSBkb29yIHNlbnNvciIsIlZhbHVlIjoiRmFsc2UifSwKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwiTmFtZSI6IlBvd2VyIFZvbHRhZ2UiLCJWYWx1ZSI6IjI1LjA2In0sCiAgICAgICAgICAgICAgICB7IlR5cGUiOiJGbG9hdCIsIk5hbWUiOiJUZW1wZXJhdHVyZSIsIlZhbHVlIjoiMTEuMjEifSwKICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwiTmFtZSI6IkNhc2ggZHJhd2VyIGZ1bGxuZXNzIiwiVmFsdWUiOiI2Ny44OSJ9LAogICAgICAgICAgICAgICAgeyJJdGVtcyI6WwogICAgICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwgIklkIjoiMSIsIk5hbWUiOiJJdGVtIDEiLCJGdWxsbmVzcyI6IjUwLjY1In0sCiAgICAgICAgICAgICAgICAgICAgeyJUeXBlIjoiRmxvYXQiLCAiSWQiOiIyIiwiTmFtZSI6Ikl0ZW0gMiIsIkZ1bGxuZXNzIjoiODAuOTcifSwKICAgICAgICAgICAgICAgICAgICB7IlR5cGUiOiJGbG9hdCIsICJJZCI6IjMiLCJOYW1lIjoiSXRlbSAzIiwiRnVsbG5lc3MiOiIzMC4zMyJ9LAogICAgICAgICAgICAgICAgICAgIHsiVHlwZSI6IkZsb2F0IiwgIklkIjoiNCIsIk5hbWUiOiJJdGVtIDQiLCJGdWxsbmVzcyI6IjE1LjE1In0KICAgICAgICAgICAgICAgIF19CiAgICAgICAgICAgICAgICBdCiAgICAgICAgICAgIH0="
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

### View the data processing result in {{ mpg-short-name }} {#processing-function-results}

To view the data processing result:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ mpg-full-name }}**.
1. Go to the **SQL** section.

A table with data processing results is displayed in the right part of the window.

### Create a trigger to invoke the data processing function {#processing-function-trigger}

The trigger invokes the function when [the device topic](../../iot-core/concepts/topic/devices-topic.md) gets messages.

To create a trigger:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ sf-name }}**.
1. Select **Triggers**.
1. Click **Create trigger**.
1. In the **Name** field, enter a name for the trigger. For example, `my-db-func-trigger`.
1. (optional) In the **Description** field, add additional information about the trigger.
1. Select a **Type**: **{{ iot-name }}**.
1. Under **{{ iot-name }}  message settings**, enter the parameters previously set for the registry and device:
    * **Registry**: `my-registry`.
    * **Device**: `Any device`.
    * **MQTT topic**: `$devices/#`.

        Learn more about [MQTT topics in {{ iot-short-name }}](../../iot-core/concepts/topic/index.md).
1. Under **Function settings**, enter the parameters previously set for the function:
    * **Function**: `my-database-function`.
    * **Function version tag**: `$latest`.
    * **Service account**: `my-db-func-trigger-service-account`.
1. (optional) Set parameters under **Repeat request settings** and **Dead Letter Queue settings**. They provide data security.
    * **Repeat request settings** are useful if you want to recall the function when the current function request fails.
    * **Dead Letter Queue settings** are necessary to forward messages that consumers couldn't process in standard queues.
You can configure a standard message queue as a DLQ. If you haven't created a message queue yet, [create one in {{ message-queue-full-name }}](../../message-queue/operations/message-queue-new-queue.md).
1. Click **Create trigger**.

### View the trigger result in {{ mpg-short-name }} {#processing-function-trigger-results}

Shortly after creating the trigger, you can check how it works.

To view the trigger result:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ mpg-full-name }}**.
1. Go to the **SQL** section.

In the right part of the window, you'll see an updated table with a large amount of data.

## Configure monitoring in {{ datalens-full-name }}{#configure-datalens}

### Set up a connection to {{ mpg-short-name }}{#connect-mpg}

To set up a {{ datalens-full-name }} connection to {{ mpg-short-name }}:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ datalens-full-name }}**.
1. Click **Create connection**.
1. Select the **PostgreSQL** connector.

    When connecting to an external data source (which is not a {{ yandex-cloud }} resource), grant access to the source [for the {{ datalens-name }} IP address ranges](../../datalens/concepts/connection.md#changing-connection-ranges).

1. Enter a name for the connection: `MyPGConnection`.
1. Select a **Connection**: **Select in cloud**.
1. Under **Cluster**, select `my-pg-database`.
1. Under **Hostname**, select the host you created in {{ mpg-full-name }}.
1. In the **Port** field, enter `6432`.
1. Under **Database name**, select `db1`.
1. Under **Username**, select `user1`.
1. In the **Password** field, enter the password you set to access the cluster in {{ mpg-full-name }}.
1. Click **Create**. The connection appears in the list.

### Create a dataset {#create-dataset}

To create a dataset:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ datalens-full-name }}**.
1. Click **Create dataset**.
1. To the left of the screen, click **![image](../../_assets/plus-sign.svg) Add **.
1. Select `MyPGConnection`.
1. In the left part of the window, select the `public.iot_events` and `public.iot_position` tables, and drag them to the right.
1. Click **Save**.
1. In the window that opens, set the name of the dataset to `My-pg-dataset` and click **Create**.

The dataset appears in the list.

### Create a chart for temperature and mains voltage {#create-chart}

To create a chart for temperature and mains voltage:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ datalens-full-name }}**.
1. Click **Create chart**.
1. Under **Dataset**, select `My-pg-dataset`, which you created earlier.
1. Select the **Line chart** chart type.
1. From the **Dimensions** section in the left part of the window, drag the dimension to the **Line chart** section:
    * `event_datetime` to the **X** section.

        A timeline will appear in the lower part of the chart on the X-axis.

    * `temperature` and `power_voltage` to the **Y** section.

        The temperature and mains voltage values will appear on the Y-axis of the chart.

1. Click **Save**.
1. In the window that opens, set the chart name or use the generated name `My-pg-dataset — Line chart` and click **Save**.

### Create a chart with a map {#create-chart-map}

To create a chart with a map:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ datalens-full-name }}**.
1. In the left part of the window, select **Datasets**.
1. In the list, select `My-pg-dataset`.
1. Go to the **Fields** tab.
1. In the right part of the window, click **Add field**.
1. In the window that opens, in the **Field name** field, enter `Position`.
1. In the **Formula** field, insert `GEOPOINT([latitude],[longitude])`.
1. Click **Create**.
1. Click **Save**.
1. In the upper-right corner, click **Create chart**.
1. Select the **Map** chart type.
1. From the **Dimensions** section in the left part of the window, drag the measurements to the **Map** section:
    * `Position` to the **Geopoints** section.
    * `item1_fullness`, `item1_fullness`, `item1_fullness`, `item1_fullness`, `cash_drawer`, and `coin_drawer` to the **Tooltips** section.

        In the right part of the window, you'll see a scalable map with vending machines marked with points on the map and tooltips marked with legend lines.

1. Click **Save**.
1. In the window that opens, set the chart name or use the generated name `My-pg-dataset — Map` and click **Save**.

### Create a dashboard {#create-dashboard}

To create a dashboard:

1. In [management console]({{ link-console-main }}), select the folder where you are running the scenario.
1. Select **{{ datalens-full-name }}**.
1. Click **Create dashboard**.
1. In the window that opens, enter the dashboard name `MyDash`.
1. Add the following charts to the dashboard: `My-pg-dataset — Map` and `My-pg-dataset — Line chart`, which you created earlier:
    1. In the **Add** dropdown list at the top of the window, select **Chart**.
    1. In the dropdown **Chart** list, select the `My-pg-dataset — Map` chart.

        The chart name will appear in the **Name** field.

    1. (optional) In the **Description** field, enter a description for the chart.
    1. Click **Add**.
    1. Repeat the steps to add the `My-pg-dataset — Line chart` chart.
1. Configure the selector:
    1. In the **Add** dropdown list at the top of the window, select **Selector**.
    1. In the **Name** field, enter **Device**.
    1. In the **Dataset** list, select `My-pg-dataset`.
    1. In the **Field** list, select `device_id`.
    1. In the **Default value** list, select the ID of the device you created in {{ iot-short-name }}.
    1. Click **Add**.
1. Configure links:
    1. At the top of the window, click **Links**.
    1. In the list at the top of the window that opens, select the `My-pg-dataset — Point map` chart.
    1. In the dropdown **In.link** list, select `Ignore`.

        Maps don't support the **Links** parameter.

    1. Click **Save**.
    1. From the list at the top of the window, select the `My-pg-dataset — Line chart` chart.
    1. In the **In.link** dropdown list, select `In.link`.
    1. Click **Save**.
1. Click **Save**.

Learn more [about {{ datalens-full-name }} dashboards](../../datalens/concepts/dashboard.md).
