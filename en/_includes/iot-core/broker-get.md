{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the broker is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. Select the broker. Detailed information about the broker will be displayed on the **{{ ui-key.yacloud.common.overview }}** page.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   1. View the description of the CLI command to get information about a broker:

      ```bash
      yc iot broker get --help
      ```

   1. Get detailed information about a broker by specifying its name or ID:

      ```bash
      yc iot broker get <broker_name>
      ```

      Result:

      ```text
      id: b91ki3851h**********
      folder_id: aoek49ghmk**********
      created_at: "2022-05-28T11:29:42.420Z"
      name: my-broker
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To get information about a broker using {{ TF }}:
   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_iot_core_broker" "my_broker" {
        broker_id = "<broker_id>"
      }

      output "broker_params" {
        value = data.yandex_iot_core_broker.my_broker.created_at
      }
      ```

      Where:
      * `data "yandex_iot_core_broker"`: Description of the broker as a data source:
         * `broker_id`: Broker ID.
      * `output "broker_params"`: Output variable that contains information about the broker creation timestamp:
         * `value`: Returned value.

      You can replace `created_at` with any other parameter to get the information you need. For more information about the `yandex_iot_core_broker` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_iot_core_broker).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      broker_params = "2024-05-09T17:39:54Z"
      ```

- API {#api}

   To get detailed information about a broker, use the [get](../../iot-core/broker/api-ref/Broker/get.md) REST API method for the [Broker](../../iot-core/broker/api-ref/Broker/index.md) resource or the [BrokerService/Get](../../iot-core/broker/api-ref/grpc/Broker/get.md) gRPC API call.

{% endlist %}
