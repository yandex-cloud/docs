{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to get a list of registries.
   1. Select **{{ iot-short-name }}**.
   1. The **Registries** page shows the list of registries.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Get a list of registries in the folder:

  ```
  yc iot registry list
  ```

  Result:

  ```
  +----------------------+-------------+
  |          ID          |    NAME     |
  +----------------------+-------------+
  | b91ki3851hab9m0l68je | my-registry |
  +----------------------+-------------+
  ```

- API

  To get a list of registries, use the [list](../../iot-core/api-ref/Registry/list.md) REST API method for the [Registry](../../iot-core/api-ref/Registry/index.md) resource or the [RegistryService/List](../../iot-core/api-ref/grpc/registry_service.md#List) gRPC API call.

{% endlist %}