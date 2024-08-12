# Viewing operations with the service's resources

All actions with {{ iot-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

   You can get a list of operations for a specific resource. The steps below describe how you can do this for a registry. The same steps apply to other service resources.

   1. In the [management console]({{ link-console-main }}), open the folder with the registry.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.iot.label_registries }}**.
   1. Select the registry.
   1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected registry.

      You will see a list of operations with the selected registry.

- API {#api}

   Use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

   For example, for a registry, use either the [listOperations](../api-ref/Registry/listOperations.md) REST API method for the [Registry](../api-ref/Registry/index.md) resource or the [RegistryService/ListOperations](../api-ref/grpc/registry_service.md#ListOperations) gRPC API call.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the resource.
1. Copy the ID of the operation.
1. Get detailed information about the operation:

   {% list tabs group=instructions %}

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc operation get <operation_ID>
      ```

      Result:

      ```yaml
      id: areojeqlg1bh********
      description: Create device registry
      created_at: "2024-06-19T06:23:13.216Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-06-19T06:23:13.265Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.iot.devices.v1.CreateRegistryMetadata
        registry_id: aresm2hpmh4s********
      response:
        '@type': type.googleapis.com/yandex.cloud.iot.devices.v1.Registry
        id: aresm2hpmh4s********
        folder_id: b1g681qpemb4********
        created_at: "2024-06-19T06:23:13.245974425Z"
        name: my-registry
        status: ACTIVE
        log_options:
          folder_id: b1g681qpemb4********
      ```

   - API {#api}

      Use the [OperationService/Get](../api-ref/grpc/operation_service.md#Get) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
