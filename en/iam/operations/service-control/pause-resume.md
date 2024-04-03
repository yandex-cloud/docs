# Suspending and restoring service access

{% include notitle [preview](../../../_includes/note-preview.md) %}

In Yandex Identity and Access Management, you can suspend and restore [service access](../../concepts/service-control.md) to resources in the cloud.

{% include [service-control-access](../../../_includes/iam/service-control-access.md) %}

## Suspending service access {#pause}

You can suspend a service access to the cloud even if that service has resources that use the resources of other cloud services.

{% note alert %}

If the service's resources require access to other resources in the cloud, suspending access to the cloud for this service may cause disruptions in the resources, including data loss.

{% endnote %}

To suspend a service access to cloud resources:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-cloud](../../../_includes/default-cloud.md) %}

   1. View the description of the CLI command for suspending service access to cloud resources:

      ```bash
      yc iam service-control pause --help
      ```

   1. [Get](./list-get.md#list) a list of services whose access can be managed.

   1. Run the command by providing the ID of the service for which you want to suspend access to cloud resources:

      ```bash
      yc iam service-control pause <service_ID> \
        --force
      ```

      `--force`: Parameter allowing you to suspend service access if the service has resources requiring access to other cloud services. This is an optional parameter.

      Result:

      ```text
      done (11s)
      service_id: mdb
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-12T13:22:23.609016Z"
      status: PAUSED
      ```

- API {#api}

   Use the [pause](../../api-ref/ServiceControl/pause.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/Pause](../../api-ref/grpc/service_control_service.md#Pause) gRPC API call.

{% endlist %}

## Restoring service access {#resume}

You can only restore access for a service whose access was previously [suspended](#pause).

To restore service access to cloud resources:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-cloud](../../../_includes/default-cloud.md) %}

   1. View the description of the CLI command for restoring service access to cloud resources:

      ```bash
      yc iam service-control resume --help
      ```

   1. [Get](./list-get.md#list) a list of services whose access can be managed.

   1. Run the command by providing the ID of the service for which you want to restore access to cloud resources:

      ```bash
      yc iam service-control resume <service_ID>
      ```

      Result:

      ```text
      done (10s)
      service_id: mdb
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-12T13:22:58.247213Z"
      status: ENABLED
      ```

- API {#api}

   Use the [resume](../../api-ref/ServiceControl/resume.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/Resume](../../api-ref/grpc/service_control_service.md#Resume) gRPC API call.

{% endlist %}