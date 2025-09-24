---
title: Examples of requests to {{ quota-manager-full-name }}
description: This article provides examples of {{ quota-manager-name }} API requests for quota management.
---

# Examples of requests for quota management

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

To ensure your service always has critical resources available, monitor quota usage and request automatic quota increase. You can do this by using the {{ quota-manager-full-name }} API.

## Configuring API operations {#api-configure}

1. To check that you can work with quotas via the API, install these utilities:

    * [cURL](https://curl.haxx.se) if using the [REST API](./api-ref/index.md).
    * [gRPCurl](https://github.com/fullstorydev/grpcurl) if using the [gRPC API](./api-ref/grpc/index.md).
1. [Create a service account](../iam/operations/sa/create.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) the following roles to it:
    * [quota-manager.viewer](./security/index.md#quota-manager-viewer): To view information about quotas (requests to the QuotaLimit resource).
    * At the [organization](../resource-manager/concepts/resources-hierarchy.md#cloud) level: [quota-manager.requestOperator](./security/index.md#quota-manager-requestoperator), [organization-manager.viewer](../organization/security/index.md#organization-manager-viewer). At the cloud level: [resource-manager.viewer](../resource-manager/security/index.md#resource-manager-viewer) (requests to the QuotaRequest resource).
1. [Get an IAM token](../iam/operations/iam-token/create-for-sa.md) for the created service account.

Below are examples of API requests and responses for quota management. The examples use the following values:

* `<IAM_token>` or `${IAM_TOKEN?}`: Service account's [IAM token](../iam/operations/iam-token/create-for-sa.md) or the environment variable containing the token.
* `uuidgen -t`: Command for generating a request UUID to provide in the `X-Request-Id` header. Providing a UUID is optional, but it helps tracking a particular request in the system.
* `quotaId`: Quota ID. The examples use the `iam.accessKeys.count` ID representing the number of static access keys per cloud, an [{{ iam-name }} quota](../iam/concepts/limits.md).
* `resourceId`: Resource ID. The examples use a cloud ID. To run requests from the examples, specify your cloud [ID](../resource-manager/operations/cloud/get-id.md).
* `resourceType`: Resource type. The example uses `resource-manager.cloud`, i.e., cloud.
* `<request_ID>`: ID of your quota update request.

## Viewing quota ID {#get-quota-id}

To learn a particular quota's ID, see [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default) in the quota table of the relevant service.

## Viewing quota value and usage info {#get-quota-info}

Use the [Get](api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [get-quota-info](../_includes/quota-manager/get-quota-info.md) %}

  **Response example**

  {% include [get-quota-info-response-curl](../_includes/quota-manager/get-quota-info-response-curl.md) %}

- gRPC API {#grpc-api}

  **Request example**

  {% include [get-quota-info-grpc](../_includes/quota-manager/get-quota-info-grpc.md) %}

  **Response example**

  {% include [get-quota-info-response-grpc](../_includes/quota-manager/get-quota-info-response-grpc.md) %}

{% endlist %}

## Viewing value and usage info for all quotas of the service {#get-quota-service}

Use the [List](api-ref/QuotaLimit/list.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [get-quota-service](../_includes/quota-manager/get-quota-service.md) %}

  **Response example**

  {% include [get-quota-service-response-curl](../_includes/quota-manager/get-quota-service-response-curl.md) %}

- gRPC API {#grpc-api}

  **Request example**

  {% include [get-quota-service-grpc](../_includes/quota-manager/get-quota-service-grpc.md) %}

  **Response example**

  {% include [get-quota-service-response-grpc](../_includes/quota-manager/get-quota-service-response-grpc.md) %}

{% endlist %}

## Requesting quota updates {#request-quota-change}

To create a quota update request, use the [Create](api-ref/QuotaRequest/create.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequestService/Create](api-ref/grpc/QuotaRequest/create.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [request-quota-change](../_includes/quota-manager/request-quota-change.md) %}
  
  **Response example**

  {% include [request-quota-change-response-curl](../_includes/quota-manager/request-quota-change-response-curl.md) %}

- gRPC API {#grpc-api}

  **Request example**

  {% include [request-quota-change-grpc](../_includes/quota-manager/request-quota-change-grpc.md) %}
  
  **Response example**

  {% include [request-quota-change-response-grpc](../_includes/quota-manager/request-quota-change-response-grpc.md) %}

{% endlist %}

## Viewing a list of quota update requests {#list-quota-requests}

Use the [List](api-ref/QuotaRequest/list.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequestService/List](api-ref/grpc/QuotaRequest/list.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [list-quota-requests](../_includes/quota-manager/list-quota-requests.md) %}

  **Response example**

  {% include [list-quota-requests-response-curl](../_includes/quota-manager/list-quota-requests-response-curl.md) %}

- gRPC API {#grpc-api}

  **Request example**

  {% include [list-quota-requests-grpc](../_includes/quota-manager/list-quota-requests-grpc.md) %}

  **Response example**

  {% include [list-quota-requests-response-grpc](../_includes/quota-manager/list-quota-requests-response-grpc.md) %}

{% endlist %}

## Viewing the status of a quota update request {#view-request-status}

Use the [Get](api-ref/QuotaRequest/get.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequestService/Get](api-ref/grpc/QuotaRequest/get.md) gRPC API call. In your request, provide the ID of the quota update request whose information you want to view.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [list-quota-requests](../_includes/quota-manager/view-request-status.md) %}

  **Response example (request pending)**

  {% include [view-request-status-response-curl](../_includes/quota-manager/view-request-status-response-curl.md) %}

  **Response example (request canceled)**

  ```json
  {
    "resource": {
      "id": "b1gia87mbaom********",
      "type": "resource-manager.cloud"
    },
    "quotaLimits": [
      {
        "quotaId": "iam.accessKeys.count",
        "desiredLimit": 1001,
        "status": "CANCELED",
        "modifiedBy": "ajeol2afu1js********"
      }
    ],
    "id": "atd67f3m9k92********",
    "createdAt": "2025-09-01T11:48:31.847524Z",
    "status": "CANCELED",
    "createdBy": "ajeol2afu1js********"
  }
  ```

- gRPC API {#grpc-api}

  **Request example**

  {% include [view-request-status-grpc](../_includes/quota-manager/view-request-status-grpc.md) %}

  **Response example (request pending)**

  {% include [view-request-status-response-grpc](../_includes/quota-manager/view-request-status-response-grpc.md) %}

  **Response example (request canceled)**

  ```json
  {
    "id": "atd67f3m9k92********",
    "resource": {
      "id": "b1gia87mbaom********",
      "type": "resource-manager.cloud"
    },
    "createdAt": "2025-09-01T11:48:31.847524Z",
    "status": "CANCELED",
    "quotaLimits": [
      {
        "quotaId": "iam.accessKeys.count",
        "desiredLimit": 1001,
        "status": "CANCELED",
        "modifiedBy": "ajeol2afu1js********"
      }
    ],
    "createdBy": "ajeol2afu1js********"
  }
  ```

{% endlist %}

## Viewing a list of requests filtered by status {#filter-list-quota-requests}

Use the [List](api-ref/QuotaRequest/list.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequestService/List](api-ref/grpc/QuotaRequest/list.md) gRPC API call with the `filter` parameter. You can filter requests only by status.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [filter-list-quota-requests](../_includes/quota-manager/filter-list-quota-requests.md) %}

  **Response example**
  
  ```json
  {
    "quotaRequests": [
      {
        "resource": {
          "id": "b1gia87mbaom********",
          "type": "resource-manager.cloud"
        },
        "quotaLimits": [
          {
            "quotaId": "iam.accessKeys.count",
            "desiredLimit": 1001,
            "status": "PROCESSING"
          }
        ],
        "id": "atdp0kd3799e********",
        "createdAt": "2025-09-01T08:46:28.091109Z",
        "status": "PENDING",
        "createdBy": "ajegtlf2q28a********"
      },
      {
        "resource": {
          "id": "b1gia87mbaom********",
          "type": "resource-manager.cloud"
        },
        "quotaLimits": [
          {
            "quotaId": "iam.accessKeys.count",
            "desiredLimit": 10000,
            "status": "CANCELED",
            "modifiedBy": "ajegtlf2q28a********"
          }
        ],
        "id": "atdg5kdelhfr********",
        "createdAt": "2025-08-25T15:30:03.773669Z",
        "status": "CANCELED",
        "createdBy": "ajegtlf2q28a********"
      },
      ...
    ]
  }
  ```

- gRPC API {#grpc-api}

  **Request example**

  {% include [filter-list-quota-requests-grpc](../_includes/quota-manager/filter-list-quota-requests-grpc.md) %}

  **Response example**
  
  ```json
  {
    "quotaRequests": [
      {
        "id": "atdp0kd3799e********",
        "resource": {
          "id": "b1gia87mbaom********",
          "type": "resource-manager.cloud"
        },
        "createdAt": "2025-09-01T08:46:28.091109Z",
        "status": "PENDING",
        "quotaLimits": [
          {
            "quotaId": "iam.accessKeys.count",
            "desiredLimit": 1001,
            "status": "PROCESSING"
          }
        ],
        "createdBy": "ajegtlf2q28a********"
      },
      {
        "id": "atd9im7tcr89********",
        "resource": {
          "id": "b1gia87mbaom********",
          "type": "resource-manager.cloud"
        },
        "createdAt": "2025-09-01T17:24:01.580902Z",
        "status": "CANCELED",
        "quotaLimits": [
          {
            "quotaId": "iam.accessKeys.count",
            "desiredLimit": 10000,
            "status": "CANCELED",
            "modifiedBy": "ajegtlf2q28a********"
          }
        ],
        "createdBy": "ajegtlf2q28a********"
      },
      ...
    ]
  }
  ```

{% endlist %}

## Canceling a quota update request {#cancel-quota-request}

Use the [Cancel](api-ref/QuotaRequest/cancel.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequestService/Cancel](api-ref/grpc/QuotaRequest/cancel.md) gRPC API call. In your request, provide the ID of the quota update request you want to cancel.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [cancel-quota-request](../_includes/quota-manager/cancel-quota-request.md) %}

  **Response example**
  
  ```json
  {
    "done": false,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CancelQuotaRequestMetadata",
      "quotaRequestId": "atdandtanku3********"
    },
    "id": "atdu5jt4dtve********",
    "description": "Cancel quota request",
    "createdAt": "2025-09-01T12:28:43.805955898Z",
    "createdBy": "ajeol2afu1js********",
    "modifiedAt": "2025-09-01T12:28:43.805955898Z"
  }
  ```

- gRPC API {#grpc-api}

  **Request example**

  {% include [cancel-quota-request-grpc](../_includes/quota-manager/cancel-quota-request-grpc.md) %}

  **Response example**
  
  ```json
  {
    "id": "atd6ervtiljj********",
    "description": "Cancel quota request",
    "createdAt": "2025-09-01T11:50:32.151491373Z",
    "createdBy": "ajeol2afu1js********",
    "modifiedAt": "2025-09-01T11:50:32.151491373Z",
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CancelQuotaRequestMetadata",
      "quotaRequestId": "atd67f3m9k92********"
    }
  }
  ```

{% endlist %}

## Viewing a list of operations for a quota update request {#list-operation-request}

Use the [ListOperations](api-ref/QuotaRequest/listOperations.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequestService/ListOperations](api-ref/grpc/QuotaRequest/listOperations.md) gRPC API call. In your request, provide the ID of the quota update request whose operations list you want to view.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [list-operation-request](../_includes/quota-manager/list-operation-request.md) %}

  **Response example**
  
  ```json
  {
    "operations": [
      {
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CancelQuotaRequestMetadata",
          "quotaRequestId": "atd67f3m9k92********"
        },
        "response": {
          "@type": "type.googleapis.com/google.protobuf.Empty"
        },
        "id": "atd6ervtiljj********",
        "description": "Cancel quota request",
        "createdAt": "2025-09-01T11:50:32.151Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2025-09-01T11:50:41.792964295Z"
      },
      {
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata",
          "quotaRequestId": "atd67f3m9k92********"
        },
        "response": {
          "@type": "type.googleapis.com/google.protobuf.Empty"
        },
        "id": "atdb3g33v9a9********",
        "description": "Create quota request",
        "createdAt": "2025-09-01T11:48:31.880Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2025-09-01T11:48:47.971065163Z"
      }
    ]
  }
  ```

- gRPC API {#grpc-api}

  **Request example**

  {% include [list-operation-request-grpc](../_includes/quota-manager/list-operation-request-grpc.md) %}

  **Response example**
  
  ```json
  {
    "operations": [
      {
        "id": "atd6ervtiljj********",
        "description": "Cancel quota request",
        "createdAt": "2025-09-01T11:50:32.151Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2025-09-01T11:50:41.792964295Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CancelQuotaRequestMetadata",
          "quotaRequestId": "atd67f3m9k92********"
        },
        "response": {
          "@type": "type.googleapis.com/google.protobuf.Empty",
          "value": {}
        }
      },
      {
        "id": "atdb3g33v9a9********",
        "description": "Create quota request",
        "createdAt": "2025-09-01T11:48:31.880Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2025-09-01T11:48:47.971065163Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata",
          "quotaRequestId": "atd67f3m9k92********"
        },
        "response": {
          "@type": "type.googleapis.com/google.protobuf.Empty",
          "value": {}
        }
      }
    ]
  }
  ```

{% endlist %}