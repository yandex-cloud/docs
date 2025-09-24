---
title: Getting started with {{ quota-manager-full-name }}
description: Follow this guide to view quotas for your services.
---

# Getting started with {{ quota-manager-full-name }}

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

{{ quota-manager-name }} allows you to manage quotas of your {{ yandex-cloud }} services using different interfaces. Some services, such as {{ speechkit-name }} and {{ video-full-name }}, are not available in {{ quota-manager-name }}.

**Quotas** are limits on the amount of resources you can use in cloud. These are organizational constraints that can be changed as needed.

The key concepts in quota management are:

* **Quota limit** or just **quota**: Current limit in place for a resource for a cloud or organization.

* **Quota usage**: Amount or size of the actually used resource.

Potentially, you can increase your quotas up to the _limits_.

**Limits** are technical constraints of the {{ yandex-cloud }} architecture, hardware physical characteristics, or external limitations.

![image](../_assets/quota-manager/quotas-limits.svg)

You can use the following interfaces to manage quotas: 

* [Console]({{ link-console-quotas }}) and [API](api-ref/authentication.md): Getting info and submitting a quota update request.
* [CLI](cli-ref/index.md): Getting quota info. Quota update request functionality due to be added.

To manage quotas via the CLI and API, you need the quota ID. For the list of IDs, see [this section](../overview/concepts/quotas-limits.md).

## Getting quota info {#get-quota-info}

