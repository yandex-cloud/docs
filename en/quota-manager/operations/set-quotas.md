---
title: How to change quotas
description: Follow this guide to request a quota change, as well as check the status of your request or cancel it.
---

# Changing quotas

{% include [preview-quota](../../_includes/quota-manager/preview-quota.md) %}

{% include [quota-level-access](../../_includes/quota-manager/quota-level-access.md) %}

Quotas can be increased upon request within the platform's technical limits.

{% include [request-quota-roles](../../_includes/quota-manager/request-quota-roles.md) %}

## Requesting quota updates {#request-quota-change}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [request-quota](../../_includes/quota-manager/request-quota.md) %}

- {{ cloud-center }} UI {#cloud-center}

  {% include [request-quota](../../_includes/quota-manager/request-quota-org.md) %}

- CLI {#cli}

  {% include [request-quota-cli](../../_includes/quota-manager/request-quota-cli.md) %}

- API {#api}

    To create a quota update request, use the [create](../api-ref/QuotaRequest/create.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequestService/Create](../api-ref/grpc/QuotaRequest/create.md) gRPC API call.

{% endlist %}

You can also contact [support]({{ link-console-support }}) to request a quota increase; specify your cloud or organization, as well as the quotas and desired values.

You can view the default quotas in the relevant documentation:

* [Quota reference](../all-quotas.md).
* [Platform overview](../../overview/concepts/quotas-limits.md#quotas-limits-default) section.
* **Concepts > Quotas and Limits** page for each service.

There is no reset to default values in {{ quota-manager-name }}.

## Viewing the quota update request status and operations {#view-request-status}

{% list tabs group=instructions %}

- Management console {#console}

  To view the status of and operations with the quota update request for the cloud:

  1. In the [management console]({{ link-console-main }}), select a cloud and navigate to ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}** in the left-hand panel.

  1. Navigate to the **{{ ui-key.yacloud_components.Quota-manager.label_history-tab_n8GVs }}** tab. Optionally, use the status filter.

  1. Open the request in question to view its status, support responses, and the list of operations.

- {{ cloud-center }} UI {#cloud-center}

  To view the status of and operations with the quota update request for the organization:

  1. In [{{ cloud-center }}]({{ cloud-center-link }}), select an organization and open ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}** in the left-hand panel.

  1. Navigate to the **{{ ui-key.yacloud_org.center.quotas.tab_history }}** tab. Optionally, use the status filter.

  1. Open the request in question to view its status, support responses, and the list of operations.

- CLI {#cli}

  1. View the list of quota update requests and find the status of your request.

     {% include [list-quota-requests-cli](../../_includes/quota-manager/list-quota-requests-cli.md) %}

  1. See the list of operations with the request:

     {% include [list-oper-quota-request-cli](../../_includes/quota-manager/list-oper-quota-request-cli.md) %}

- API {#api}

    To view the quota update request status, use the [get](../api-ref/QuotaRequest/get.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequestService/Get](../api-ref/grpc/QuotaRequest/get.md) gRPC API call.

    To view quota update request operations, use the [listOperations](../api-ref/QuotaRequest/listOperations.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequestService/ListOperations](../api-ref/grpc/QuotaRequest/listOperations.md) gRPC API call.

{% endlist %}

## Viewing a list of quota update requests {#list-quota-requests}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a cloud and navigate to ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}** in the left-hand panel.

  1. Navigate to the **{{ ui-key.yacloud_components.Quota-manager.label_history-tab_n8GVs }}** tab. Optionally, use filters to search for your requests.

- {{ cloud-center }} UI {#cloud-center}

  1. In [{{ cloud-center }}]({{ cloud-center-link }}), select an organization and open ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}** in the left-hand panel.

  1. Navigate to the **{{ ui-key.yacloud_org.center.quotas.tab_history }}** tab. Optionally, use filters to search for your requests.

- CLI {#cli}

  {% include [list-quota-requests-cli](../../_includes/quota-manager/list-quota-requests-cli.md) %}

- API {#api}

    To view a list of quota update requests, use the [list](../api-ref/QuotaRequest/list.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequestService/List](../api-ref/grpc/QuotaRequest/list.md) gRPC API call.

{% endlist %}

## Canceling a quota update request {#cancel-quota-request}

{% list tabs group=instructions %}

- Management console {#console}

  To cancel a quota update request for a cloud:

  1. In the [management console]({{ link-console-main }}), select a cloud and navigate to ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}** in the left-hand panel.

  1. Navigate to the **{{ ui-key.yacloud_components.Quota-manager.label_history-tab_n8GVs }}** tab and filter out requests with the **{{ ui-key.yacloud_components.Quota-manager.value_request-status-processing_jiepM }}** status.

  1. Open the request in question and click **{{ ui-key.yacloud_components.iam.cloud.quotas.action_close_request }}**.

- {{ cloud-center }} UI {#cloud-center}

  To cancel a quota update request for an organization:

  1. In [{{ cloud-center }}]({{ cloud-center-link }}), select an organization and open ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}** in the left-hand panel.

  1. Navigate to the **{{ ui-key.yacloud_org.center.quotas.tab_history }}** tab and filter out requests with the **{{ ui-key.yacloud_components.Quota-manager.value_request-status-processing_jiepM }}** status.

  1. Find the request in question and click **{{ ui-key.yacloud_components.iam.cloud.quotas.action_close_request }}**.

- CLI {#cli}

  {% include [cancel-quota-requests-cli](../../_includes/quota-manager/cancel-quota-requests-cli.md) %}

- API {#api}

    To cancel a quota update request, use the [cancel](../api-ref/QuotaRequest/cancel.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequestService/Cancel](../api-ref/grpc/QuotaRequest/cancel.md) gRPC API call.

{% endlist %}
