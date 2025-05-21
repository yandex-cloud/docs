---
title: Getting started with {{ quota-manager-full-name }}
description: Follow this guide to view quotas for your services.
---

# Getting started with {{ quota-manager-full-name }}

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

{% include [about-quota](../_includes/quota-manager/about-quota.md) %}

Potentially, you can increase quotas to the _limits_.

**Limits** are technical constraints of the {{ yandex-cloud }} architecture, hardware physical characteristics, or external limitations.

The diagram below illustrates the relationship between quotas and limits.

![image](../_assets/quota-manager/quotas-limits.svg)

Currently, you can use the following quota management interfaces: 

* [Console]({{ link-console-quotas }}): Get information and request quota updates.
* [CLI](api-ref/authentication.md): Get information about quotas.
* [API](api-ref/authentication.md): Get information about quotas.

Going forward, you will also be able to request quota updates via the CLI and API.

## Getting information about quotas

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the cloud to view quotas for.
  1. Select the **{{ ui-key.yacloud.iam.cloud.switch_quotas }}** tab.
     
     The page will display a list of services used in your cloud.
  
  1. Expand a service section and view the values in the **{{ ui-key.yacloud.iam.cloud.quotas.column_usage }}** column.
  
     * Two numbers mean `quota consumption / quota value`. For example, `2 / 20` or `1.203 / 5,120 GB`.

     * A single number is a non-adjustable `limit`.

  1. To estimate resource consumption, at the top right, select:
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-warning }}**: Resources consuming over a half of the quota.
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-error }}**: Resources that are almost exhausted.

- CLI {#cli}

  **Configure operations via the CLI**

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}
  
   The account must have the `quota-manager.viewer` [role](../iam/operations/roles/grant.md) to view quotas.

  **View the quotas**

  1. View the list of services with quotas.
  
      ```bash
      yc quota-manager quota-limit list-services --resource-type=<resource_type>
      ```

      Where `--resource-type` is the [resource type](concepts/index.md#resources-types): 
      * `resource-manager.cloud`: Cloud.
      * `organization-manager.organization`: Organization.
      * `billing.account`: Billing account.

      Example:

      ```bash
      yc quota-manager quota-limit list-services --resource-type=resource-manager.cloud
      ```

      The output will return the list of cloud-level services with available quotas.

  1. View a list of quotas for a specific service as well as all quota values and usage.
  
      ```bash
      yc quota-manager quota-limit list \
         --service=<service_name> \
         --resource-type=<resource_type> \
         --resource-id=<resource_ID>
      ```

      Where:
       * `--service`: Service name you obtained at the previous step. You can also look up the name of the service in the [YC CLI](../cli/cli-ref/) reference.
       * `--resource-id` is the [resource](../resource-manager/concepts/resources-hierarchy.md) ID: organization, cloud, folder, or billing account ID.
       * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      Example:

      ```bash
      yc quota-manager quota-limit list --service=iam --resource-type=resource-manager.cloud --resource-id=b1gflhy********
      ``` 

      The output will return the IDs of quotas available in {{ iam-short-name }} within the `b1gflhy********` cloud together with their values and usage.

  1. View the value and usage of a given quota.
  
      ```bash
      yc quota-manager quota-limit get \
         --quota-id=<quota_ID> \
         --resource-id <resource_ID> \
         --resource-type <resource_type>
      ```

      Where:
       * `--quota-id`: Quota ID you got in the previous step.
       * `--resource-id`: ID of the resource (organization, cloud, or billing account).
       * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      Example:

      ```bash
      yc quota-manager quota-limit get --quota-id=iam.apiKeys.count --resource-id=b1gflhy********  --resource-type=resource-manager.cloud
      ```

      The output will return the value and usage of the quota for the number of API keys in the `b1gflhy********` cloud.

      ```bash
      quota_id: iam.apiKeys.count
      limit: 1000
      usage: 27
      ```

      Where:
       * `limit`: Quota value.
       * `usage`: Quota usage.

- API {#api}

  **Configure operations via the API**

  1. To check that you can work with quotas via the API, install these utilities:
     * [cURL](https://curl.haxx.se) if using the [REST API](api-ref/)
     * [gRPCurl](https://github.com/fullstorydev/grpcurl) if using the [gRPC API](api-ref/grpc/)
  
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

  1. View a list of quotas for a specific service as well as all quota values and usage.
  
      To do this, use the [list](api-ref/QuotaLimit/list.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md) gRPC API call.

      To test the REST API method, run this request:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM_token>" \
      "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits?service=<serviceName>&resource.id=<resourceId>&resource.type=<resourceType>"
      ```

      Where:

      * `<resourceId>`: ID of the resource: organization, cloud, or billing account.
      * `<resourceType>`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<serviceName>`: Service name.
      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
        
      Request example:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer $IAM_TOKEN" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits?service=iam&resource.id=b1gflhy********&resource.type=resource-manager.cloud'
      ```

  1. View the value and usage of a given quota.
  
      To do this, use the [get](api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md) gRPC API call.

      To test the REST API method, send this request:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM_token>" \
      "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/<quotaId>?resource.id=<resourceId>&resource.type=<resourceType>"
      ```

      Where:

      * `<quotaId>`: Quota ID you got in the previous step.
      * `<resourceId>`: ID of the resource (organization, cloud, or billing account).
      * `<resourceType>`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      
      Request example:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer $IAM_TOKEN" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/iam.accessKeys.count?resource.id=b1gflhy********&resource.type=resource-manager.cloud'
      ```

{% endlist %}

## Requesting a quota increase

{% include [request-quota](../_includes/quota-manager/request-quota.md) %}