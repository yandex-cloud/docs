---
title: Как начать работать с {{ quota-manager-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть квоты для ваших сервисов.
---

# Как начать работать с {{ quota-manager-full-name }}

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

Сервис {{ quota-manager-name }} позволяет управлять квотами ваших сервисов {{ yandex-cloud }} с помощью различных интерфейсов. Некоторые сервисы, например {{ speechkit-name }} и {{ video-full-name }}, в {{ quota-manager-name }} недоступны.

**Квоты** — ограничения на количество ресурсов, которые вы используете в облаке. Это организационные ограничения, их можно изменять по мере необходимости.

При работе с квотами используются понятия:

* **Значение квоты** или просто **квота** (quota limit) — текущее ограничение на ресурс для облака или организации.

* **Потребление квоты** (quota usage) — объем или величина фактически используемого ресурса.

Потенциально квоты можно увеличить до _лимитов_.

**Лимиты** — технические ограничения, обусловленные особенностями архитектуры {{ yandex-cloud }}, физическими характеристиками оборудования или внешними ограничениями.

![image](../_assets/quota-manager/quotas-limits.svg)

Для работы с квотами доступны интерфейсы: 

* [Консоль]({{ link-console-quotas }}) и [API](api-ref/authentication.md) — получение информации и запрос на изменение квот.
* [CLI](cli-ref/) — получение информации о квотах, позднее появится возможность создавать запросы на изменение квот.

Управление квотами через CLI и API выполняется по идентификатору квоты. Список идентификаторов см. в разделе [{#T}](../overview/concepts/quotas-limits.md).

## Получить информацию о квотах {#get-quota-info}

Для просмотра квот требуется [роль](../iam/operations/roles/grant.md) `quota-manager.viewer`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако, в котором хотите посмотреть квоты.
  1. Выберите вкладку **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
     
     На странице отобразится список сервисов, которые используются в вашем облаке.
  
  1. Раскройте раздел сервиса и посмотрите значения в столбце **{{ ui-key.yacloud.iam.cloud.quotas.column_usage }}**:
  
     * Два числа — `потребление квоты / значение квоты`. Например, `2 / 20` или `1.203 / 5120 ГБ`.

     * Одно число — `лимит`, изменить его нельзя.

  1. Чтобы оценить потребление ресурсов, вверху справа в списке выберите:
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-warning }}** — ресурсы, которые потребляют более половины установленной квоты.
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-error }}** — ресурсы, которые почти израсходованы.

