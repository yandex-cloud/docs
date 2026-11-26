---
title: How to view the list of services and quotas
---

# Viewing the list of services and quotas

{% include [quota-level-access](../../_includes/quota-manager/quota-level-access.md) %}

{% include [get-quota-roles](../../_includes/quota-manager/get-quota-roles.md) %}

## Viewing the list of services that have available quotas {#list-services}

{% list tabs group=instructions %}

- Management console {#console}

  To view the list of cloud services with quotas:

  1. In the [management console]({{ link-console-main }}), select a cloud and navigate to ![image](../../_assets/console-icons/square-plus.svg)**{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}** in the left-hand panel.

     The **{{ ui-key.yacloud_components.Quota-manager.label_quotas-tab_323nV }}** tab will display a list of services in the **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** and **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** groups.

- {{ cloud-center }} UI {#cloud-center}

  To view the list of services with quotas within an organization:

  1. In [{{ cloud-center }}]({{ cloud-center-link }}), select an organization and open ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}** in the left-hand panel.

     The **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}** tab will display a list of services in the **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** and **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** groups.

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

  To view quotas for a cloud service:

  1. In the [management console]({{ link-console-main }}), select a cloud and navigate to ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}** in the left-hand panel.

  1. On the **{{ ui-key.yacloud_components.Quota-manager.label_quotas-tab_323nV }}** tab, enter the service name and the quota name or ID in the search bar.

  1. In the **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** or **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** group, expand the appropriate section.

- {{ cloud-center }} UI {#cloud-center}

  To view quotas for a service within an organization:

  1. In [{{ cloud-center }}]({{ cloud-center-link }}), select an organization and open ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}** in the left-hand panel.

  1. On the **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}** tab, enter the service name and the quota name or ID in the search bar.

  1. In the **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** or **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** group, expand the appropriate section.

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

  * `--service`: Service ID you got when [viewing the list of services](#list-services).
  * `--resource-id`: [Resource](../../resource-manager/concepts/resources-hierarchy.md) ID, i.e., organization, cloud, or billing account ID.
  * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.


  Here is an example:

  ```bash
  yc quota-manager quota-limit list \
    --service=compute \
    --resource-type=resource-manager.cloud \
    --resource-id=b1gia87mbaom********
  ```

  This returns a list of {{ compute-name }} quotas in the `b1gia87mbaom********` cloud.

  ```bash
  resource:
    id: b1gia87mbaom********
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
