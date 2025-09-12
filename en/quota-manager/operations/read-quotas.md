---
title: How to view quotas
---

# Viewing quota value

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the cloud to view quotas for.
  1. Select the **{{ ui-key.yacloud.iam.cloud.switch_quotas }}** tab.
     
     The page will display a list of services used in your cloud.
  
  1. Expand a service section and view the values in the **{{ ui-key.yacloud.iam.cloud.quotas.column_usage }}** column.
  
     * Two numbers mean `quota usage / quota value`. For example, `2 / 20` or `1.203 / 5,120 GB`.

     * A single number is a non-adjustable `limit`.

  1. To estimate resource consumption, at the top right, select:
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-warning }}**: Resources consuming over a half of the quota.
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-error }}**: Resources that are almost exhausted.

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
    yc quota-manager quota-limit get --quota-id=compute.disks.count --resource-id=b1gflhy********  --resource-type=resource-manager.cloud
    ```

    In the output, you will get the quota value and usage info for the number of {{ compute-name }} disks in the `b1gflhy********` cloud:

    ```bash
    quota_id: compute.disks.count
    limit: 64
    usage: 30
    ```

    Where:
    * `limit`: Quota value.
    * `usage`: Quota usage.

- API {#api}

  To view the value of a certain quota, i.e., the current resource limit, use the [get](../../quota-manager/api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](../../quota-manager/api-ref/QuotaLimit/index.md) resource or the [QuotaLimitService/Get](../../quota-manager/api-ref/grpc/QuotaLimit/get.md) gRPC API call.

{% endlist %}