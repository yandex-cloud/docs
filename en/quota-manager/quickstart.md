---
title: Getting started with {{ quota-manager-full-name }}
description: Follow this guide to view quotas for your services.
---

# Getting started with {{ quota-manager-full-name }}

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

{{ quota-manager-name }} allows you to manage quotas using different interfaces. Some services, e.g., {{ speechkit-name }}, are not available in {{ quota-manager-name }}.

**Quotas**: Resource usage limits in the cloud or organization. They help manage resource usage, avoid overspending, and plan budgets.

Quotas have two indicators:

* **Quota limit** or just **quota**: Current limit in place for a resource for a cloud or organization.

* **Quota usage**: Amount of the actually used resource.

Quotas can be increased upon request within the _limits_.

**Limits** are technical constraints of the {{ yandex-cloud }} architecture, hardware physical characteristics, or external limitations.

![image](../_assets/quota-manager/quotas-limits.svg)

{% include [quota-level-access](../_includes/quota-manager/quota-level-access.md) %}

To manage resource quotas through the CLI and API, use their IDs from the [{#T}](all-quotas.md) section.

## Getting started {#before-you-begin}

This guide assumes that you already have {{ yandex-cloud }} resources in the cloud or organization.

Make sure the user or service account has the following [roles](../iam/concepts/access-control/roles.md):

{% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  Log in to the [management console]({{ link-console-main }}) and select a cloud.

- {{ cloud-center }} UI {#cloud-center}

  Log in to [{{ cloud-center }}]({{ cloud-center-link }}) and select an organization.

- CLI {#cli}

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

- REST API {#api}

    1. Install [cURL](https://curl.haxx.se).
    1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) it one of the roles listed above.
    1. {% include [before-begin-api-get-iam-token](../_includes/quota-manager/before-begin-api-get-iam-token.md) %}

- gRPC API {#grpc-api}

    1. Install the [gRPCurl](https://github.com/fullstorydev/grpcurl) utility.
    1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) it one of the roles listed above.
    1. {% include [before-begin-api-get-iam-token](../_includes/quota-manager/before-begin-api-get-iam-token.md) %}

{% endlist %}

## Getting quota info {#get-quota-info}

{% list tabs group=instructions %}

- Management console {#console}

  To get information about quotas in the cloud:

  {% include [get-quota](../_includes/quota-manager/get-quota-info-cloud.md) %}


- CLI {#cli}

  1. See the list of services with quotas.

     ```bash
     yc quota-manager quota-limit list-services \
       --resource-type <resource_type>
     ```

     Where `--resource-type` is the [resource type](concepts/index.md#resources-types):

     * `resource-manager.cloud`: [Cloud](../resource-manager/concepts/resources-hierarchy.md#cloud).
     * `organization-manager.organization`: [Organization](../organization/concepts/organization.md).
     * `billing.account`: [Billing account](../billing/concepts/billing-account.md).

     Command example:

     ```bash
     yc quota-manager quota-limit list-services \
       --resource-type resource-manager.cloud
     ```

     This will output a list of services with cloud-level quotas.

  1. View the values and usage of all quotas in a service.

     ```bash
     yc quota-manager quota-limit list \
       --service <service_name> \
       --resource-type <resource_type> \
       --resource-id <resource_ID>
     ```

     Where:

     * `--service`: Service ID you got in the previous step.
     * `--resource-id`: [Resource](../resource-manager/concepts/resources-hierarchy.md) ID, i.e., organization, cloud, or billing account ID.
     * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

     Command example:

     {% include [get-quota-service-cli](../_includes/quota-manager/get-quota-service-cli.md) %}

     {% include [get-quota-service-cli-output](../_includes/quota-manager/get-quota-service-cli-output.md) %}

  1. View the value and usage of a given quota.

     ```bash
     yc quota-manager quota-limit get \
       --quota-id <quota_ID> \
       --resource-id <resource_ID> \
       --resource-type <resource_type>
     ```

     Where:

     * `--quota-id`: Quota ID. You can look up the ID in [{#T}](all-quotas.md).
     * `--resource-id`: ID of the resource (organization, cloud, or billing account).
     * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

     Command example:

     {% include [get-quota-info-cli](../_includes/quota-manager/get-quota-info-cli.md) %}

     {% include [get-quota-info-cli-output](../_includes/quota-manager/get-quota-info-cli-output.md) %}

- REST API {#api}

  1. View the list of services with quotas.

     Use the [listServices](api-ref/QuotaLimit/listServices.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/index.md) resource:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer <IAM_token>" \
       "https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/services?resourceType=<resource_type>"
     ```

     Where:

     * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
     * `<resource_type>`: [Resource type](concepts/index.md#resources-types), either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

     Request example:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer ${IAM_TOKEN?}" \
       'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/services?resourceType=resource-manager.cloud'
     ```

     Response example:

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

  1. View the values and usage of all quotas in a service.

     Use the [list](api-ref/QuotaLimit/list.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/index.md) resource:

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

     Request example:

     {% include [get-quota-service](../_includes/quota-manager/get-quota-service.md) %}

     Response example:

     {% include [get-quota-service-response-curl](../_includes/quota-manager/get-quota-service-response-curl.md) %}

  1. View the value and usage of a given quota.

     Use the [get](api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/index.md) resource:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer <IAM_token>" \
       "https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/<quota_ID>?resource.id=<resource_ID>&resource.type=<resource_type>"
     ```

     Where:

     * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
     * `<quota_ID>`: Quota ID. You can look up the ID in [{#T}](all-quotas.md).
     * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
     * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

     Request example:

     {% include [get-quota-info](../_includes/quota-manager/get-quota-info.md) %}

     Response example:

     {% include [get-quota-info-response-curl](../_includes/quota-manager/get-quota-info-response-curl.md) %}

- gRPC API {#grpc-api}

  1. View the list of services with quotas.

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

     Request example:

     ```bash
     grpcurl \
       -H "Authorization: Bearer ${IAM_TOKEN?}" \
       -d "{\"resource_type\": \"resource-manager.cloud\"}" \
       {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/ListServices
     ```

     Response example:

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

  1. View the values and usage of all quotas in a service.

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

     Request example:

     {% include [get-quota-service-grpc](../_includes/quota-manager/get-quota-service-grpc.md) %}

     Response example:

     {% include [get-quota-service-response-grpc](../_includes/quota-manager/get-quota-service-response-grpc.md) %}

  1. View the value and usage of a given quota.

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
     * `<quota_ID>`: Quota ID. You can look up the ID in [{#T}](all-quotas.md).

     Request example:

     {% include [get-quota-info-grpc](../_includes/quota-manager/get-quota-info-grpc.md) %}

     Response example:

     {% include [get-quota-info-response-grpc](../_includes/quota-manager/get-quota-info-response-grpc.md) %}

{% endlist %}

## Requesting quota changes {#request-quota-change}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [request-quota](../_includes/quota-manager/request-quota.md) %}

- CLI {#cli}

  1. Create a quota update request.

     {% include [request-quota-cli](../_includes/quota-manager/request-quota-cli.md) %}

     Command example:

     {% include [request-quota-change-cli](../_includes/quota-manager/request-quota-change-cli.md) %}

     {% include [request-quota-change-legend2](../_includes/quota-manager/request-quota-change-legend2.md) %}

     Response example:

     {% include [request-quota-change-cli-response](../_includes/quota-manager/request-quota-change-cli-response.md) %}

  1. View the list of quota update requests.

     {% include [list-quota-requests-cli](../_includes/quota-manager/list-quota-requests-cli.md) %}

     Command example:

     {% include [list-quota-requests-cli-example](../_includes/quota-manager/list-quota-requests-cli-example.md) %}

     Response example:

     {% include [list-quota-requests-cli-response](../_includes/quota-manager/list-quota-requests-cli-response.md) %}

  1. View the status of your quota update request.

     {% include [get-quota-request-cli](../_includes/quota-manager/get-quota-request-cli.md) %}

     Response example:

     {% include [get-quota-request-cli-response](../_includes/quota-manager/get-quota-request-cli-response.md) %}

- REST API {#api}

  1. Create a quota update request.

     [View the quota ID](all-quotas.md) and use the [create](api-ref/QuotaRequest/create.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/index.md) resource:

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

     Request example:

     {% include [request-quota-change](../_includes/quota-manager/request-quota-change.md) %}

     Response example:

     {% include [request-quota-change-response-curl](../_includes/quota-manager/request-quota-change-response-curl.md) %}

  1. View the list of quota update requests.

     Use the [list](api-ref/QuotaRequest/list.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/index.md) resource:

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

     Request example:

     {% include [list-quota-requests](../_includes/quota-manager/list-quota-requests.md) %}

     Response example:

     {% include [list-quota-requests-response-curl](../_includes/quota-manager/list-quota-requests-response-curl.md) %}

  1. View the status of your quota update request.

     Use the [get](api-ref/QuotaRequest/get.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/index.md) resource:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer <IAM_token>" \
       'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests/<request_ID>'
     ```

     Where:

     * `<IAM_token>`: Service account IAM token or the environment variable containing the token.
     * `<request_ID>`: Quota update request ID you got in the previous step.

     Request example:

     {% include [list-quota-requests](../_includes/quota-manager/view-request-status.md) %}

     Response example:

     {% include [view-request-status-response-curl](../_includes/quota-manager/view-request-status-response-curl.md) %}

- gRPC API {#grpc-api}

  1. Create a quota update request.

     [View the quota ID](all-quotas.md) and create a request using the [QuotaRequestService/Create](api-ref/grpc/QuotaRequest/create.md) gRPC API call:

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

     Request example:

     {% include [request-quota-change-grpc](../_includes/quota-manager/request-quota-change-grpc.md) %}

     Response example:

     {% include [request-quota-change-response-grpc](../_includes/quota-manager/request-quota-change-response-grpc.md) %}

  1. View the list of quota update requests.

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

     Request example:

     {% include [list-quota-requests-grpc](../_includes/quota-manager/list-quota-requests-grpc.md) %}

     Response example:

     {% include [list-quota-requests-response-grpc](../_includes/quota-manager/list-quota-requests-response-grpc.md) %}

  1. View the status of your quota update request.

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

     Request example:

     {% include [view-request-status-grpc](../_includes/quota-manager/view-request-status-grpc.md) %}

     Response example:

     {% include [view-request-status-response-grpc](../_includes/quota-manager/view-request-status-response-grpc.md) %}

{% endlist %}

You can also contact [support]({{ link-console-support }}) to request a quota increase; specify your cloud or organization, as well as the quotas and desired values.
