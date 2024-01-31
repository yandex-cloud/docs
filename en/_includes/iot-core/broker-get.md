{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the broker is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. Select the broker. Detailed information about the broker will be displayed on the **{{ ui-key.yacloud.common.overview }}** page.

- CLI {#cli}

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

- API {#api}

   To get detailed information about a broker, use the [get](../../iot-core/broker/api-ref/Broker/get.md) REST API method for the [Broker](../../iot-core/broker/api-ref/Broker/index.md) resource or the [BrokerService/Get](../../iot-core/broker/api-ref/grpc/broker_service.md#Get) gRPC API call.

{% endlist %}
