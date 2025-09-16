---
title: Примеры запросов к {{ quota-manager-full-name }}
description: В этой статье собраны примеры запросов к API {{ quota-manager-name }} для работы с квотами.
---

# Примеры запросов для работы с квотами

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

Чтобы гарантировать наличие критически важных для вашего сервиса ресурсов, проверяйте потребление квот и запрашивайте их увеличение в автоматическом режиме. Для этого можно использовать CLI или API {{ quota-manager-full-name }}.

## Перед началом работы {#before-you-begin}

Чтобы воспользоваться примерами:

{% list tabs group=instructions %}

- CLI {#cli}

  1. {% include [cli-install](../_includes/cli-install.md) %}

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. Убедитесь, что у пользователя или сервисного аккаунта, аутентифицированного в профиле CLI, есть следующие [роли](../iam/concepts/access-control/roles.md):

      {% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

- REST API {#api}

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роли](../iam/concepts/access-control/roles.md):

      {% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

  1. {% include [before-begin-api-get-iam-token](../_includes/quota-manager/before-begin-api-get-iam-token.md) %}

- gRPC API {#grpc-api}

  1. Установите утилиту [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роли](../iam/concepts/access-control/roles.md):

      {% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

  1. {% include [before-begin-api-get-iam-token](../_includes/quota-manager/before-begin-api-get-iam-token.md) %}

{% endlist %}

Ниже приведены примеры запросов и ответов CLI и API для работы с квотами. В примерах используются следующие параметры:

{% list tabs group=instructions %}

- CLI {#cli}

  * `--quota-id` — идентификатор квоты. В примерах используется идентификатор `iam.accessKeys.count` — количество статических ключей доступа в одном облаке, [квота в сервисе {{ iam-name }}](../iam/concepts/limits.md).
  * `--resource-id` — идентификатор ресурса. В примерах используется идентификатор облака. Для выполнения запросов из примеров укажите [идентификатор](../resource-manager/operations/cloud/get-id.md) вашего облака.
  * `--resource-type` — тип ресурса. В примере используется `resource-manager.cloud` — облако.
  * `--filter` — фильтрующее выражение. Отфильтровать запросы можно только по их статусу.
  * `<идентификатор_запроса>` — идентификатор вашего запроса на изменение квоты.

- API {#api}

  * `<IAM-токен>` или `${IAM_TOKEN?}` — [IAM-токен](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
  * `uuidgen -t` — команда для генерации уникального идентификатора запроса (UUID), который передается в заголовке `X-Request-Id`. Передавать UUID необязательно, но он помогает отслеживать конкретный запрос в системе.
  * `quotaId` — идентификатор квоты. В примерах используется идентификатор `iam.accessKeys.count` — количество статических ключей доступа в одном облаке, [квота в сервисе {{ iam-name }}](../iam/concepts/limits.md).
  * `resourceId` — идентификатор ресурса. В примерах используется идентификатор облака. Для выполнения запросов из примеров укажите [идентификатор](../resource-manager/operations/cloud/get-id.md) вашего облака.
  * `resourceType` — тип ресурса. В примере используется `resource-manager.cloud` — облако.
  * `<идентификатор_запроса>` — идентификатор вашего запроса на изменение квоты.

{% endlist %}

## Посмотреть идентификатор квоты {#get-quota-id}

Узнать идентификатор определенной квоты можно в разделе [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default) в таблице с квотами нужного сервиса.

## Посмотреть значение и потребление квоты {#get-quota-info}

Чтобы посмотреть значение и потребление квоты:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  {% include [get-quota-info-cli](../_includes/quota-manager/get-quota-info-cli.md) %}

  {% include [get-quota-info-cli-output](../_includes/quota-manager/get-quota-info-cli-output.md) %}

- REST API {#api}

  Воспользуйтесь методом REST API [Get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/).

  **Пример запроса**

  {% include [get-quota-info](../_includes/quota-manager/get-quota-info.md) %}

  **Пример ответа**

  {% include [get-quota-info-response-curl](../_includes/quota-manager/get-quota-info-response-curl.md) %}

- gRPC API {#grpc-api}

  Воспользуйтесь вызовом gRPC API [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md).

  **Пример запроса**

  {% include [get-quota-info-grpc](../_includes/quota-manager/get-quota-info-grpc.md) %}

  **Пример ответа**

  {% include [get-quota-info-response-grpc](../_includes/quota-manager/get-quota-info-response-grpc.md) %}

{% endlist %}

## Посмотреть значение и потребление всех квот сервиса {#get-quota-service}

Чтобы посмотреть значение и потребление всех квот сервиса:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:
  
  {% include [get-quota-service-cli](../_includes/quota-manager/get-quota-service-cli.md) %}

  {% include [get-quota-service-cli-output](../_includes/quota-manager/get-quota-service-cli-output.md) %}

- REST API {#api}

  Воспользуйтесь методом REST API [List](api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/).

  **Пример запроса**

  {% include [get-quota-service](../_includes/quota-manager/get-quota-service.md) %}

  **Пример ответа**

  {% include [get-quota-service-response-curl](../_includes/quota-manager/get-quota-service-response-curl.md) %}

- gRPC API {#grpc-api}

  Воспользуйтесь вызовом gRPC API [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md).

  **Пример запроса**

  {% include [get-quota-service-grpc](../_includes/quota-manager/get-quota-service-grpc.md) %}

  **Пример ответа**

  {% include [get-quota-service-response-grpc](../_includes/quota-manager/get-quota-service-response-grpc.md) %}

{% endlist %}

## Запросить изменение квоты {#request-quota-change}

Чтобы запросить изменение квоты, создайте запрос и укажите идентификаторы квот ресурсов и новое значение.

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  {% include [request-quota-change-cli](../_includes/quota-manager/request-quota-change-cli.md) %}

  {% include [request-quota-change-legend2](../_includes/quota-manager/request-quota-change-legend2.md) %}

  **Пример ответа**

  {% include [request-quota-change-cli-response](../_includes/quota-manager/request-quota-change-cli-response.md) %}

- REST API {#api}

  Воспользуйтесь методом REST API [Create](api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/).

  **Пример запроса**

  {% include [request-quota-change](../_includes/quota-manager/request-quota-change.md) %}
  
  **Пример ответа**

  {% include [request-quota-change-response-curl](../_includes/quota-manager/request-quota-change-response-curl.md) %}

- gRPC API {#grpc-api}

  Воспользуйтесь вызовом gRPC API [QuotaRequestService/Create](api-ref/grpc/QuotaRequest/create.md).

  **Пример запроса**

  {% include [request-quota-change-grpc](../_includes/quota-manager/request-quota-change-grpc.md) %}
  
  **Пример ответа**

  {% include [request-quota-change-response-grpc](../_includes/quota-manager/request-quota-change-response-grpc.md) %}

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

Чтобы посмотреть список запросов на изменение квот:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  {% include [list-quota-requests-cli-example](../_includes/quota-manager/list-quota-requests-cli-example.md) %}

  **Пример ответа**

  {% include [list-quota-requests-cli-response](../_includes/quota-manager/list-quota-requests-cli-response.md) %}

- REST API {#api}

  Воспользуйтесь методом REST API [List](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/).

  **Пример запроса**

  {% include [list-quota-requests](../_includes/quota-manager/list-quota-requests.md) %}

  **Пример ответа**

  {% include [list-quota-requests-response-curl](../_includes/quota-manager/list-quota-requests-response-curl.md) %}

- gRPC API {#grpc-api}

  Воспользуйтесь вызовом gRPC API [QuotaRequestService/List](api-ref/grpc/QuotaRequest/list.md).

  **Пример запроса**

  {% include [list-quota-requests-grpc](../_includes/quota-manager/list-quota-requests-grpc.md) %}

  **Пример ответа**

  {% include [list-quota-requests-response-grpc](../_includes/quota-manager/list-quota-requests-response-grpc.md) %}

{% endlist %}

## Посмотреть статус запроса на изменение квоты {#view-request-status}

Чтобы посмотреть статус запроса на изменение квоты:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  {% include [get-quota-request-cli-example](../_includes/quota-manager/get-quota-request-cli-example.md) %}

  **Пример ответа**

  {% include [get-quota-request-cli-response](../_includes/quota-manager/get-quota-request-cli-response.md) %}

- REST API {#api}

  Воспользуйтесь методом REST API [Get](api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/). В запросе передайте идентификатор запроса на изменение квоты, информацию о котором вы хотите посмотреть.

  **Пример запроса**

  {% include [list-quota-requests](../_includes/quota-manager/view-request-status.md) %}

  **Пример ответа (запрос в ожидании)**

  {% include [view-request-status-response-curl](../_includes/quota-manager/view-request-status-response-curl.md) %}

  **Пример ответа (запрос отменен)**

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

  Воспользуйтесь вызовом gRPC API [QuotaRequestService/Get](api-ref/grpc/QuotaRequest/get.md). В запросе передайте идентификатор запроса на изменение квоты, информацию о котором вы хотите посмотреть.

  **Пример запроса**

  {% include [view-request-status-grpc](../_includes/quota-manager/view-request-status-grpc.md) %}

  **Пример ответа (запрос в ожидании)**

  {% include [view-request-status-response-grpc](../_includes/quota-manager/view-request-status-response-grpc.md) %}

  **Пример ответа (запрос отменен)**

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

## Посмотреть список запросов с фильтром по статусу {#filter-list-quota-requests}

Чтобы посмотреть список запросов с фильтром по статусу:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc quota-manager quota-request list \
    --resource-type resource-manager.cloud \
    --resource-id <идентификатор_облака> \
    --filter "status in ('CANCELED','PENDING')"
  ```

  В примере фильтр выбирает запросы, которые были отменены (`CANCELED`) или находятся в ожидании (`PENDING`).

  **Пример ответа**

  ```text
  quota_requests:
    - id: atdusk8qi57o********
      resource:
        id: b1gia87mbaom********
        type: resource-manager.cloud
      created_at: "2025-09-15T15:13:46.928383Z"
      status: PENDING
      quota_limits:
        - quota_id: iam.accessKeys.count
          desired_limit: 1015
          status: PROCESSING
      created_by: ajeol2afu1js********
    - id: atdb761kojdb********
      resource:
        id: b1gia87mbaom********
        type: resource-manager.cloud
      created_at: "2025-09-01T19:40:03.838651Z"
      status: CANCELED
      quota_limits:
        - quota_id: iam.accessKeys.count
          desired_limit: 1040
          status: CANCELED
          modified_by: ajegtlf2q28a********
      created_by: ajegtlf2q28a********
    - id: atd2od8goloa********
      resource:
        id: b1gia87mbaom********
        type: resource-manager.cloud
      created_at: "2025-09-01T19:26:47.312728Z"
      status: CANCELED
      quota_limits:
        - quota_id: iam.accessKeys.count
          desired_limit: 1030
          status: CANCELED
          modified_by: ajegtlf2q28a********
      created_by: ajegtlf2q28a********
    ...
  ```

- REST API {#api}

  Воспользуйтесь методом REST API [List](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/) с параметром `filter`. Отфильтровать запросы можно только по их статусу.

  **Пример запроса**

  {% include [filter-list-quota-requests](../_includes/quota-manager/filter-list-quota-requests.md) %}

  **Пример ответа**
  
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

  Воспользуйтесь вызовом gRPC API [QuotaRequestService/List](api-ref/grpc/QuotaRequest/list.md) с параметром `filter`. Отфильтровать запросы можно только по их статусу.

  **Пример запроса**

  {% include [filter-list-quota-requests-grpc](../_includes/quota-manager/filter-list-quota-requests-grpc.md) %}

  **Пример ответа**
  
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

## Отменить запрос на изменение квоты {#cancel-quota-request}

Чтобы отменить запрос на изменение квоты:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc quota-manager quota-request cancel \
    --id <идентификатор_запроса> \
    --quota-id iam.accessKeys.count
  ```

  **Пример ответа**

  ```text
  id: atdusk8qi57o********
  resource:
    id: b1gia87mbaom********
    type: resource-manager.cloud
  created_at: "2025-09-15T15:13:46.928383Z"
  status: CANCELED
  quota_limits:
    - quota_id: iam.accessKeys.count
      desired_limit: 1015
      status: CANCELED
      modified_by: ajeol2afu1js********
  created_by: ajeol2afu1js********
  ```

- REST API {#api}

  Воспользуйтесь методом REST API [Cancel](api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/). В запросе передайте идентификатор запроса на изменение квоты, который вы хотите отменить.

  **Пример запроса**

  {% include [cancel-quota-request](../_includes/quota-manager/cancel-quota-request.md) %}

  **Пример ответа**
  
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

  Воспользуйтесь вызовом gRPC API [QuotaRequestService/Cancel](api-ref/grpc/QuotaRequest/cancel.md). В запросе передайте идентификатор запроса на изменение квоты, который вы хотите отменить.

  **Пример запроса**

  {% include [cancel-quota-request-grpc](../_includes/quota-manager/cancel-quota-request-grpc.md) %}

  **Пример ответа**
  
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

## Посмотреть список операций с запросом на изменение квоты {#list-operation-request}

Чтобы посмотреть список операций с запросом на изменение квоты:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc quota-manager quota-request list-operations \
    --id <идентификатор_запроса>
  ```

  **Пример ответа**

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |     DESCRIPTION      |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------+
  | atds4r7oishc******** | 2025-09-15 15:23:07 | ajeol2afu1js******** | 2025-09-15 15:23:14 | DONE   | Cancel quota request |
  | atdg006longe******** | 2025-09-15 15:13:46 | ajeol2afu1js******** | 2025-09-15 15:14:01 | DONE   | Create quota request |
  +----------------------+---------------------+----------------------+---------------------+--------+----------------------+
  ```

- REST API {#api}

  Воспользуйтесь методом REST API [ListOperations](api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/). В запросе передайте идентификатор запроса на изменение квоты, список операций с которым вы хотите посмотреть.

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

  Воспользуйтесь вызовом gRPC API [QuotaRequestService/ListOperations](api-ref/grpc/QuotaRequest/listOperations.md). В запросе передайте идентификатор запроса на изменение квоты, список операций с которым вы хотите посмотреть.

  **Пример запроса**

  {% include [list-operation-request-grpc](../_includes/quota-manager/list-operation-request-grpc.md) %}

  **Пример ответа**
  
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