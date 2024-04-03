# Getting information about service accesses

{% include notitle [preview](../../../_includes/note-preview.md) %}

In Yandex Identity and Access Management, you can manage [service access](../../concepts/service-control.md) to resources in the cloud.

## Getting a list of services {#list}

To get a list of services whose access in the cloud can be managed:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-cloud](../../../_includes/default-cloud.md) %}

   1. View the description of the CLI command to get a list of services whose access to cloud resources can be managed:

      ```bash
      yc iam service-control list --help
      ```

   1. Run this command:

      ```bash
      yc iam service-control list \
        --limit <number_of_services>
      ```

      `--limit`: Number of services you want listed. This is an optional parameter.

      Result:

      ```text
      +--------------------+----------+
      |     SERVICE ID     |  STATUS  |
      +--------------------+----------+
      | connection-manager | DISABLED |
      | mdb                | DISABLED |
      +--------------------+----------+
      ```

- API {#api}

   Use the [list](../../api-ref/ServiceControl/list.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/List](../../api-ref/grpc/service_control_service.md#List) gRPC API call.

{% endlist %}

## Getting information about service access {#get}

To get information about a service's access to cloud resources:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-cloud](../../../_includes/default-cloud.md) %}

   1. View the description of the CLI command to get information about a service's access to cloud resources:

      ```bash
      yc iam service-control get --help
      ```

   1. [Get](#list) a list of services whose access can be managed.

   1. Run the command by providing the ID of the service for which you want the information on access to cloud resources:

      ```bash
      yc iam service-control get <service_ID>
      ```

      Result:

      ```text
      service_id: connection-manager
      resource:
        id: aoenvj7ssrvr********
        type: resource-manager.cloud
      updated_at: "2024-03-13T07:21:00.808442047Z"
      status: DISABLED
      ```

- API {#api}

   Use the [get](../../api-ref/ServiceControl/get.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/Get](../../api-ref/grpc/service_control_service.md#Get) gRPC API call.

{% endlist %}