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

You can use the following interfaces to manage quotas: the [management console]({{ link-console-quotas }}), [API](api-ref/authentication.md), and [CLI](cli-ref/index.md).

To manage quotas via the CLI and API, you need the quota ID. For the list of IDs, see [{#T}](all-quotas.md).

## Getting started {#before-you-begin}

To get started in {{ yandex-cloud }}:

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md).
1. Depending on the interface you are going to use, follow these additional steps:

    {% list tabs group=instructions %}

    - Management console {#console}

      Make sure the user has the following [roles](../iam/concepts/access-control/roles.md):

      {% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

    - CLI {#cli}

      1. {% include [cli-install](../_includes/cli-install.md) %}

          {% include [default-catalogue](../_includes/default-catalogue.md) %}

      1. Make sure the user or service account authenticated in the CLI profile has the following [roles](../iam/concepts/access-control/roles.md):

          {% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

    - REST API {#api}

      1. Install [cURL](https://curl.haxx.se).
      1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) it the following [roles](../iam/concepts/access-control/roles.md):

          {% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

      1. {% include [before-begin-api-get-iam-token](../_includes/quota-manager/before-begin-api-get-iam-token.md) %}

    - gRPC API {#grpc-api}

      1. Install the [gRPCurl](https://github.com/fullstorydev/grpcurl) utility.
      1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) it the following [roles](../iam/concepts/access-control/roles.md):

          {% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

      1. {% include [before-begin-api-get-iam-token](../_includes/quota-manager/before-begin-api-get-iam-token.md) %}

    {% endlist %}

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
     * **Actively used**: Resources consuming over a half of the quota.
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-error }}**: Resources that are almost exhausted.

- CLI {#cli}

  1. **See the list of services with quotas.**

      ```bash
      yc quota-manager quota-limit list-services \
        --resource-type <resource_type>
      ```

      Where `--resource-type` is the [resource type](concepts/index.md#resources-types): 
      * `resource-manager.cloud`: [Cloud](../resource-manager/concepts/resources-hierarchy.md#cloud). 
      * `organization-manager.organization`: [Organization](../organization/concepts/organization.md). 
      * `billing.account`: [Billing account](../billing/concepts/billing-account.md).

      **Example command**

      ```bash
      yc quota-manager quota-limit list-services \
        --resource-type resource-manager.cloud
      ```

      In the output, you will get a list of cloud-level services with quotas available.

  1. **View the values and usage of all quotas in a service.**

      ```bash
      yc quota-manager quota-limit list \
         --service <service_name> \
         --resource-type <resource_type> \
         --resource-id <resource_ID>
      ```

      Where:
      * `--service`: Service name you obtained at the previous step.
      * `--resource-id`: [Resource](../resource-manager/concepts/resources-hierarchy.md) ID, i.e., organization, cloud, or billing account ID.
      * `--resource-type`: Resource type, `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Example command**

      {% include [get-quota-service-cli](../_includes/quota-manager/get-quota-service-cli.md) %}

      {% include [get-quota-service-cli-output](../_includes/quota-manager/get-quota-service-cli-output.md) %}

  1. **View value and usage info for a particular quota.**

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

      **Example command**

      {% include [get-quota-info-cli](../_includes/quota-manager/get-quota-info-cli.md) %}

      {% include [get-quota-info-cli-output](../_includes/quota-manager/get-quota-info-cli-output.md) %}

- REST API {#api}

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
      * `<quota_ID>`: Quota ID. You can look up the ID in [{#T}](all-quotas.md).
      * `<resource_ID>`: ID of the resource (organization, cloud, or billing account).
      * `<resource_type>`: Resource type, either `resource-manager.cloud`, `organization-manager.organization`, or `billing.account`.

      **Request example**

      {% include [get-quota-info](../_includes/quota-manager/get-quota-info.md) %}

      **Response example**

      {% include [get-quota-info-response-curl](../_includes/quota-manager/get-quota-info-response-curl.md) %}

- gRPC API {#grpc-api}

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
      * `<quota_ID>`: Quota ID. You can look up the ID in [{#T}](all-quotas.md).

      **Request example**

      {% include [get-quota-info-grpc](../_includes/quota-manager/get-quota-info-grpc.md) %}

      **Response example**

      {% include [get-quota-info-response-grpc](../_includes/quota-manager/get-quota-info-response-grpc.md) %}

{% endlist %}

## Requesting quota changes {#request-quota-change}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [request-quota](../_includes/quota-manager/request-quota.md) %}

- CLI {#cli}

  1. **Create a quota update request.**

      {% include [request-quota-cli](../_includes/quota-manager/request-quota-cli.md) %}

      **Example command**

      {% include [request-quota-change-cli](../_includes/quota-manager/request-quota-change-cli.md) %}

      {% include [request-quota-change-legend2](../_includes/quota-manager/request-quota-change-legend2.md) %}

      **Response example**

      {% include [request-quota-change-cli-response](../_includes/quota-manager/request-quota-change-cli-response.md) %}

  1. **View the list of quota update requests.**

      {% include [list-quota-requests-cli](../_includes/quota-manager/list-quota-requests-cli.md) %}
      
      **Example command**

      {% include [list-quota-requests-cli-example](../_includes/quota-manager/list-quota-requests-cli-example.md) %}

      **Response example**

      {% include [list-quota-requests-cli-response](../_includes/quota-manager/list-quota-requests-cli-response.md) %}

  1. **View the status of your quota update request.**

      {% include [get-quota-request-cli](../_includes/quota-manager/get-quota-request-cli.md) %}

      **Response example**

      {% include [get-quota-request-cli-response](../_includes/quota-manager/get-quota-request-cli-response.md) %}

- REST API {#api}

  1. **Create a quota update request.**

      [View the quota ID](all-quotas.md) and use the [Create](api-ref/QuotaRequest/create.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/index.md) resource:

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

  1. **Create a quota update request.**

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
