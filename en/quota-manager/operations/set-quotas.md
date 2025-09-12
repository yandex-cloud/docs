---
title: How to change quotas
---

# Changing quotas

Potentially, you can change your quotas ​​up to the limit values, i.e., the cloud platform's ceiling.

{% include [request-quota-restriction](../../_includes/quota-manager/request-quota-restriction.md) %}

{% include [request-quota-roles](../../_includes/quota-manager/request-quota-roles.md) %}

## Requesting quota updates {#request-quota-change}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [request-quota](../../_includes/quota-manager/request-quota.md) %}

- API {#api}

  To create a quota update request, use the [Create](../api-ref/QuotaRequest/create.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequest/create](../api-ref/grpc/QuotaRequest/create.md) gRPC API call.

{% endlist %}

You can view the default quotas in the relevant documentation:

* On the general [quota page](../../overview/concepts/quotas-limits.md#quotas-limits-default).
* On the **Concepts > Quotas and Limits** page for each service.

There is no reset to default values in {{ quota-manager-name }}.

## Viewing the quota update request status and operations {#list-operation-request}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the cloud to view quotas for.
  1. In the right-hand panel, select **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
  1. Expand **{{ ui-key.yacloud.iam.cloud.quotas.label_pending-requests-title }}**.
  1. Select the request of interest and view the responses from support and related operations.

- API {#api}

  To view the quota update request status, use the [get](../api-ref/QuotaRequest/get.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequest/Get](../api-ref/grpc/QuotaRequest/get.md) gRPC API call.

  To view quota update request operations, use the [listOperations](../api-ref/QuotaRequest/listOperations.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequest/listOperations](../api-ref/grpc/QuotaRequest/listOperations.md) gRPC API call.

{% endlist %}

## Viewing a list of quota update requests {#list-quota-requests}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [support]({{ link-console-support }}) section, select **{{ ui-key.yacloud_org.support.switch_tickets }}**.
  1. In the **{{ ui-key.yacloud_org.support.tickets.table.label_column_ticket_type }}** filter list, select **{{ ui-key.support-center.search.common.title_suggestion-quotas }}**.

- API {#api}

  To view a list of quota update requests, use the [List](../api-ref/QuotaRequest/list.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequest/list](../api-ref/grpc/QuotaRequest/list.md) gRPC API call.

{% endlist %}

## Canceling a quota update request {#cancel-quota-request}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the cloud to view quotas for.
  1. In the right-hand panel, select **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
  1. Expand **{{ ui-key.yacloud.iam.cloud.quotas.label_pending-requests-title }}**.
  1. Select the request of interest and click **{{ ui-key.yacloud_components.helpfeedbackdialog.button_close }}**

- API {#api}

  To cancel a quota update request, use the [Cancel](../api-ref/QuotaRequest/cancel.md) REST API method for the [QuotaRequest](../api-ref/QuotaRequest/) resource or the [QuotaRequest/cancel](../api-ref/grpc/QuotaRequest/cancel.md) gRPC API call.

{% endlist %}