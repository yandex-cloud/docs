{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to get a list of brokers.
   1. Select **{{ iot-short-name }}**.
   1. On the left-hand panel, select **Brokers**. A list of brokers is displayed on the **Brokers** page.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   Get a list of brokers in the folder:

   ```
   yc iot broker list
   ```

   Result:

   ```
   +----------------------+-------------+
   |          ID          |    NAME     |
   +----------------------+-------------+
   | b91ki3851h********** | my-broker   |
   +----------------------+-------------+
   ```

- API

   To get a list of brokers, use the [list](../../iot-core/broker/api-ref/Broker/list.md) REST API method for the [Broker](../../iot-core/broker/api-ref/Broker/index.md) resource or the [BrokerService/List](../../iot-core/broker/api-ref/grpc/broker_service.md#List) gRPC API call.

{% endlist %}