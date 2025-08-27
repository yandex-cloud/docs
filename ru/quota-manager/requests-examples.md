---
title: Примеры запросов к {{ quota-manager-full-name }}
description: В этой статье собраны примеры запросов к API {{ quota-manager-name }} для работы с квотами.
---

# Примеры запросов для работы с квотами

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

Чтобы гарантировать наличие критически важных для вашего сервиса ресурсов, проверяйте потребление квот и запрашивайте их увеличение в автоматическом режиме. Для этого можно использовать API {{ quota-manager-full-name }}.

## Настроить работу с API {#api-configure}

{% include [quota-api-start](../_includes/quota-manager/quota-api-start.md) %}

Ниже приведены примеры запросов и ответов API для работы с квотами. В примерах используются следующие значения:

* `<IAM-токен>` или `${IAM_TOKEN?}` — [IAM-токен](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
* `uuidgen -t` — команда для генерации уникального идентификатора запроса (UUID), который передается в заголовке `X-Request-Id`. Передавать UUID необязательно, но он помогает отслеживать конкретный запрос в системе.
* `<quotaId>` — идентификатор квоты. В примерах используется идентификатор `iam.accessKeys.count` — количество статических ключей доступа в одном облаке, [квота в сервисе {{ iam-name }}](../iam/concepts/limits.md).
* `<requestId>` — идентификатор запроса на изменение квоты. В примерах используется идентификатор `atd1sftc071****`.
* `<resourceId>` — идентификатор ресурса. В примерах используется идентификатор облака `b1gflhy********`. Для проверки примера укажите идентификатор вашего облака.
* `<resourceType>` — тип ресурса. В примере используется `resource-manager.cloud` — облако.
    
## Посмотреть идентификатор квоты {#get-quota-id}

Узнать идентификатор определенной квоты можно в разделе [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default) в таблице с квотами нужного сервиса.

## Посмотреть значение и потребление квоты {#get-quota-info}

Воспользуйтесь методом REST API [get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md).

{% list tabs group=instructions %}

- REST API {#api}

  **Пример запроса**

  {% include [get-quota-info](../_includes/quota-manager/get-quota-info.md) %}

  **Пример ответа**

   ```json
   {
     "quotaId": "iam.accessKeys.count",
     "limit": "1000",
     "usage": "789"
   }
   ```

{% endlist %}

## Посмотреть значение и потребление всех квот сервиса {#get-quota-service}

Воспользуйтесь методом REST API [list](api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md).

{% list tabs group=instructions %}

- REST API {#api}

  **Пример запроса**

  {% include [get-quota-service](../_includes/quota-manager/get-quota-service.md) %}

  **Пример ответа**

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

## Запросить изменение квоты {#request-quota-change}

Чтобы создать запрос на изменение квоты, воспользуйтесь методом REST API [Create](api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/create](api-ref/grpc/QuotaRequest/create.md).

{% list tabs group=instructions %}

- REST API {#api}

  **Пример запроса**

  {% include [request-quota-change](../_includes/quota-manager/request-quota-change.md) %}
  
  **Пример ответа**

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

  Статус операции `false` означает, что запрос находится на рассмотрении. 

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

Воспользуйтесь методом REST API [List](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/List](api-ref/grpc/QuotaRequest/list.md).

{% list tabs group=instructions %}

- REST API {#api}

  **Пример запроса**

  {% include [list-quota-requests](../_includes/quota-manager/list-quota-requests.md) %}

  **Пример ответа**
  
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

## Посмотреть статус запроса на изменение квоты {#view-request-status}

Воспользуйтесь методом REST API [Get](api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/Get](api-ref/grpc/QuotaRequest/get.md).

{% list tabs group=instructions %}

- REST API {#api}

  **Пример запроса**

  {% include [list-quota-requests](../_includes/quota-manager/view-request-status.md) %}

  **Пример ответа (запрос в ожидании)**
  
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

  **Пример ответа (запрос отменен)**

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

## Посмотреть список запросов с фильтром по статусу {#filter-list-quota-requests}

Воспользуйтесь методом REST API [List](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/List](api-ref/grpc/QuotaRequest/list.md) с параметром `filter`. Отфильтровать запросы можно только по их статусу.

{% list tabs group=instructions %}

- REST API {#api}

  **Пример запроса**

  {% include [filter-list-quota-requests](../_includes/quota-manager/filter-list-quota-requests.md) %}

  **Пример ответа**
  
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

## Отменить запрос на изменение квоты {#cancel-quota-request}

Воспользуйтесь методом REST API [Cancel](api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/cancel](api-ref/grpc/QuotaRequest/cancel.md).

{% list tabs group=instructions %}

- REST API {#api}

  **Пример запроса**

  {% include [cancel-quota-request](../_includes/quota-manager/cancel-quota-request.md) %}

  **Пример ответа**
  
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

## Посмотреть список операций с запросом на изменение квоты {#list-operation-request}

Воспользуйтесь методом REST API [ListOperations](api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/ListOperations](api-ref/grpc/QuotaRequest/listOperations.md).

{% list tabs group=instructions %}

- REST API {#api}

  **Пример запроса**

  {% include [list-operation-request](../_includes/quota-manager/list-operation-request.md) %}

  **Пример ответа**
  
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