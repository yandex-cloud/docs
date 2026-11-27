---
title: How to view quotas
alternate:
  - href: en/quota-manager/operations/read-quotas.md
    type: text/markdown
    title: Markdown version
---

# Viewing quota value

{% include [get-quota-roles](../../_includes/quota-manager/get-quota-roles.md) %}

{% include [quota-level-access](../../_includes/quota-manager/quota-level-access.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To view the quota value at the cloud level:

  {% include [get-quota](../../_includes/quota-manager/get-quota-info-cloud.md) %}

- {{ cloud-center }} UI {#cloud-center}

  To view the quota value at the organizational level:

  {% include [get-quota](../../_includes/quota-manager/get-quota-info-org.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  yc quota-manager quota-limit get \
    --quota-id=<quota_ID> \
    --resource-id <resource_ID> \
    --resource-type <resource_type>
  ```

  Where:

  * `--quota-id`: Quota ID you got when [viewing the list of service quotas](../../quota-manager/operations/list-quotas.md#list-service-quotas).
  * `--resource-id`: [Resource](../../resource-manager/concepts/resources-hierarchy.md) ID, i.e., organization, cloud, or billing account ID.
  * `--resource-type`: [Resource type](../../quota-manager/concepts/index.md#resources-types), `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

  Here is an example:

  ```bash
  yc quota-manager quota-limit get --quota-id=compute.disks.count --resource-id=b1gia87mbaom********  --resource-type=resource-manager.cloud
  ```

  In the output, you will get the quota value and usage info for the number of {{ compute-name }} disks in the `b1gia87mbaom********` cloud:

  ```bash
  quota_id: compute.disks.count
  limit: 64
  usage: 30
  ```

  Where:

  * `limit`: Quota value.
  * `usage`: Quota usage.

- API {#api}

    To view the quota value consumption, use the [get](../../quota-manager/api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](../../quota-manager/api-ref/QuotaLimit/index.md) resource or the [QuotaLimitService/Get](../../quota-manager/api-ref/grpc/QuotaLimit/get.md) gRPC API call.

{% endlist %}
