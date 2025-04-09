---
title: How to view the list of services and quotas
---

# Viewing the list of services and quotas

## Viewing the list of services that have available quotas {#list-services}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), on the left, select a cloud.
  1. Select the **{{ ui-key.yacloud.iam.cloud.switch_quotas }}** tab.
     
     The page will display the list of services that have available quotas.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

    ```bash
    yc quota-manager quota-limit list-services --resource-type=<resource_type>
    ```

    Where `--resource-type` is the [resource type](../concepts/index.md#resources-types), `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

- API {#api}

  To get the list of services, use the [listServices](../api-ref/QuotaLimit/listServices.md) REST API method for the [QuotaLimit](../api-ref/QuotaLimit/) resource or the [QuotaLimitService/ListServices](../api-ref/grpc/QuotaLimit/listServices.md) gRPC API call.

{% endlist %}

## Viewing the list of service quotas {#list-service-quotas}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), on the left, select a cloud.
  1. Select the **{{ ui-key.yacloud.iam.cloud.switch_quotas }}** tab.
  1. Open the section of the service you want to view quotas for.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  yc quota-manager quota-limit list \
    --service=<service_name> \
    --resource-type=<resource_type> \
    --resource-id=<resource_ID>
  ```

  Where:
  * `--service` is the name of the service in the [YC CLI](../cli/cli-ref/).
  * `--resource-id` is the ID of the [resource](../../resource-manager/concepts/resources-hierarchy.md): organization, cloud, folder, or billing account.
  * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.


  Example:

  ```bash
  yc quota-manager quota-limit list \
    --service=compute \
    --resource-type=resource-manager.cloud \
    --resource-id=b1gflhy********
  ```

  The output will return the list of {{ compute-name }} quotas for the cloud with the `b1gflhy********` ID.

  ```bash
  resource:
    id: b1gflhy********
    type: resource-manager.cloud
  quota_limits:
    - quota_id: compute.dedicatedHosts.count
      limit: 1
      usage: 0
    - quota_id: compute.diskPlacementGroups.count
      limit: 5
      usage: 1
    - quota_id: compute.diskPools.count
      limit: 0
      usage: 0
    - quota_id: compute.disks.count
      limit: 64
      usage: 30
  - quota_id: compute.filesystems.count
      limit: 100
      usage: 1
  - quota_id: compute.hddDisks.size
      limit: 1116691496960
      usage: 464930209792
  ...
  ```

  Where:
  * `limit`: Quota value
  * `usage`: Quota usage

- API {#api}

  To get the list of quotas for a specific service, use the [list](../api-ref/QuotaLimit/list.md) REST API method for the [QuotaLimit](../api-ref/QuotaLimit/) resource or the [QuotaLimitService/List](../api-ref/grpc/QuotaLimit/list.md) gRPC API call.

{% endlist %}
