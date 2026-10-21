[Документация Yandex Cloud](../index.md) > [Yandex Cloud Quota Manager](index.md) > Примеры запросов

# Примеры запросов для работы с квотами

{% note info %}

Для работы с запросами на изменение квот через CLI и API обратитесь в [службу поддержки](https://center.yandex.cloud/support).

{% endnote %}

Чтобы избежать исчерпания квот, отслеживайте их потребление и заранее запрашивайте увеличение. Автоматизировать эти действия можно с помощью CLI или API Yandex Cloud Quota Manager. Увеличение квот не гарантирует наличие свободных ресурсов.

## Перед началом работы {#before-you-begin}

Чтобы воспользоваться примерами, подготовьте выбранный интерфейс и назначьте роли на облако или организацию, к которым относятся квоты:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
      
      Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Убедитесь, что у пользователя или сервисного аккаунта, аутентифицированного в профиле CLI, есть [роль](../iam/concepts/access-control/roles.md) для нужной операции:

      * [quota-manager.viewer](security/index.md#quota-manager-viewer) — для просмотра квот.
      * [quota-manager.requestOperator](security/index.md#quota-manager-requestoperator) — для просмотра квот и создания запросов на их изменение.

- REST API {#api}

    1. Установите утилиту [cURL](https://curl.haxx.se).
    1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роль](../iam/concepts/access-control/roles.md) для нужной операции:

        * [quota-manager.viewer](security/index.md#quota-manager-viewer) — для просмотра квот.
        * [quota-manager.requestOperator](security/index.md#quota-manager-requestoperator) — для просмотра квот и создания запросов на их изменение.

    1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.
    1. Сохраните IAM-токен в переменной окружения:

       ```bash
       export IAM_TOKEN=<iam_токен>
       ```

- gRPC API {#grpc-api}

    1. Установите утилиту [gRPCurl](https://github.com/fullstorydev/grpcurl).
    1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роль](../iam/concepts/access-control/roles.md) для нужной операции:

        * [quota-manager.viewer](security/index.md#quota-manager-viewer) — для просмотра квот.
        * [quota-manager.requestOperator](security/index.md#quota-manager-requestoperator) — для просмотра квот и создания запросов на их изменение.

    1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.
    1. Сохраните IAM-токен в переменной окружения:

       ```bash
       export IAM_TOKEN=<iam_токен>
       ```

{% endlist %}

Ниже приведены примеры запросов и ответов CLI и API для работы с квотами. Длинные ответы приведены в сокращенном виде. В примерах используются следующие параметры:

{% list tabs group=instructions %}

- CLI {#cli}

  * `--quota-id` — идентификатор квоты. Например, `iam.accessKeys.count` — количество статических ключей доступа в одном облаке, [квота в сервисе Identity and Access Management](../iam/concepts/limits.md).
  * `--resource-id` — идентификатор ресурса. В примерах используется идентификатор облака. Для выполнения запросов из примеров укажите [идентификатор](../resource-manager/operations/cloud/get-id.md) вашего облака.
  * `--resource-type` ([тип ресурса](concepts/index.md#resources-types)) определяет уровень работы с квотами. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.
  * `--filter` — фильтрующее выражение. Отфильтровать запросы можно только по их статусу.
  * `<идентификатор_запроса>` — идентификатор вашего запроса на изменение квоты.

- API {#api}

    * `${IAM_TOKEN?}` — значение переменной окружения с [IAM-токеном](../iam/operations/iam-token/create-for-sa.md) сервисного аккаунта.
    * `uuidgen -t` — команда для генерации уникального идентификатора запроса (UUID), который передается в заголовке `X-Request-Id`. Передавать UUID необязательно, но он помогает отслеживать конкретный запрос в системе.
    * `quotaId` в REST API или `quota_id` в gRPC API — идентификатор квоты. В примерах используется идентификатор `iam.accessKeys.count` — количество статических ключей доступа в одном облаке, [квота в сервисе Identity and Access Management](../iam/concepts/limits.md).
    * `resource.id` — идентификатор ресурса. В примерах используется идентификатор облака. Для выполнения запросов из примеров укажите [идентификатор](../resource-manager/operations/cloud/get-id.md) вашего облака.
    * `resource.type` ([тип ресурса](concepts/index.md#resources-types)) определяет уровень работы с квотами. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.
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
  
  ```text
  quota_id: iam.accessKeys.count
  limit: 1000
  usage: 27
  ```
  
  Где:
  
  * `limit` — значение квоты;
  * `usage` — потребление квоты.

- REST API {#api}

    Воспользуйтесь методом REST API [get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md).

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

    Воспользуйтесь методом REST API [list](api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md).

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
        }
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
        }
      ]
    }
    ```

{% endlist %}

## Запросить изменение квоты {#request-quota-change}

Чтобы изменить квоты, создайте запрос: укажите идентификатор и тип ресурса, идентификаторы квот и желаемые итоговые значения. Для увеличения квоты запрашиваемое значение должно быть больше текущего.

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

  Будет создан запрос на изменение квот:
  
  * В сервисе Compute Cloud — количество групп размещения ВМ (`compute.placementGroups.count`), желаемое значение — `5`.
  * В сервисе Object Storage — количество бакетов (`storage.buckets.count`), желаемое значение — `30`.

  **Пример ответа**

  ```text
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

  Изменение каждой квоты рассматривается отдельно. В примере изменение `storage.buckets.count` отклонено, поскольку запрошенное значение уже установлено.

- REST API {#api}

    Воспользуйтесь методом REST API [create](api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md).

    **Пример запроса**

    ```bash
    curl \
      --request POST \
      --header "X-Request-Id: $(uuidgen -t)" \
      --header "Authorization: Bearer ${IAM_TOKEN?}" \
      --header "Content-Type: application/json" \
      --data '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "desiredQuotaLimits": [{"quotaId": "iam.accessKeys.count", "desiredLimit": "1001"}]}' \
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
    
    Значение `done: false` означает, что операция создания запроса еще не завершена. Чтобы узнать статус самого запроса, используйте его идентификатор из поля `metadata.quotaRequestId`.

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
    
    Чтобы узнать статус запроса на изменение квот, используйте его идентификатор из поля `metadata.quotaRequestId`. Поле `id` содержит идентификатор операции создания запроса.

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

  ```text
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

    Воспользуйтесь методом REST API [list](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md).

    **Пример запроса**

    ```bash
    curl \
      --request GET \
      --header "X-Request-Id: $(uuidgen -t)" \
      --header "Authorization: Bearer ${IAM_TOKEN?}" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests?pageSize=100&resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud'
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
        }
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
        }
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

  ```text
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

    Воспользуйтесь методом REST API [get](api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md). Передайте идентификатор запроса на изменение квоты.

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

    Воспользуйтесь вызовом gRPC API [QuotaRequestService/Get](api-ref/grpc/QuotaRequest/get.md). Передайте идентификатор запроса на изменение квоты.

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

    Воспользуйтесь методом REST API [list](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md) с параметром `filter`. Отфильтровать запросы можно только по их статусу.

    **Пример запроса**

    ```bash
    curl \
      --request GET \
      --header "X-Request-Id: $(uuidgen -t)" \
      --header "Authorization: Bearer ${IAM_TOKEN?}" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests?pageSize=100&resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud&filter=status%20in%20(%27CANCELED%27%2C%20%27PENDING%27)'
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
        }
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
        }
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

    Воспользуйтесь методом REST API [cancel](api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md). Передайте идентификатор запроса, а в поле `quotaIds` — идентификаторы квот, изменение которых хотите отменить.

    **Пример запроса**

    ```bash
    curl \
      --request POST \
      --header "X-Request-Id: $(uuidgen -t)" \
      --header "Authorization: Bearer ${IAM_TOKEN?}" \
      --header "Content-Type: application/json" \
      --data '{"quotaIds": ["iam.accessKeys.count"]}' \
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

    Воспользуйтесь вызовом gRPC API [QuotaRequestService/Cancel](api-ref/grpc/QuotaRequest/cancel.md). Передайте идентификатор запроса, а в поле `quota_ids` — идентификаторы квот, изменение которых хотите отменить.

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

    Воспользуйтесь методом REST API [listOperations](api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md). Передайте идентификатор запроса на изменение квоты.

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

    Воспользуйтесь вызовом gRPC API [QuotaRequestService/ListOperations](api-ref/grpc/QuotaRequest/listOperations.md). Передайте идентификатор запроса на изменение квоты.

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
            "@type": "type.googleapis.com/google.protobuf.Empty"
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
            "@type": "type.googleapis.com/google.protobuf.Empty"
          }
        }
      ]
    }
    ```

{% endlist %}