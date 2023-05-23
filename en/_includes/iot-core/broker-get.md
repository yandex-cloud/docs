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

   To get detailed information about a broker, use the [get](../../iot-core/broker/api-ref/Broker/get.md) REST API method for the [Broker](../../iot-core/broker/api-ref/Broker/index.md) resource or the [BrokerService/Get](../../iot-core/broker/api-ref/grpc/broker_service.md#Get) gRPC API call.

{% endlist %}