- CLI {#cli}

  1. **Настройте работу с CLI.**

      {% include [cli-install](../_includes/cli-install.md) %}

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. **Посмотрите список сервисов с квотами.**
  
      ```bash
      yc quota-manager quota-limit list-services --resource-type=<тип_ресурса>
      ```

      Где `--resource-type` — [тип ресурса](concepts/index.md#resources-types): 
      * `resource-manager.cloud` — облако; 
      * `organization-manager.organization` — организация; 
      * `billing.account` — платежный аккаунт.

      **Пример команды**

      ```bash
      yc quota-manager quota-limit list-services --resource-type=resource-manager.cloud
      ```

      Будет выведен список сервисов, которые находятся на уровне облака и для которых есть квоты.

  1. **Посмотрите значения и потребление всех квот для сервиса.**
  
      ```bash
      yc quota-manager quota-limit list \
         --service=<имя_сервиса> \
         --resource-type=<тип_ресурса> \
         --resource-id=<идентификатор_ресурса>
      ```

      Где:
      * `--service` — имя сервиса, полученное на предыдущем шаге.
      * `--resource-id` — идентификатор [ресурса](../resource-manager/concepts/resources-hierarchy.md): идентификатор облака, организации или платежного аккаунта.
      * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

      **Пример команды**

      ```bash
      yc quota-manager quota-limit list --service=iam --resource-type=resource-manager.cloud --resource-id=b1gflhy********
      ``` 

      Будут выведены идентификаторы квот, которые есть в сервисе {{ iam-short-name }} в облаке `b1gflhy********`, а также значения и потребление этих квот.

  1. **Посмотрите значение и потребление определенной квоты.**
  
      ```bash
      yc quota-manager quota-limit get \
         --quota-id=<идентификатор_квоты> \
         --resource-id <идентификатор_ресурса> \
         --resource-type <тип_ресурса>
      ```

      Где:
      * `--quota-id` — идентификатор квоты. Узнать идентификатор можно в разделе [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default).
      * `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

      **Пример команды**

      ```bash
      yc quota-manager quota-limit get --quota-id=iam.apiKeys.count --resource-id=b1gflhy********  --resource-type=resource-manager.cloud
      ```

      Будут выведены значение и потребление квоты для количества API-ключей в облаке `b1gflhy********`:

      ```bash
      quota_id: iam.apiKeys.count
      limit: 1000
      usage: 27
      ```

      Где:
      * `limit` — значение квоты;
      * `usage` — потребление квоты.

- API {#api}

  1. **Настройте работу с API.**

      {% include [quota-api-start](../_includes/quota-manager/quota-api-start.md) %}
  
  1. **Посмотрите список сервисов, для которых есть квоты.**
  
      Воспользуйтесь методом REST API [listServices](api-ref/QuotaLimit/listServices.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/ListServices](api-ref/grpc/QuotaLimit/listServices.md).

      Чтобы проверить работу метода REST API, выполните запрос:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM-токен>" \
      "https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/services?resourceType=<resourceType>"
      ```

      Где:

      * `<resourceType>` — [тип ресурса](concepts/index.md#resources-types): `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.

      **Пример запроса**

      ```bash
      curl -X GET \
      --header "Authorization: Bearer ${IAM_TOKEN?}" \
      'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/services?resourceType=resource-manager.cloud'
      ```

  1. **Посмотрите значения и потребление всех квот для сервиса.**
  
      Воспользуйтесь методом REST API [list](api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md).

      Чтобы проверить работу метода REST API, выполните запрос:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM-токен>" \
      "https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits?service=<serviceName>&resource.id=<resourceId>&resource.type=<resourceType>"
      ```

      Где:

      * `<resourceId>` — идентификатор ресурса: облака, организации или платежного аккаунта.
      * `<resourceType>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`.
      * `<serviceName>` — имя сервиса, полученное на предыдущем шаге.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
         
      **Пример запроса**

      {% include [get-quota-service](../_includes/quota-manager/get-quota-service.md) %}

  1. **Посмотрите значение и потребление определенной квоты.**
  
      Воспользуйтесь методом REST API [get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md).

      Чтобы проверить работу метода REST API, выполните запрос:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM-токен>" \
      "https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/<quotaId>?resource.id=<resourceId>&resource.type=<resourceType>"
      ```

      Где:

      * `<quotaId>` — идентификатор квоты. Узнать идентификатор можно в разделе [{#T}](../overview/concepts/quotas-limits.md#quotas-limits-default).
      * `<resourceId>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<resourceType>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
         
      **Пример запроса**

      {% include [get-quota-info](../_includes/quota-manager/get-quota-info.md) %}

{% endlist %}

## Запросить изменение квот {#request-quota-change}

{% include [request-quota-restriction](../_includes/quota-manager/request-quota-restriction.md) %}

{% include [request-quota-roles](../_includes/quota-manager/request-quota-roles.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [request-quota](../_includes/quota-manager/request-quota.md) %}

- REST API {#api}

  1. **Создайте запрос на изменение квоты.**

      [Посмотрите идентификатор квоты](../overview/concepts/quotas-limits#quotas-limits-default) и воспользуйтесь методом REST API [Create](api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/):

      ```bash
      curl -X POST \
      --header "Authorization: Bearer <IAM-токен>" \
      --data '{"resource": {"id": "<resourceId>", "type": "<resourceType>"}, "desired_quota_limits": [{"quota_id": "<quotaId>", "desired_limit": "<новое_значение_квоты>"}]}' \
      'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests'
      ```

      Где:

      * `<quotaId>` — идентификатор квоты, которую нужно изменить.
      * `<resourceId>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<resourceType>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
         
      **Пример запроса**

      {% include [request-quota-change](../_includes/quota-manager/request-quota-change.md) %}
   
   1. **Посмотрите список запросов на изменение квот.**

      Воспользуйтесь методом REST API [List](api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/):

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM-токен>" \
      'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests?page_size=<размер_страницы>&resource.id=<resourceId>&resource.type=<resourceType>'
      ```

      Где:

      * `<resourceId>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<resourceType>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<размер_страницы>` — количество элементов на одной странице.
         
      **Пример запроса**

      {% include [list-quota-requests](../_includes/quota-manager/list-quota-requests.md) %}

   1. **Посмотрите статус запроса на изменение квоты.**

      Воспользуйтесь методом REST API [Get](api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/):

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM-токен>" \
      'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests/<requestId>'
      ```

      Где `<requestId>` — идентификатор запроса, полученный на предыдущем шаге.

      **Пример запроса**

      {% include [list-quota-requests](../_includes/quota-manager/view-request-status.md) %}

- gRPC API {#grpc-api}

  1. **Создайте запрос на изменение квоты.**

      [Посмотрите идентификатор квоты](../overview/concepts/quotas-limits#quotas-limits-default) и создайте запрос с помощью вызова gRPC API [QuotaRequest/create](api-ref/grpc/QuotaRequest/create.md):

      ```bash
      grpcurl \
      -H "Authorization: Bearer <IAM-токен>" \
      -d '{"resource": {"id": "<resourceId>", "type": "<resourceType>"}, "desired_quota_limits": [{"quota_id": "<quotaId>", "desired_limit": "<новое_значение_квоты>"}]}' \
      {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Create
      ```

      Где:

      * `<quotaId>` — идентификатор квоты, которую нужно изменить.
      * `<resourceId>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<resourceType>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
         
      **Пример запроса**

      ```bash
      grpcurl \
      -H "Authorization: Bearer ${IAM_TOKEN?}" \
      -d '{"resource": {"id": "b1gflhy********", "type": "resource-manager.cloud"}, "desired_quota_limits": [{"quota_id": "iam.accessKeys.count", "desired_limit": "100000"}]}' \
      {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Create
      ```
   
  1. **Посмотрите список запросов на изменение квот.**

      Воспользуйтесь вызовом gRPC API [QuotaRequest/List](api-ref/grpc/QuotaRequest/list.md):

      ```bash
      grpcurl -X GET \
      -H "Authorization: Bearer <IAM-токен>" \
      -d '{"resource": {"id": "<resourceId>", "type": "<resourceType>"}}'  \
      {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/List
      ```

      Где:

      * `<resourceId>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<resourceType>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      * `<размер_страницы>` — количество элементов на одной странице.
         
      **Пример запроса**

      ```bash
      grpcurl -X GET \
      -H "Authorization: Bearer ${IAM_TOKEN?}" \
      -d '{"resource": {"id": "b1gflhy********", "type": "resource-manager.cloud"}}'  \
      {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/List
      ```

  1. **Посмотрите статус запроса на изменение квоты.**

      Воспользуйтесь вызовом gRPC API [QuotaRequest/Get](api-ref/grpc/QuotaRequest/get.md):

      ```bash
      grpcurl -X GET \
      -H "Authorization: Bearer <IAM-токен>" \
      -d '{"quota_request_id":"<requestId>"}' \
      {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
      ```

      Где `<requestId>` — идентификатор запроса, полученный на предыдущем шаге.

      **Пример запроса**

      ```bash
      grpcurl -X GET \
      -H "Authorization: Bearer ${IAM_TOKEN?}" \
      -d '{"quota_request_id":"atd1sftc071****"}' \
      {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
      ```

{% endlist %}
