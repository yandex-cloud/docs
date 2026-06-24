# Как начать работать с Yandex Cloud Quota Manager

{% note info %}

Для работы с запросами на изменение квот через CLI и API обратитесь в [службу поддержки](https://center.yandex.cloud/support).

{% endnote %}

Сервис Cloud Quota Manager позволяет управлять квотами ваших сервисов Yandex Cloud с помощью различных интерфейсов. Некоторые сервисы, например SpeechKit и Yandex Cloud Video, в Cloud Quota Manager недоступны.

**Квоты** — ограничения на количество ресурсов, которые вы используете в облаке. Это организационные ограничения, их можно изменять по мере необходимости.

При работе с квотами используются понятия:

* **Значение квоты** или просто **квота** (quota limit) — текущее ограничение на ресурс для облака или организации.

* **Потребление квоты** (quota usage) — объем или величина фактически используемого ресурса.

Потенциально квоты можно увеличить до _лимитов_.

**Лимиты** — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud, физическими характеристиками оборудования или внешними ограничениями.

![image](../_assets/quota-manager/quotas-limits.svg)

Для работы с квотами доступны интерфейсы: [консоль управления](https://console.yandex.cloud/cloud?section=quotas), [API](api-ref/authentication.md) и [CLI](cli-ref/index.md).

Управление квотами через CLI и API выполняется по идентификатору квоты. Список идентификаторов приведен в разделе [Квоты для сервисов Yandex Cloud](all-quotas.md).

## Перед началом работы {#before-you-begin}

Чтобы начать работать в Yandex Cloud:

1. Войдите в [консоль управления](https://console.yandex.cloud). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. В сервисе [Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. В зависимости от интерфейса, который вы будете использовать, выполните дополнительные действия:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      Убедитесь, что у пользователя есть следующие [роли](../iam/concepts/access-control/roles.md):

      * для получения информации о квотах: [quota-manager.viewer](security/index.md#quota-manager-viewer) или выше;
      * для создания запросов на изменение квот:
      
          * на уровне [организации](../resource-manager/concepts/resources-hierarchy.md#cloud) — [quota-manager.requestOperator](security/index.md#quota-manager-requestoperator) или выше и [organization-manager.viewer](../organization/security/index.md#organization-manager-viewer) или выше;
          * на уровне облака — [resource-manager.viewer](../resource-manager/security/index.md#resource-manager-viewer) или выше.

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

## Получить информацию о квотах {#get-quota-info}

Для просмотра квот требуется [роль](../iam/operations/roles/grant.md) `quota-manager.viewer`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите облако, в котором хотите посмотреть квоты.
  1. Выберите вкладку **Квоты**.

     На странице отобразится список сервисов, которые используются в вашем облаке.

  1. Раскройте раздел сервиса и посмотрите значения в столбце **Использование**:

     * Два числа — `потребление квоты / значение квоты`. Например, `2 / 20` или `1.203 / 5120 ГБ`.

     * Одно число — `лимит`, изменить его нельзя.

  1. Чтобы оценить потребление ресурсов, вверху справа в списке выберите:
     * **Активно используются** — ресурсы, которые потребляют более половины установленной квоты.
     * **Почти израсходованы** — ресурсы, которые почти израсходованы.

- CLI {#cli}

  1. **Посмотрите список сервисов с квотами.**

      ```bash
      yc quota-manager quota-limit list-services \
        --resource-type <тип_ресурса>
      ```

      Где `--resource-type` — [тип ресурса](concepts/index.md#resources-types): 
      * `resource-manager.cloud` — [облако](../resource-manager/concepts/resources-hierarchy.md#cloud); 
      * `organization-manager.organization` — [организация](../organization/concepts/organization.md); 
      * `billing.account` — [платежный аккаунт](../billing/concepts/billing-account.md).

      **Пример команды**

      ```bash
      yc quota-manager quota-limit list-services \
        --resource-type resource-manager.cloud
      ```

      Будет выведен список сервисов, которые находятся на уровне облака и для которых есть квоты.

  1. **Посмотрите значения и потребление всех квот для сервиса.**

      ```bash
      yc quota-manager quota-limit list \
         --service <имя_сервиса> \
         --resource-type <тип_ресурса> \
         --resource-id <идентификатор_ресурса>
      ```

      Где:
      * `--service` — имя сервиса, полученное на предыдущем шаге.
      * `--resource-id` — идентификатор [ресурса](../resource-manager/concepts/resources-hierarchy.md): идентификатор облака, организации или платежного аккаунта.
      * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

      **Пример команды**

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

  1. **Посмотрите значение и потребление определенной квоты.**

      ```bash
      yc quota-manager quota-limit get \
         --quota-id <идентификатор_квоты> \
         --resource-id <идентификатор_ресурса> \
         --resource-type <тип_ресурса>
      ```

      Где:
      * `--quota-id` — идентификатор квоты. Узнать идентификатор можно в разделе [Квоты для сервисов Yandex Cloud](all-quotas.md).
      * `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

      **Пример команды**

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

  1. **Посмотрите список сервисов, для которых есть квоты.**

      Воспользуйтесь методом REST API [ListServices](api-ref/QuotaLimit/listServices.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM-токен>" \
        "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/services?resourceType=<тип_ресурса>"
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<тип_ресурса>` — [тип ресурса](concepts/index.md#resources-types): `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

      **Пример запроса**

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer ${IAM_TOKEN?}" \
        'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/services?resourceType=resource-manager.cloud'
      ```

      **Пример ответа**

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

  1. **Посмотрите значения и потребление всех квот для сервиса.**

      Воспользуйтесь методом REST API [List](api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM-токен>" \
        "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits?service=<идентификатор_сервиса>&resource.id=<идентификатор_ресурса>&resource.type=<тип_ресурса>"
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_сервиса>` — идентификатор сервиса, полученный на предыдущем шаге.
      * `<идентификатор_ресурса>` — идентификатор ресурса: облака, организации или платежного аккаунта.
      * `<тип_ресурса>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

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

  1. **Посмотрите значение и потребление определенной квоты.**
  
      Воспользуйтесь методом REST API [Get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM-токен>" \
        "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/<идентификатор_квоты>?resource.id=<идентификатор_ресурса>&resource.type=<тип_ресурса>"
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_квоты>` — идентификатор квоты. Узнать идентификатор можно в разделе [Квоты для сервисов Yandex Cloud](all-quotas.md).
      * `<идентификатор_ресурса>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<тип_ресурса>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

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

  1. **Посмотрите список сервисов, для которых есть квоты.**

      Воспользуйтесь вызовом gRPC API [QuotaLimitService/ListServices](api-ref/grpc/QuotaLimit/listServices.md):

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM-токен>" \
        -d "{\"resource_type\": \"<тип_ресурса>\"}" \
        quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaLimitService/ListServices
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<тип_ресурса>` — [тип ресурса](concepts/index.md#resources-types): `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

      **Пример запроса**

      ```bash
      grpcurl \
        -H "Authorization: Bearer ${IAM_TOKEN?}" \
        -d "{\"resource_type\": \"resource-manager.cloud\"}" \
        quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaLimitService/ListServices
      ```

      **Пример ответа**

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

  1. **Посмотрите значения и потребление всех квот для сервиса.**

      Воспользуйтесь вызовом gRPC API [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md):

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM-токен>" \
        -d "{ \"resource\": { \"id\": \"<идентификатор_ресурса>\", \"type\": \"<тип_ресурса>\" }, \"service\": \"<идентификатор_сервиса>\"}" \
        quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaLimitService/List
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_ресурса>` — идентификатор ресурса: облака, организации или платежного аккаунта.
      * `<тип_ресурса>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<идентификатор_сервиса>` — идентификатор сервиса, полученный на предыдущем шаге.

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

  1. **Посмотрите значение и потребление определенной квоты.**

      Воспользуйтесь вызовом gRPC API [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md):

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM-токен>" \
        -d "{ \"resource\": { \"id\": \"<идентификатор_ресурса>\", \"type\": \"<тип_ресурса>\" }, \"quota_id\": \"<идентификатор_квоты>\"}" \
        quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaLimitService/Get
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_ресурса>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<тип_ресурса>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<идентификатор_квоты>` — идентификатор квоты. Узнать идентификатор можно в разделе [Квоты для сервисов Yandex Cloud](all-quotas.md).

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

## Запросить изменение квот {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Запросите изменение квоты одним из способов:
     * На [странице квот](https://console.yandex.cloud/cloud?section=quotas) выберите ресурсы и нажмите **Повысить**.
     * Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и опишите, какие потребляемые квоты нужно увеличить и на сколько.

- CLI {#cli}

  1. **Создайте запрос на изменение квоты.**

      [Посмотрите идентификатор квоты](../overview/concepts/quotas-limits.md#quotas-limits-default) и создайте запрос на ее изменение:
      
      ```bash
      yc quota-manager quota-request create \
        --resource-type <тип_ресурса> \
        --resource-id <идентификатор_ресурса> \
        --desired-limit quota-id=<идентификатор_квоты>,value=<новое_значение_квоты>
      ```
      
      Где:
      
      * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `--desired-limit` — данные для изменения квоты:
        * `quota-id` — идентификатор квоты.
        * `value` — новое значение, которое нужно присвоить квоте.
      
      В одном запросе можно указать несколько квот. Для этого добавьте несколько параметров `--desired-limit`.

      **Пример команды**

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

  1. **Посмотрите список запросов на изменение квот.**

      ```bash
      yc quota-manager quota-request list \
        --resource-type <тип_ресурса> \
        --resource-id <идентификатор_ресурса> \
        --limit <количество_запросов>
      ```
      
      Где:
      * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `--limit` — количество запросов на странице.
      
      **Пример команды**

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

  1. **Посмотрите статус запроса на изменение квоты.**

      ```bash
      yc quota-manager quota-request get \
        --id <идентификатор_запроса>
      ```
      
      Где `--id` — идентификатор запроса на изменение квоты.

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

  1. **Создайте запрос на изменение квоты.**

      [Посмотрите идентификатор квоты](all-quotas.md) и воспользуйтесь методом REST API [Create](api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md):

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer <IAM-токен>" \
        --data '{"resource": {"id": "<идентификатор_ресурса>", "type": "<тип_ресурса>"}, "desired_quota_limits": [{"quota_id": "<идентификатор_квоты>", "desired_limit": "<новое_значение_квоты>"}]}' \
        'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests'
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_ресурса>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<тип_ресурса>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<идентификатор_квоты>` — идентификатор квоты, которую нужно изменить.
      * `<новое_значение_квоты>` — новое значение, которое нужно присвоить выбранной квоте.

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

   1. **Посмотрите список запросов на изменение квот.**

      Воспользуйтесь методом REST API [List](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM-токен>" \
        'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests?page_size=<размер_страницы>&resource.id=<идентификатор_ресурса>&resource.type=<тип_ресурса>'
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<размер_страницы>` — количество элементов на одной странице.
      * `<идентификатор_ресурса>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<тип_ресурса>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

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

   1. **Посмотрите статус запроса на изменение квоты.**

      Воспользуйтесь методом REST API [Get](api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM-токен>" \
        'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests/<идентификатор_запроса>'
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_запроса>` — идентификатор запроса на изменение квоты, полученный на предыдущем шаге.

      **Пример запроса**

      ```bash
      curl \
        --request GET \
        --header "X-Request-Id: $(uuidgen -t)" \
        --header "Authorization: Bearer ${IAM_TOKEN?}" \
        'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests/<идентификатор_запроса>'
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

- gRPC API {#grpc-api}

  1. **Создайте запрос на изменение квоты.**

      [Посмотрите идентификатор квоты](all-quotas.md) и создайте запрос с помощью вызова gRPC API [QuotaRequestService/Create](api-ref/grpc/QuotaRequest/create.md):

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM-токен>" \
        -d "{\"resource\": {\"id\": \"<идентификатор_ресурса>\", \"type\": \"<тип_ресурса>\"}, \"desired_quota_limits\": [{\"quota_id\": \"<идентификатор_квоты>\", \"desired_limit\": \"<новое_значение_квоты>\"}]}" \
        quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Create
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_ресурса>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<тип_ресурса>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<идентификатор_квоты>` — идентификатор квоты, которую нужно изменить.
      * `<новое_значение_квоты>` — новое значение, которое нужно присвоить выбранной квоте.

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

  1. **Посмотрите список запросов на изменение квот.**

      Воспользуйтесь вызовом gRPC API [QuotaRequestService/List](api-ref/grpc/QuotaRequest/list.md):

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM-токен>" \
        -d "{\"resource\": {\"id\": \"<идентификатор_ресурса>\", \"type\": \"<тип_ресурса>\"}}" \
        quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/List
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_ресурса>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<тип_ресурса>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

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

  1. **Посмотрите статус запроса на изменение квоты.**

      Воспользуйтесь вызовом gRPC API [QuotaRequestService/Get](api-ref/grpc/QuotaRequest/get.md):

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM-токен>" \
        -d "{\"quota_request_id\": \"<идентификатор_запроса>\"}" \
        quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
      ```

      Где:

      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<идентификатор_запроса>` — идентификатор запроса на изменение квоты, полученный на предыдущем шаге.

      **Пример запроса**

      ```bash
      grpcurl \
        -H "X-Request-Id: $(uuidgen -t)" \
        -H "Authorization: Bearer ${IAM_TOKEN?}" \
        -d "{\"quota_request_id\": \"<идентификатор_запроса>\"}" \
        quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
      ```

      **Пример ответа**

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

{% endlist %}