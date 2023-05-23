{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
   1. Select **{{ iot-short-name }}**.
   1. Select the registry.
   1. The **Overview** page shows the registry details.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Get detailed information about the registry:

  ```
  yc iot registry get <registry name>
  ```

  Result:

  ```
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```

- API

  To get detailed information about a registry, use the [get](../../iot-core/api-ref/Registry/get.md) REST API method for the [Registry](../../iot-core/api-ref/Registry/index.md) resource or the [RegistryService/Get](../../iot-core/api-ref/grpc/registry_service.md#Get) gRPC API call.

{% endlist %}
