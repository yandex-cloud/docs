---
title: How to view the list of services and quotas
---

# Viewing the list of services and quotas

## Viewing the list of services that have available quotas

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), on the left, select a cloud.
  1. Select the **{{ ui-key.yacloud.iam.cloud.switch_quotas }}** tab.
     
     The page will display the list of services that have available quotas.


- API {#api}

  To get the list of services, use the [listServices](../api-ref/QuotaLimit/listServices.md) REST API method for the [QuotaLimit](../api-ref/QuotaLimit/) resource or the [QuotaLimitService/ListServices](../api-ref/grpc/QuotaLimit/listServices.md) gRPC API call.

{% endlist %}

## Viewing the list of quotas for the service

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), on the left, select a cloud.
  1. Select the **{{ ui-key.yacloud.iam.cloud.switch_quotas }}** tab.
  1. Open the section of the service you want to view quotas for.


- API {#api}

  To get the list of quotas for a specific service, use the [list](../api-ref/QuotaLimit/list.md) REST API method for the [QuotaLimit](../api-ref/QuotaLimit/) resource or the [QuotaLimitService/List](../api-ref/grpc/QuotaLimit/list.md) gRPC API call.

{% endlist %}