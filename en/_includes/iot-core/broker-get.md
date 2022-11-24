{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the broker is located.
   1. Select **{{ iot-short-name }}**.
   1. On the left-hand panel, select **Brokers**.
   1. Select the broker. Detailed information about the broker is displayed on the **Overview** page.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   Get detailed information about the broker:

   ```
   yc iot broker get <broker name>
   ```

   Result:

   ```
   id: b91ki3851h**********
   folder_id: aoek49ghmk**********
   created_at: "2022-05-28T11:29:42.420Z"
   name: my-broker
   ```

- API

   You can get detailed information about a broker using the [get](../../iot-core/api-ref/Broker/get) API method.

{% endlist %}