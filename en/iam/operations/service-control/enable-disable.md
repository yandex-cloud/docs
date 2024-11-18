---
title: Enabling and disabling {{ yandex-cloud }} services
description: In this guide, you will learn how to enable and disable services to manage their access to user resources in {{ yandex-cloud }}.
---

# Enabling and disabling a service



{% include notitle [preview](../../../_includes/note-preview.md) %}


In {{ iam-full-name }}, you can enable and disable [service access](../../concepts/service-control.md) to user resources in a specific cloud.

{% include [service-control-access](../../../_includes/iam/service-control-access.md) %}

## Enabling a service {#enable}

To grant access to user cloud resources to a service, you need enable the service:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. View the description of the CLI command for enabling a service:

      ```bash
      yc iam service-control enable --help
      ```

  1. [Get](./list-get.md#list) a list of services you can enable or disable with information on their [statuses](../../concepts/service-control.md#access-status).

  1. Run the command, specifying the ID of the service to enable:

      ```bash
      yc iam service-control enable <service_ID>
      ```

      Result:

      ```text
      done (31s)
      service_id: dspm
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-12T13:21:12.331340Z"
      status: ENABLED
      ```

- API {#api}

  Use the [enable](../../api-ref/ServiceControl/enable.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/Enable](../../api-ref/grpc/ServiceControl/enable.md) gRPC API call.

{% endlist %}

This will change the service [status](../../concepts/service-control.md#access-status) in the specified cloud to `ENABLED` and create the [service agents](../../concepts/service-control.md#service-agent) with permissions to manage user resources in this cloud.

## Disabling a service {#disable}

If a service has resources with access to the other user resources in this cloud, you cannot disable this service. To disable such a service, first delete all the service resources that have access to the other user resources.

To revoke the service's access to the user resources in the cloud, disable the service:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-cloud](../../../_includes/default-cloud.md) %}

  1. View the description of the CLI command for disabling a service:

      ```bash
      yc iam service-control disable --help
      ```

  1. [Get](./list-get.md#list) a list of services you can enable or disable with information on their [statuses](../../concepts/service-control.md#access-status).

  1. Run the command, specifying the ID of the service to disable:

      ```bash
      yc iam service-control disable <service_ID>
      ```

      Result:

      ```text
      done (17s)
      service_id: dspm
      resource:
        id: b1gmgc24pte8********
        type: resource-manager.cloud
      updated_at: "2024-03-13T09:40:40.339678Z"
      status: DISABLED
      ```

- API {#api}

  Use the [disable](../../api-ref/ServiceControl/disable.md) REST API method for the [ServiceControl](../../api-ref/ServiceControl/index.md) resource or the [ServiceControlService/Disable](../../api-ref/grpc/ServiceControl/disable.md) gRPC API call.

{% endlist %}

As a result, the [status](../../concepts/service-control.md#access-status) of the service in the specified cloud will change to `DISABLED`, its [service agents](../../concepts/service-control.md#service-agent) will be deleted, and the service will lose access to user resources in this cloud.

#### See also {#see-also}

* [{#T}](./list-get.md)
* [{#T}](../../concepts/service-control.md)