{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the registry is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry.
   1. The **{{ ui-key.yacloud.common.overview }}** page will show the registry details.

- CLI {#cli}

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   Get detailed information about the registry:

   ```
   yc iot registry get <registry_name>
   ```

   Result:

   ```
   id: b91ki3851hab********
   folder_id: aoek49ghmknn********
   created_at: "2019-05-28T11:29:42.420Z"
   name: my-registry
   ```

- API {#api}

   To get detailed information about a registry, use the [get](../../iot-core/api-ref/Registry/get.md) REST API method for the [Registry](../../iot-core/api-ref/Registry/index.md) resource or the [RegistryService/Get](../../iot-core/api-ref/grpc/registry_service.md#Get) gRPC API call.

{% endlist %}
