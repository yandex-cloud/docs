[Документация Yandex Cloud](../index.md) > [Yandex Cloud Quota Manager](index.md) > Примеры запросов

# Примеры запросов для работы с квотами

{% note info %}

Для работы с запросами на изменение квот через CLI и API обратитесь в [службу поддержки](https://center.yandex.cloud/support).

{% endnote %}

Чтобы гарантировать наличие критически важных для вашего сервиса ресурсов, проверяйте потребление квот и запрашивайте их увеличение в автоматическом режиме. Для этого можно использовать CLI или API Yandex Cloud Quota Manager.

## Перед началом работы {#before-you-begin}

Чтобы воспользоваться примерами:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Убедитесь, что у пользователя или сервисного аккаунта, аутентифицированного в профиле CLI, есть следующие [роли](../iam/concepts/access-control/roles.md):

      * для получения информации о квотах: [quota-manager.viewer](security/index.md#quota-manager-viewer) или выше;
      * для создания запросов на изменение квот:
      
          * на уровне [организации](../resource-manager/concepts/resources-hierarchy.md#cloud) — [quota-manager.requestOperator](security/index.md#quota-manager-requestoperator) или выше и [organization-manager.viewer](../organization/security/index.md#organization-manager-viewer) или выше;
          * на уровне облака — [resource-manager.viewer](../resource-manager/security/index.md#resource-manager-viewer) или выше.

- REST API {#api}

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роли](../iam/concepts/access-control/roles.md):

      * для получения информации о квотах: [quota-manager.viewer](security/index.md#quota-manager-viewer) или выше;
      * для создания запросов на изменение квот:
      
          * на уровне [организации](../resource-manager/concepts/resources-hierarchy.md#cloud) — [quota-manager.requestOperator](security/index.md#quota-manager-requestoperator) или выше и [organization-manager.viewer](../organization/security/index.md#organization-manager-viewer) или выше;
          * на уровне облака — [resource-manager.viewer](../resource-manager/security/index.md#resource-manager-viewer) или выше.

  1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.

- gRPC API {#grpc-api}

  1. Установите утилиту [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роли](../iam/concepts/access-control/roles.md):

      * для получения информации о квотах: [quota-manager.viewer](security/index.md#quota-manager-viewer) или выше;
      * для создания запросов на изменение квот:
      
          * на уровне [организации](../resource-manager/concepts/resources-hierarchy.md#cloud) — [quota-manager.requestOperator](security/index.md#quota-manager-requestoperator) или выше и [organization-manager.viewer](../organization/security/index.md#organization-manager-viewer) или выше;
          * на уровне облака — [resource-manager.viewer](../resource-manager/security/index.md#resource-manager-viewer) или выше.

  1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.

{% endlist %}

Ниже приведены примеры запросов и ответов CLI и API для работы с квотами. В примерах используются следующие параметры:

{% list tabs group=instructions %}

- CLI {#cli}

  * `--quota-id` — идентификатор квоты. В примерах используется идентификатор `iam.accessKeys.count` — количество статических ключей доступа в одном облаке, [квота в сервисе Identity and Access Management](../iam/concepts/limits.md).
  * `--resource-id` — идентификатор ресурса. В примерах используется идентификатор облака. Для выполнения запросов из примеров укажите [идентификатор](../resource-manager/operations/cloud/get-id.md) вашего облака.
  * `--resource-type` — тип ресурса. В примере используется `resource-manager.cloud` — облако.
  * `--filter` — фильтрующее выражение. Отфильтровать запросы можно только по их статусу.
  * `<идентификатор_запроса>` — идентификатор вашего запроса на изменение квоты.

- API {#api}

  * `<IAM-токен>` или `${IAM_TOKEN?}` — [IAM-токен](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
  * `uuidgen -t` — команда для генерации уникального идентификатора запроса (UUID), который передается в заголовке `X-Request-Id`. Передавать UUID необязательно, но он помогает отслеживать конкретный запрос в системе.
  * `quotaId` — идентификатор квоты. В примерах используется идентификатор `iam.accessKeys.count` — количество статических ключей доступа в одном облаке, [квота в сервисе Identity and Access Management](../iam/concepts/limits.md).
  * `resourceId` — идентификатор ресурса. В примерах используется идентификатор облака. Для выполнения запросов из примеров укажите [идентификатор](../resource-manager/operations/cloud/get-id.md) вашего облака.
  * `resourceType` — тип ресурса. В примере используется `resource-manager.cloud` — облако.
  * `<идентификатор_запроса>` — идентификатор вашего запроса на изменение квоты.

{% endlist %}

## Посмотреть идентификатор квоты {#get-quota-id}

Узнать идентификатор определенной квоты можно в разделе [Квоты для сервисов Yandex Cloud](all-quotas.md).

## Посмотреть значение и потребление квоты {#get-quota-info}

Чтобы посмотреть значение и потребление квоты:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc quota-manager quota-limit get \
    --quota-id iam.accessKeys.count \
    --resource-id <идентификатор_облака> \
    --resource-type resource-manager.cloud
  ```

  Будут выведены значение и потребление квоты для количества статических ключей доступа в облаке:
  
  ```bash
  quota_id: iam.accessKeys.count
  limit: 1000
  usage: 27
  ```
  
  Где:
  * `limit` — значение квоты;
  * `usage` — потребление квоты.

- REST API {#api}

  Воспользуйтесь методом REST API [Get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md).

  **Пример запроса**

  ```bash
  curl \
    --request GET \
    --header "X-Request-Id: $(uuidgen -t)" \
    --header "Authorization: Bearer ${IAM_TOKEN?}" \
    'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/iam.accessKeys.count?resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud'
  ```

  **Пример ответа**

  ```json
  {
    "quotaId": "iam.accessKeys.count",
    "limit": 1000,
    "usage": 34
  }
  ```

- gRPC API {#grpc-api}

  Воспользуйтесь вызовом gRPC API [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md).

  **Пример запроса**

  ```bash
  grpcurl \
    -H "X-Request-Id: $(uuidgen -t)" \
    -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -d "{ \"resource\": { \"id\": \"<идентификатор_облака>\", \"type\": \"resource-manager.cloud\" }, \"quota_id\": \"iam.accessKeys.count\"}" \
    quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaLimitService/Get
  ```

  **Пример ответа**

  ```json
  {
    "quotaId": "iam.accessKeys.count",
    "limit": 1000,
    "usage": 34
  }
  ```

{% endlist %}

## Посмотреть значение и потребление всех квот сервиса {#get-quota-service}

Чтобы посмотреть значение и потребление всех квот сервиса:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:
  
  ```bash
  yc quota-manager quota-limit list \
    --service iam \
    --resource-type resource-manager.cloud \
    --resource-id <идентификатор_облака>
  ```

  Будут выведены идентификаторы квот, которые есть в сервисе IAM в облаке, а также значения и потребление этих квот:
  
  ```text
  resource:
    id: b1gia87mbaom********
    type: resource-manager.cloud
  quota_limits:
    - quota_id: iam.accessKeys.count
      limit: 1001
      usage: 33
    - quota_id: iam.apiKeys.count
      limit: 1000
      usage: 14
    - quota_id: iam.authorizedKeys.count
      limit: 1000
      usage: 44
    ...
  ```

- REST API {#api}

  Воспользуйтесь методом REST API [List](api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md).

  **Пример запроса**

  ```bash
  curl \
    --request GET \
    --header "X-Request-Id: $(uuidgen -t)" \
    --header "Authorization: Bearer ${IAM_TOKEN?}" \
    'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits?service=iam&resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud'
  ```

  **Пример ответа**

  ```json
  {
    "resource": {
      "id": "b1gia87mbaom********",
      "type": "resource-manager.cloud"
    },
    "quotaLimits": [
      {
        "quotaId": "iam.accessKeys.count",
        "limit": 1000,
        "usage": 34
      },
      {
        "quotaId": "iam.apiKeys.count",
        "limit": 1000,
        "usage": 13
      },
      {
        "quotaId": "iam.authorizedKeys.count",
        "limit": 1000,
        "usage": 43
      },
      ...
    ]
  }
  ```

- gRPC API {#grpc-api}

  Воспользуйтесь вызовом gRPC API [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md).

  **Пример запроса**

  ```bash
  grpcurl \
    -H "X-Request-Id: $(uuidgen -t)" \
    -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -d "{ \"resource\": { \"id\": \"<идентификатор_облака>\", \"type\": \"resource-manager.cloud\" }, \"service\": \"iam\"}" \
    quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaLimitService/List
  ```

  **Пример ответа**

  ```json
  {
    "resource": {
      "id": "b1gia87mbaom********",
      "type": "resource-manager.cloud"
    },
    "quotaLimits": [
      {
        "quotaId": "iam.accessKeys.count",
        "limit": 1000,
        "usage": 34
      },
      {
        "quotaId": "iam.apiKeys.count",
        "limit": 1000,
        "usage": 13
      },
      {
        "quotaId": "iam.authorizedKeys.count",
        "limit": 1000,
        "usage": 43
      },
      ...
    ]
  }
  ```

{% endlist %}

## Запросить изменение квоты {#request-quota-change}

Чтобы запросить изменение квоты, создайте запрос и укажите идентификаторы квот ресурсов и новое значение.

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc quota-manager quota-request create \
    --resource-id <идентификатор_облака> \
    --resource-type resource-manager.cloud \
    --desired-limit quota-id=compute.placementGroups.count,value=5 \
    --desired-limit quota-id=storage.buckets.count,value=30
  ```

  Будет создан запрос на увеличение квот:
  * В сервисе Compute Cloud — количество групп размещения ВМ (`compute.placementGroups.count`), новое значение — `5`.
  * В сервисе Object Storage — количество бакетов (`storage.buckets.count`), новое значение — `30`.

  **Пример ответа**

  ```bash
  id: atdogfioseaq********
  resource:
    id: b1gia87mbaom********
    type: resource-manager.cloud
  created_at: "2025-09-11T08:24:24.142277Z"
  status: PENDING
  quota_limits:
    - quota_id: compute.placementGroups.count
      desired_limit: 5
      status: PROCESSING
    - quota_id: storage.buckets.count
      desired_limit: 30
      status: REJECTED
      message: значение квоты, которое вы запрашиваете, равно тому значению, которое уже используется
  created_by: ajegtlf2q28a********
  ```

- REST API {#api}

  Воспользуйтесь методом REST API [Create](api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md).

  **Пример запроса**

  ```bash
  curl \
    --request POST \
    --header "X-Request-Id: $(uuidgen -t)" \
    --header "Authorization: Bearer ${IAM_TOKEN?}" \
    --data '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "desired_quota_limits": [{"quota_id": "iam.accessKeys.count", "desired_limit": "1001"}]}' \
    'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests'
  ```
  
  **Пример ответа**

  ```json
  {
    "done": false,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata",
      "quotaRequestId": "atdogfioseaq********"
    },
    "id": "atdlsk0hjt6r********",
    "description": "Create quota request",
    "createdAt": "2025-09-01T08:39:37.195600077Z",
    "createdBy": "ajegtlf2q28a********",
    "modifiedAt": "2025-09-01T08:39:37.195600077Z"
  }
  ```
  
  Статус операции `false` означает, что запрос находится на рассмотрении.

- gRPC API {#grpc-api}

  Воспользуйтесь вызовом gRPC API [QuotaRequestService/Create](api-ref/grpc/QuotaRequest/create.md).

  **Пример запроса**

  ```bash
  grpcurl \
    -H "X-Request-Id: $(uuidgen -t)" \
    -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -d "{\"resource\": {\"id\": \"<идентификатор_облака>\", \"type\": \"resource-manager.cloud\"}, \"desired_quota_limits\": [{\"quota_id\": \"iam.accessKeys.count\", \"desired_limit\": \"1001\"}]}" \
    quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Create
  ```
  
  **Пример ответа**

  ```json
  {
    "id": "atdhrm4k26ar********",
    "description": "Create quota request",
    "createdAt": "2025-09-01T08:46:28.116514197Z",
    "createdBy": "ajegtlf2q28a********",
    "modifiedAt": "2025-09-01T08:46:28.116514197Z",
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.quotamanager.v1.CreateQuotaRequestMetadata",
      "quotaRequestId": "atdp0kd3799e********"
    }
  }
  ```

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

Чтобы посмотреть список запросов на изменение квот:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc quota-manager quota-request list \
    --resource-id <идентификатор_облака> \
    --resource-type resource-manager.cloud \
    --limit 1
  ```

  **Пример ответа**

  ```bash
  quota_requests:
    - id: atdogfioseaq********
      resource:
        id: b1gia87mbaom********
        type: resource-manager.cloud
      created_at: "2025-09-11T08:24:24.142277Z"
      status: PENDING
      quota_limits:
        - quota_id: storage.buckets.count
          desired_limit: 30
          status: REJECTED
          message: значение квоты, которое вы запрашиваете, равно тому значению, которое уже используется
        - quota_id: compute.placementGroups.count
          desired_limit: 5
          status: PROCESSING
      created_by: ajegtlf2q28a********
  ```

- REST API {#api}

  Воспользуйтесь методом REST API [List](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md).

  **Пример запроса**

  ```bash
  curl \
    --request GET \
    --header "X-Request-Id: $(uuidgen -t)" \
    --header "Authorization: Bearer ${IAM_TOKEN?}" \
    'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests?page_size=100&resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud'
  ```

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
        "status": "PROCESSING",
        "createdBy": "ajegtlf2q28a********"
      },
      ...
    ]
  }
  ```

- gRPC API {#grpc-api}

  Воспользуйтесь вызовом gRPC API [QuotaRequestService/List](api-ref/grpc/QuotaRequest/list.md).

  **Пример запроса**

  ```bash
  grpcurl \
    -H "X-Request-Id: $(uuidgen -t)" \
    -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -d "{\"resource\": {\"id\": \"<идентификатор_облака>\", \"type\": \"resource-manager.cloud\"}}" \
    quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/List
  ```

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
        "status": "PROCESSING",
        "quotaLimits": [
          {
            "quotaId": "iam.accessKeys.count",
            "desiredLimit": 1001,
            "status": "PROCESSING"
          }
        ],
        "createdBy": "ajegtlf2q28a********"
      },
      ...
    ]
  }
  ```

{% endlist %}

## Посмотреть статус запроса на изменение квоты {#view-request-status}

Чтобы посмотреть статус запроса на изменение квоты:

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc quota-manager quota-request get \
    --id <идентификатор_запроса>
  ```

  **Пример ответа**

  ```bash
  id: atdogfioseaq********
  resource:
    id: b1gia87mbaom********
    type: resource-manager.cloud
  created_at: "2025-09-11T08:24:24.142277Z"
  status: PENDING
  quota_limits:
    - quota_id: compute.placementGroups.count
      desired_limit: 5
      status: PROCESSING
    - quota_id: storage.buckets.count
      desired_limit: 30
      status: REJECTED
      message: значение квоты, которое вы запрашиваете, равно тому значению, которое уже используется
  created_by: ajegtlf2q28a********
  ```

- REST API {#api}

  Воспользуйтесь методом REST API [Get](api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md). В запросе передайте идентификатор запроса на изменение квоты, информацию о котором вы хотите посмотреть.

  **Пример запроса**

  ```bash
  curl \
    --request GET \
    --header "X-Request-Id: $(uuidgen -t)" \
    --header "Authorization: Bearer ${IAM_TOKEN?}" \
    'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests/<идентификатор_запроса>'
  ```

  **Пример ответа (запрос в ожидании)**

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
        "status": "PROCESSING"
      }
    ],
    "id": "atdp0kd3799e********",
    "createdAt": "2025-09-01T08:46:28.091109Z",
    "status": "PENDING",
    "createdBy": "ajegtlf2q28a********"
  }
  ```

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

  ```bash
  grpcurl \
    -H "X-Request-Id: $(uuidgen -t)" \
    -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -d "{\"quota_request_id\": \"<идентификатор_запроса>\"}" \
    quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
  ```

  **Пример ответа (запрос в ожидании)**

  ```json
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
  }
  ```

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

  Воспользуйтесь методом REST API [List](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md) с параметром `filter`. Отфильтровать запросы можно только по их статусу.

  **Пример запроса**

  ```bash
  curl \
    --request GET \
    --header "X-Request-Id: $(uuidgen -t)" \
    --header "Authorization: Bearer ${IAM_TOKEN?}" \
    'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests?page_size=1&resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud&filter=status%20in%20(%27CANCELED%27%2C%20%27PENDING%27)&page_size=100'
  ```
  
  Фильтр выбирает запросы, которые были отменены (`CANCELED`) или находятся в ожидании (`PENDING`).

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

  ```bash
  grpcurl \
    -H "X-Request-Id: $(uuidgen -t)" \
    -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -d "{\"resource\": {\"id\": \"<идентификатор_облака>\", \"type\": \"resource-manager.cloud\"}, \"filter\": \"status in ('CANCELED', 'PENDING')\"}" \
    quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/List
  ```
  
  Фильтр выбирает запросы, которые были отменены (`CANCELED`) или находятся в ожидании (`PENDING`).

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

  Воспользуйтесь методом REST API [Cancel](api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md). В запросе передайте идентификатор запроса на изменение квоты, который вы хотите отменить.

  **Пример запроса**

  ```bash
  curl \
    --request POST \
    --header "X-Request-Id: $(uuidgen -t)" \
    --header "Authorization: Bearer ${IAM_TOKEN?}" \
    --data "{\"quota_ids\": [ \"iam.accessKeys.count\" ]}" \
    'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests/<идентификатор_запроса>/cancel'
  ```

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

  ```bash
  grpcurl \
    -H "X-Request-Id: $(uuidgen -t)" \
    -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -d "{ \"quota_request_id\": \"<идентификатор_запроса>\", \"quota_ids\": [ \"iam.accessKeys.count\" ]}" \
    quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Cancel
  ```

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

  Воспользуйтесь методом REST API [ListOperations](api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md). В запросе передайте идентификатор запроса на изменение квоты, список операций с которым вы хотите посмотреть.

  **Пример запроса**

  ```bash
  curl \
    --request GET \
    --header "X-Request-Id: $(uuidgen -t)" \
    --header "Authorization: Bearer ${IAM_TOKEN?}" \
    'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests/<идентификатор_запроса>/operations'
  ```

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

  ```bash
  grpcurl \
    -H "X-Request-Id: $(uuidgen -t)" \
    -H "Authorization: Bearer ${IAM_TOKEN?}" \
    -d "{ \"quota_request_id\": \"<идентификатор_запроса>\"}" \
    quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/ListOperations
  ```

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