To view quotas, you need the `quota-manager.viewer` [role](../iam/operations/roles/grant.md).

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

  1. **Configure operations via the CLI.**

      {% include [cli-install](../_includes/cli-install.md) %}

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. **See the list of services with quotas.**

      ```bash
      yc quota-manager quota-limit list-services --resource-type=<resource_type>
      ```

      Where `--resource-type` is the [resource type](concepts/index.md#resources-types): 
      * `resource-manager.cloud`: Cloud.
      * `organization-manager.organization`: Organization.
      * `billing.account`: Billing account.

      **Example command**

      ```bash
      yc quota-manager quota-limit list-services --resource-type=resource-manager.cloud
      ```

      In the output, you will get a list of cloud-level services with quotas available.

  1. **View the values and usage of all quotas in a service.**

      ```bash
      yc quota-manager quota-limit list \
         --service=<service_name> \
         --resource-type=<resource_type> \
         --resource-id=<resource_ID>
      ```

      Where:
      * `--service`: Service name you obtained at the previous step.
      * `--resource-id`: [Resource](../resource-manager/concepts/resources-hierarchy.md) ID, i.e., organization, cloud, or billing account ID.
      * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Example command**

      ```bash
      yc quota-manager quota-limit list --service=iam --resource-type=resource-manager.cloud --resource-id=b1gflhy********
      ``` 

      In the output, you will get the IDs of the quotas in place in {{ iam-short-name }} within the `b1gflhy********` cloud, their values ​and usage figures.

  1. **View value and usage info for a particular quota.**
  
      ```bash
      yc quota-manager quota-limit get \
         --quota-id=<quota_ID> \
         --resource-id <resource_ID> \
         --resource-type <resource_type>
      ```

      Where:
      * `--quota-id`: Quota ID. You can look up the ID in [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default).
      * `--resource-id`: ID of the resource (organization, cloud, or billing account).
      * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Example command**

      ```bash
      yc quota-manager quota-limit get --quota-id=iam.apiKeys.count --resource-id=b1gflhy********  --resource-type=resource-manager.cloud
      ```

      In the output, you will get quota value and usage info for the number of API keys in the `b1gflhy********` cloud.

      ```bash
      quota_id: iam.apiKeys.count
      limit: 1000
      usage: 27
      ```

      Where:
      * `limit`: Quota value.
      * `usage`: Quota usage.

- REST API {#api}

  1. **Configure API operations.**

      1. To check that you can work with quotas via the [REST API](./api-ref/index.md), install [cURL](https://curl.haxx.se).
      1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) it the `quota-manager.viewer` [role](./security/index.md#quota-manager-viewer).
      1. [Get an IAM token](../iam/operations/iam-token/create-for-sa.md) for the created service account.

  1. **View the list of services with quotas.**

      Use the [ListServices](api-ref/QuotaLimit/listServices.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/index.md) resource:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM_token>" \
        "https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/services?resourceType=<resource_type>"
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<resource_type>`: [Resource type](concepts/index.md#resources-types), either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Request example**

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer ${IAM_TOKEN?}" \
        'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/services?resourceType=resource-manager.cloud'
      ```

      **Response example**

      ```json
      {
        "services": [
          {
            "id": "alb",
            "name": "Application Load Balancer"
          },
          {
            "id": "audit-trails",
            "name": "Audit Trails"
          },
          ...
          {
            "id": "ylb",
            "name": "Network Load Balancer"
          },
          {
            "id": "yq",
            "name": "Yandex Query"
          }
        ]
      }
      ```

  1. **View the values and usage of all quotas in a service.**

      Use the [List](api-ref/QuotaLimit/list.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/index.md) resource:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM_token>" \
        "https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits?service=<service_ID>&resource.id=<resource_ID>&resource.type=<resource_type>"
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<service_ID>`: Service ID obtained in the previous step.
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Request example**

      {% include [get-quota-service](../_includes/quota-manager/get-quota-service.md) %}

      **Response example**

      {% include [get-quota-service-response-curl](../_includes/quota-manager/get-quota-service-response-curl.md) %}

  1. **View value and usage info for a particular quota.**
  
      Use the [Get](api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/index.md) resource:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM_token>" \
        "https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/<quota_ID>?resource.id=<resource_ID>&resource.type=<resource_type>"
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<quota_ID>`: Quota ID. You can look up the ID in [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default).
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Request example**

      {% include [get-quota-info](../_includes/quota-manager/get-quota-info.md) %}

      **Response example**

      {% include [get-quota-info-response-curl](../_includes/quota-manager/get-quota-info-response-curl.md) %}

- gRPC API {#grpc-api}

  1. **Configure API operations.**

      1. To check that you can work with quotas via the [gRPC API](./api-ref/grpc/index.md), install [gRPCurl](https://github.com/fullstorydev/grpcurl).
      1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) it the `quota-manager.viewer` [role](./security/index.md#quota-manager-viewer).
      1. [Get an IAM token](../iam/operations/iam-token/create-for-sa.md) for the created service account.

  1. **View the list of services with quotas.**

      Use the [QuotaLimitService/ListServices](api-ref/grpc/QuotaLimit/listServices.md) gRPC API call:

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM_token>" \
        -d "{\"resource_type\": \"<resource_type>\"}" \
        {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/ListServices
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<resource_type>`: [Resource type](concepts/index.md#resources-types), either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Request example**

      ```bash
      grpcurl \
        -H "Authorization: Bearer ${IAM_TOKEN?}" \
        -d "{\"resource_type\": \"resource-manager.cloud\"}" \
        {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/ListServices
      ```

      **Response example**

      ```json
      {
        "services": [
          {
            "id": "alb",
            "name": "Application Load Balancer"
          },
          {
            "id": "audit-trails",
            "name": "Audit Trails"
          },
          ...
          {
            "id": "ylb",
            "name": "Network Load Balancer"
          },
          {
            "id": "yq",
            "name": "Yandex Query"
          }
        ]
      }
      ```

  1. **View the values and usage of all quotas in a service.**

      Use the [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md) gRPC API call:

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM_token>" \
        -d "{ \"resource\": { \"id\": \"<resource_ID>\", \"type\": \"<resource_type>\" }, \"service\": \"<service_ID>\"}" \
        {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/List
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<service_ID>`: Service ID obtained in the previous step.

      **Request example**

      {% include [get-quota-service-grpc](../_includes/quota-manager/get-quota-service-grpc.md) %}

      **Response example**

      {% include [get-quota-service-response-grpc](../_includes/quota-manager/get-quota-service-response-grpc.md) %}

  1. **View value and usage info for a particular quota.**

      Use the [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md) gRPC API call:

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM_token>" \
        -d "{ \"resource\": { \"id\": \"<resource_ID>\", \"type\": \"<resource_type>\" }, \"quota_id\": \"<quota_ID>\"}" \
        {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/Get
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<quota_ID>`: Quota ID. You can look up the ID in [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default).

      **Request example**

      {% include [get-quota-info-grpc](../_includes/quota-manager/get-quota-info-grpc.md) %}

      **Response example**

      {% include [get-quota-info-response-grpc](../_includes/quota-manager/get-quota-info-response-grpc.md) %}

{% endlist %}

## Requesting quota changes {#request-quota-change}

{% include [request-quota-restriction](../_includes/quota-manager/request-quota-restriction.md) %}

{% include [request-quota-roles](../_includes/quota-manager/request-quota-roles.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [request-quota](../_includes/quota-manager/request-quota.md) %}

- REST API {#api}

  1. **Configure API operations.**

      1. To check that you can work with quotas via the [REST API](./api-ref/index.md), install [cURL](https://curl.haxx.se).
      1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) it the `quota-manager.requestOperator` [role](./security/index.md#quota-manager-requestoperator).
      1. [Get an IAM token](../iam/operations/iam-token/create-for-sa.md) for the created service account.

  1. **Create a quota update request.**

      [View the quota ID](../overview/concepts/quotas-limits.md#quotas-limits-default) and use the [Create](api-ref/QuotaRequest/create.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/index.md) resource:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer <IAM_token>" \
        --data '{"resource": {"id": "<resource_ID>", "type": "<resource_type>"}, "desired_quota_limits": [{"quota_id": "<quota_ID>", "desired_limit": "<new_quota_value>"}]}' \
        'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests'
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<quota_ID>`: ID of the quota to update.
      * `<new_quota_value>`: New value to assign to the selected quota.

      **Request example**

      {% include [request-quota-change](../_includes/quota-manager/request-quota-change.md) %}

      **Response example**

      {% include [request-quota-change-response-curl](../_includes/quota-manager/request-quota-change-response-curl.md) %}

   1. **View the list of quota update requests.**

      Use the [List](api-ref/QuotaRequest/list.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/index.md) resource:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM_token>" \
        'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests?page_size=<page_size>&resource.id=<resource_ID>&resource.type=<resource_type>'
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<page_size>`: Number of items per page.
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Request example**

      {% include [list-quota-requests](../_includes/quota-manager/list-quota-requests.md) %}

      **Response example**

      {% include [list-quota-requests-response-curl](../_includes/quota-manager/list-quota-requests-response-curl.md) %}

   1. **View the status of your quota update request.**

      Use the [Get](api-ref/QuotaRequest/get.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/index.md) resource:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM_token>" \
        'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests/<request_ID>'
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<request_ID>`: Quota update request ID you got in the previous step.

      **Request example**

      {% include [list-quota-requests](../_includes/quota-manager/view-request-status.md) %}

      **Response example**

      {% include [view-request-status-response-curl](../_includes/quota-manager/view-request-status-response-curl.md) %}

- gRPC API {#grpc-api}

  1. **Configure API operations.**

      1. To check that you can work with quotas via the [gRPC API](./api-ref/grpc/index.md), install [gRPCurl](https://github.com/fullstorydev/grpcurl).
      1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) it the `quota-manager.requestOperator` [role](./security/index.md#quota-manager-requestoperator).
      1. [Get an IAM token](../iam/operations/iam-token/create-for-sa.md) for the created service account.

  1. **Create a quota update request.**

      [View the quota ID](../overview/concepts/quotas-limits.md#quotas-limits-default) and create a request using the [QuotaRequestService/Create](api-ref/grpc/QuotaRequest/create.md) gRPC API call:

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM_token>" \
        -d "{\"resource\": {\"id\": \"<resource_ID>\", \"type\": \"<resource_type>\"}, \"desired_quota_limits\": [{\"quota_id\": \"<quota_ID>\", \"desired_limit\": \"<new_quota_value>\"}]}" \
        {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Create
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.
      * `<quota_ID>`: ID of the quota to update.
      * `<new_quota_value>`: New value to assign to the selected quota.

      **Request example**

      {% include [request-quota-change-grpc](../_includes/quota-manager/request-quota-change-grpc.md) %}

      **Response example**

      {% include [request-quota-change-response-grpc](../_includes/quota-manager/request-quota-change-response-grpc.md) %}

  1. **View the list of quota update requests.**

      Use the [QuotaRequestService/List](api-ref/grpc/QuotaRequest/list.md) gRPC API call:

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM_token>" \
        -d "{\"resource\": {\"id\": \"<resource_ID>\", \"type\": \"<resource_type>\"}}" \
        {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/List
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Request example**

      {% include [list-quota-requests-grpc](../_includes/quota-manager/list-quota-requests-grpc.md) %}

      **Response example**

      {% include [list-quota-requests-response-grpc](../_includes/quota-manager/list-quota-requests-response-grpc.md) %}

  1. **View the status of your quota update request.**

      Use the [QuotaRequestService/Get](api-ref/grpc/QuotaRequest/get.md) gRPC API call:

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM_token>" \
        -d "{\"quota_request_id\": \"<request_ID>\"}" \
        {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
      ```

      Where:

      * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
      * `<request_ID>`: Quota update request ID you got in the previous step.

      **Request example**

      {% include [view-request-status-grpc](../_includes/quota-manager/view-request-status-grpc.md) %}

      **Response example**

      {% include [view-request-status-response-grpc](../_includes/quota-manager/view-request-status-response-grpc.md) %}

{% endlist %}
