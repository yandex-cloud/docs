---
title: Examples of requests to {{ quota-manager-full-name }}
description: This article provides examples of {{ quota-manager-name }} API requests for quota management.
---

# Examples of requests for quota management

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

To ensure your service always has critical resources available, monitor quota usage and request automatic quota increase. You can do this by using the {{ quota-manager-full-name }} API.

## Configuring API operations {#api-configure}

{% include [quota-api-start](../_includes/quota-manager/quota-api-start.md) %}

Below are examples of API requests and responses for quota management. The examples use the following values:

* `<IAM_token>` or `${IAM_TOKEN?}`: Service account's [IAM token](../iam/operations/iam-token/create-for-sa.md) or the environment variable containing the token.
* `uuidgen -t`: Command for generating a request UUID to provide in the `X-Request-Id` header. Providing a UUID is optional, but it helps tracking a particular request in the system.
* `<quotaId>`: Quota ID. The examples use the `iam.accessKeys.count` ID representing the number of static access keys per cloud, an [{{ iam-name }} quota](../iam/concepts/limits.md).
* `<requestId>`: Quota update request ID. The examples use `atd1sftc071****` as this ID.
* `<resourceId>`: Resource ID. The examples use the `b1gflhy********` cloud ID. Specify your cloud ID to test this example.
* `<resourceType>`: Resource type. The example uses `resource-manager.cloud`, i.e. cloud.
    
## Viewing quota ID {#get-quota-id}

To learn a particular quota's ID, see [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default) in the quota table of the relevant service.

## Viewing quota value and usage info {#get-quota-info}

Use the [get](api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [get-quota-info](../_includes/quota-manager/get-quota-info.md) %}

  **Response example**

   ```json
   {
     "quotaId": "iam.accessKeys.count",
     "limit": "1000",
     "usage": "789"
   }
   ```

{% endlist %}

## Viewing value and usage info for all quotas of the service {#get-quota-service}

Use the [list](api-ref/QuotaLimit/list.md) REST API method for the [QuotaLimit](api-ref/QuotaLimit/) resource or the [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [get-quota-service](../_includes/quota-manager/get-quota-service.md) %}

  **Response example**

   ```json
   {
    "resource": {
      "id": "b1gflhy********",
      "type": "resource-manager.cloud"
    },
    "quotaLimits": [
      {
        "quotaId": "iam.accessKeys.count",
        "limit": "1000",
        "usage": "789"
      }
      {
        "quotaId": "iam.apiKeys.count",
        "limit": "1000",
        "usage": "456"
      }
      {
        "quotaId": "iam.authorizedKeys.count",
        "limit": "1000",
        "usage": "123"
      }
      ...
    ],
  }
  ```
{% endlist %}

## Requesting quota updates {#request-quota-change}

To create a quota update request, use the [Create](api-ref/QuotaRequest/create.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequest/create](api-ref/grpc/QuotaRequest/create.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [request-quota-change](../_includes/quota-manager/request-quota-change.md) %}
  
  **Response example**

  ```json
  {
   "done": false,
   "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata",
    "quotaRequestId": "atd1sftc071****"
   },
   "id": "atd2n7s5cj6****",
   "description": "Create quota request",
   "createdAt": "2025-07-09T16:18:27.981870605Z",
   "createdBy": "aje9dat65****",
   "modifiedAt": "2025-07-09T16:18:27.981870605Z"
  }
  ```

  The `false` operation status means your request is under review. 

{% endlist %}

## Viewing a list of quota update requests {#list-quota-requests}

Use the [List](api-ref/QuotaRequest/list.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequest/List](api-ref/grpc/QuotaRequest/list.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [list-quota-requests](../_includes/quota-manager/list-quota-requests.md) %}

  **Response example**
  
  ```json
  {
    "quotaRequests": [
      {
      "resource": {
        "id": "b1gflhy********",
        "type": "resource-manager.cloud"
      },
      "quotaLimits": [
        {
        "quotaId": "iam.accessKeys.count",
        "desiredLimit": 100000,
        "approvedLimit": 100000,
        "status": "APPROVED"
        }
      ],
      "id": "atd2n7s5cj6****",
      "createdAt": "2025-07-23T15:44:32.902051Z",
      "status": "PROCESSED",
      "createdBy": "aje9dat65****"
      }
    ],
    "nextPageToken": "CLaylIPLvub6****"
  }
  ```

{% endlist %}

## Viewing the status of a quota update request {#view-request-status}

Use the [Get](api-ref/QuotaRequest/get.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequest/Get](api-ref/grpc/QuotaRequest/get.md) gRPC API call.

