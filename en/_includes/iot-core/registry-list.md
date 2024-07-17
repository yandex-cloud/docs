{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to get a list of registries.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. The **{{ ui-key.yacloud.iot.label_registries }}** page will show the list of registries.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. View the description of the CLI command to get a list of registries:

      ```bash
      yc iot registry list --help
      ```

  1. Get a list of registries in the default folder:

      ```bash
      yc iot registry list
      ```

      Result:

      ```text
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | b91ki3851hab******** | my-registry |
      +----------------------+-------------+
      ```

- API {#api}

  To get a list of registries, use the [list](../../iot-core/api-ref/Registry/list.md) REST API method for the [Registry](../../iot-core/api-ref/Registry/index.md) resource or the [RegistryService/List](../../iot-core/api-ref/grpc/registry_service.md#List) gRPC API call.

{% endlist %}