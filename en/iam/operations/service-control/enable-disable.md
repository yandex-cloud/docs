# Granting and revoking service access

{% include notitle [preview](../../../_includes/note-preview.md) %}

In Yandex Identity and Access Management, you can grant and revoke [service access](../../concepts/service-control.md) to resources in the cloud.

{% include [service-control-access](../../../_includes/iam/service-control-access.md) %}

## Granting access to a service {#enable}

To grant access to cloud resources to a service:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-cloud](../../../_includes/default-cloud.md) %}

   1. View the description of the CLI command for granting access to cloud resources to a service:

      ```bash
      yc iam service-control enable --help
      ```

   1. [Get](./list-get.md#list) a list of services whose access can be managed.

   1. Run the command by providing the ID of the service to which you want to grant access to cloud resources:

      ```bash
      yc iam service-control enable <service_ID>
      ```

      Result:

      ```text
      done (31s)
      service_id: mdb
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-12T13:21:12.331340Z"
      status: ENABLED
      ```

- API {#api}

   Use the [enable](../../api-ref/ServiceControl/enable.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/Enable](../../api-ref/grpc/service_control_service.md#Enable) gRPC API call.

{% endlist %}

## Revoking service access {#disable}

You can revoke a service's access to the cloud only if that service does not have any resources linked to those of another service in the cloud. If there are such resources, delete them first, or [suspend](./pause-resume.md#pause) the service's access instead of revoking it.

To revoke access to cloud resources from a service:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-cloud](../../../_includes/default-cloud.md) %}

   1. View the description of the CLI command for revoking access to cloud resources from a service:

      ```bash
      yc iam service-control disable --help
      ```

   1. [Get](./list-get.md#list) a list of services whose access can be managed.

   1. Run the command by providing the ID of the service from which you want to revoke access to cloud resources:

      ```bash
      yc iam service-control disable <service_ID>
      ```

      Result:

      ```text
      done (17s)
      service_id: mdb
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-13T09:40:40.339678Z"
      status: DISABLED
      ```

- API {#api}

   Use the [disable](../../api-ref/ServiceControl/disable.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/Disable](../../api-ref/grpc/service_control_service.md#Disable) gRPC API call.

{% endlist %}