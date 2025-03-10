---
title: Getting started with {{ quota-manager-full-name }}
description: Follow this guide to view quotas for your services.
---

# Getting started with {{ quota-manager-full-name }}

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

{% include [about-quota](../_includes/quota-manager/about-quota.md) %}

Potentially, you can increase your quotas up to the _limits_.

**Limits** are technical constraints due to the {{ yandex-cloud }} architecture, physical characteristics of the hardware, or external limitations.

Currently, you can use the following quota management interfaces: 

* [Console]({{ link-console-quotas }}): Get information and request quota updates.
* [API](api-ref/authentication.md): Get information about quotas.

Going forward, you will also be able to get information and request quota updates via the CLI and API.

## Getting information about quotas

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the cloud to view quotas for.
  1. Select the **{{ ui-key.yacloud.iam.cloud.switch_quotas }}** tab.
     
     The page will display a list of services used in your cloud.
  
  1. Expand the relevant service section and view the values in the **{{ ui-key.yacloud.iam.cloud.quotas.column_usage }}** column.
  
     * Two numbers stand for `consumed quota / quota value`, e.g., `2 / 20` or `1.203 / 5,120 GB`.

     * A single number is a non-adjustable `limit`.

  1. To estimate resource consumption, at the top right, select:
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-warning }}**: Resources consuming over a half of the quota.
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-error }}**: Resources that are almost exhausted.

- API {#api}

  **Configure operations via the API**

  1. To check that you can work with quotas via the API, install these utilities:
     * [cURL](https://curl.haxx.se) if using the [REST API](../../../workload/api-ref/)
     * [gRPCurl](https://github.com/fullstorydev/grpcurl) if using the [gRPC API](../../../workload/api-ref/grpc/)
  
  1. [Create a service account](../iam/operations/sa/create.md) with the `quota-manager.viewer` [role](../iam/operations/roles/grant.md).
  
  1. [Get an IAM token](../iam/operations/iam-token/create-for-sa.md) for the created service account.
  
  **View the quotas**

  1. View the list of services with quotas.
  
      To do this, use the [listServices](api-ref/QuotaLimit/listServices.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/ListServices](api-ref/grpc/QuotaLimit/listServices.md) gRPC API call.

      To test the REST API method, send this request:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM_token>" \
      "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/services?resourceType=<resourceType>"
      ```

      Where:

      * `<resourceType>`: [Resource type](concepts/index.md#resources-types), `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.

      Request example:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer $IAM_TOKEN" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/services?resourceType=resource-manager.cloud'

  1. View a list of quotas for a specific service.
  
      To do this, use the [list](api-ref/QuotaLimit/list.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md) gRPC API call.

      To test the REST API method, send this request:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM_token>" \
      "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits?service=<serviceName>&resource.id=<resourceId>&resource.type=<resourceType>"
      ```

      Where:

      * `<resourceId>`: [Resource](../resource-manager/concepts/resources-hierarchy.md) ID.
      * `<resourceType>`: [Resource type](concepts/index.md#resources-types.md), `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<serviceName>`: Service name.
      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
        
      Request example:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer $IAM_TOKEN" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits?service=iam&resource.id=yc.iam.service-cloud&resource.type=resource-manager.cloud'
      ```

  1. View the value of a specific quota.
  
      To do this, use the [get](api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md) gRPC API call.

      To test the REST API method, send this request:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM_token>" \
      "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/<quotaId>?resource.id=<resourceId>&resource.type=<resourceType>"
      ```

      Where:

      * `<quotaId>`: Quota ID you got in the previous step.
      * `<resourceId>`: Resource ID.
      * `<resourceType>`: [Resource type](concepts/index.md#resources-types), `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      
      Request example:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer $IAM_TOKEN" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/iam.accessKeys.count?resource.id=yc.iam.service-cloud&resource.type=resource-manager.cloud'
      ```

{% endlist %}

## Requesting a quota increase

{% include [request-quota](../_includes/quota-manager/request-quota.md) %}
