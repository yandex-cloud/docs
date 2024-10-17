{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to get a list of brokers.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**. A list of brokers will be displayed on the **{{ ui-key.yacloud.iot.label_brokers }}** page.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   1. View the description of the CLI command to get a list of brokers:

      ```bash
      yc iot broker list --help
      ```

   1. Get a list of brokers in the default folder:

      ```bash
      yc iot broker list
      ```

      Result:

      ```text
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | b91ki3851h********** | my-broker   |
      +----------------------+-------------+
      ```

- API {#api}

   To get a list of brokers, use the [list](../../iot-core/broker/api-ref/Broker/list.md) REST API method for the [Broker](../../iot-core/broker/api-ref/Broker/index.md) resource or the [BrokerService/List](../../iot-core/broker/api-ref/grpc/Broker/list.md) gRPC API call.

{% endlist %}