{% list tabs group=instructions %}

- REST API {#api}

  **Request example**

  {% include [list-quota-requests](../_includes/quota-manager/view-request-status.md) %}

  **Response example (request pending)**
  
  ```json
  {
    "id": "atd1sftc0****",
    "resource": {
      "id": "b1gflhy********",
      "type": "resource-manager.cloud"
    },
    "createdAt": "2025-07-09T12:45:50.492111Z",
    "status": "PENDING",
    "quotaLimits": [
      {
        "quotaId": "iam.accessKeys.count",
        "desiredLimit": 1e+05,
        "status": "PROCESSING"
      }
    ],
    "createdBy": "aje9dat65****"
  }
  ```

  **Response example (request canceled)**

  ```json
  {
   "resource": {
    "id": "b1gflhy********",
    "type": "resource-manager.cloud"
   },
   "quotaLimits": [
    {
     "quotaId": "iam.accessKeys.count",
     "desiredLimit": 100000,
     "status": "CANCELED",
     "modifiedBy": "aje9dat65****"
    }
   ],
   "id": "atduqtlmi****",
   "createdAt": "2025-07-09T16:18:27.942852Z",
   "status": "CANCELED",
   "createdBy": "aje9dat65****"
  }
  ```

{% endlist %}

## Viewing a list of requests filtered by status {#filter-list-quota-requests}

Use the [List](api-ref/QuotaRequest/list.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequest/List](api-ref/grpc/QuotaRequest/list.md) gRPC API call with the `filter` parameter. You can filter requests only by status.

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
      "id": "b1gflhy********",
      "type": "resource-manager.cloud"
     },
     "quotaLimits": [
      {
       "quotaId": "iam.accessKeys.count",
       "desiredLimit": 100000,
       "status": "CANCELED",
       "modifiedBy": "aje9dat65****"
      }
     ],
     "id": "atduqtlmi0qfrbm3nul6",
     "createdAt": "2025-07-09T16:18:27.942852Z",
     "status": "CANCELED",
     "createdBy": "aje9dat65****"
    },
    {
     "resource": {
      "id": "b1gflhy********",
      "type": "resource-manager.cloud"
     },
     "quotaLimits": [
      {
       "quotaId": "iam.accessKeys.count",
       "desiredLimit": 100000,
       "status": "CANCELED",
       "modifiedBy": "aje9dat65****"
      }
     ],
     "id": "atd1sftc071cdf5camdc",
     "createdAt": "2025-07-09T12:45:50.492111Z",
     "status": "CANCELED",
     "createdBy": "aje9dat65****"
    }
   ],
   "nextPageToken": "CLaylIPLvubuah****"
  }
  ```

{% endlist %}

## Canceling a quota update request {#cancel-quota-request}

Use the [Cancel](api-ref/QuotaRequest/cancel.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequest/cancel](api-ref/grpc/QuotaRequest/cancel.md) gRPC API call.

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
    "quotaRequestId": "atd1sftc071****"
   },
   "id": "atddc5nvi8****",
   "description": "Cancel quota request",
   "createdAt": "2025-07-09T16:28:12.397453440Z",
   "createdBy": "aje9dat65****",
   "modifiedAt": "2025-07-09T16:28:12.397453440Z"
  }
  ```

{% endlist %}

## Viewing a list of operations for a quota update request {#list-operation-request}

Use the [ListOperations](api-ref/QuotaRequest/listOperations.md) REST API method for the [QuotaRequest](api-ref/QuotaRequest/) resource or the [QuotaRequest/ListOperations](api-ref/grpc/QuotaRequest/listOperations.md) gRPC API call.

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
      "quotaRequestId": "atd1sftc071****"
     },
     "response": {
      "@type": "type.googleapis.com/google.protobuf.Empty"
     },
     "id": "atddc5nvi****",
     "description": "Cancel quota request",
     "createdAt": "2025-07-09T16:28:12.397Z",
     "createdBy": "aje9dat65****",
     "modifiedAt": "2025-07-09T16:28:18.398855343Z"
    },
    {
     "done": true,
     "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata",
      "quotaRequestId": "atd1sftc071****"
     },
     "response": {
      "@type": "type.googleapis.com/google.protobuf.Empty"
     },
     "id": "atd2n7s5c****",
     "description": "Create quota request",
     "createdAt": "2025-07-09T16:18:27.981Z",
     "createdBy": "aje9dat65****",
     "modifiedAt": "2025-07-09T16:18:41.302404535Z"
    }
   ]
  }
  ```
{% endlist %}