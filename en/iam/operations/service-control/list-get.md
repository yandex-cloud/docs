---
title: Getting information about the status of {{ yandex-cloud }} services
description: In this guide, you will learn how to get information about the status of {{ yandex-cloud }} services.
---

# Getting the status of services



{% include notitle [preview](../../../_includes/note-preview.md) %}


In {{ iam-full-name }}, you can manage [service access](../../concepts/service-control.md) to user resources in a specific cloud.

## Getting a list of services {#list}

To get a list of services whose access in the cloud can be managed:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. View the description of the CLI command to get a list of services whose access you can manage:

      ```bash
      yc iam service-control list --help
      ```

  1. Run this command:

      ```bash
      yc iam service-control list \
        --limit <number_of_services>
      ```

      Where `--limit` is the number of services to list. This is an optional parameter.

      Result:

      ```text
      +--------------------+----------+
      |     SERVICE ID     |  STATUS  |
      +--------------------+----------+
      | connection-manager | ENABLED  |
      | datasphere         | DISABLED |
      | disk-encryption    | DEFAULT  |
      | dspm               | DEFAULT  |
      | websql             | ENABLED  |
      +--------------------+----------+
      ```

- API {#api}

  Use the [list](../../api-ref/ServiceControl/list.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/List](../../api-ref/grpc/ServiceControl/list.md) gRPC API call.

{% endlist %}

## Getting information about a service status {#get}

To get information about the [status](../../concepts/service-control.md#access-status) of a service in a cloud:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. See the description of the CLI command to get information about the status of a service in a cloud:

      ```bash
      yc iam service-control get --help
      ```

  1. [Get](#list) a list of services whose access can be managed.

  1. Run the command by specifying the ID of the service whose status in this cloud you want to get:

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

  Use the [get](../../api-ref/ServiceControl/get.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/Get](../../api-ref/grpc/ServiceControl/get.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](./enable-disable.md)
* [{#T}](../../concepts/service-control.md)