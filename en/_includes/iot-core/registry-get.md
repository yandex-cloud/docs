{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry.
   1. The **{{ ui-key.yacloud.common.overview }}** page will show the registry details.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. View the description of the CLI command to get information about the registry:
	
      ```bash
      yc iot registry get --help
      ```

  1. Get detailed information about the registry by specifying its name or ID:

      ```bash
      yc iot registry get <registry_name>
      ```

      Result:

      ```text
      id: b91ki3851hab********
      folder_id: aoek49ghmknn********
      created_at: "2019-05-28T11:29:42.420Z"
      name: my-registry
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get detailed information about a registry using {{ TF }}:
  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

     ```hcl
     data "yandex_iot_core_registry" "my_registry" {
       registry_id = "<registry_ID>"
     }

     output "registry_params" {
       value = data.yandex_iot_core_registry.my_registry.created_at
     }
     ```

     Where:
     * `data "yandex_iot_core_registry"`: Description of the registry as a data source:
       * `registry_id`: Registry ID.
     * `output "registry_params"`: Output variable that contains information about the registry creation timestamp:
       * `value`: Returned value.

     You can replace `created_at` with any other parameter to get the information you need. For more information about the `yandex_iot_core_registry` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/iot_core_registry).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

     ```bash
     terraform output
     ```

     Result:

     ```text
     registry_params = "2024-05-08T06:40:52Z"
     ```

- API {#api}

  To get detailed information about a registry, use the [get](../../iot-core/api-ref/Registry/get.md) REST API method for the [Registry](../../iot-core/api-ref/Registry/index.md) resource or the [RegistryService/Get](../../iot-core/api-ref/grpc/Registry/get.md) gRPC API call.

{% endlist %}
