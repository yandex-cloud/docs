---
title: Как начать работать с {{ quota-manager-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть квоты для ваших сервисов.
---

# Как начать работать с {{ quota-manager-full-name }}

{% include [preview-quota](../_includes/quota-manager/preview-quota.md) %}

{% include [about-quota](../_includes/quota-manager/about-quota.md) %}

Потенциально квоты можно увеличить до _лимитов_.

**Лимиты** — технические ограничения, обусловленные особенностями архитектуры {{ yandex-cloud }}, физическими характеристиками оборудования или внешними ограничениями.

Взаимосвязь квот и лимитов показана на схеме ниже.

![image](../_assets/quota-manager/quotas-limits.svg)

В настоящий момент для работы с квотами доступны интерфейсы: 

* [Консоль]({{ link-console-quotas }}) — получение информации и запрос на изменение квот.
* [CLI](api-ref/authentication.md) — получение информации о квотах.
* [API](api-ref/authentication.md) — получение информации о квотах.

Позднее появится возможность создавать запрос на изменение квот через CLI и API.

## Получить информацию о квотах

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

  **Настройте работу с CLI**

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}
  
   Для просмотра квот аккаунт должен иметь [роль](../iam/operations/roles/grant.md) `quota-manager.viewer`.

  **Посмотрите квоты**

  1. Посмотрите список сервисов, для которых есть квоты.
  
      ```bash
      yc quota-manager quota-limit list-services --resource-type=<тип_ресурса>
      ```

      Где `--resource-type` — [тип ресурса](concepts/index.md#resources-types): 
      * `resource-manager.cloud` — облако; 
      * `organization-manager.organization` — организация; 
      * `billing.account` — платежный аккаунт.

      Пример:

      ```bash
      yc quota-manager quota-limit list-services --resource-type=resource-manager.cloud
      ```

      Будет выведен список сервисов, которые находятся на уровне облака и для которых есть квоты.

  1. Посмотрите список квот для определенного сервиса, а также значение и потребление всех квот.
  
      ```bash
      yc quota-manager quota-limit list \
         --service=<название_сервиса> \
         --resource-type=<тип_ресурса> \
         --resource-id=<идентификатор_ресурса>
      ```

      Где:
       * `--service` — название сервиса, полученное на предыдущем шаге. Также название сервиса можно посмотреть в справочнике [YC CLI](../cli/cli-ref/).
       * `--resource-id` — идентификатор [ресурса](../resource-manager/concepts/resources-hierarchy.md): идентификатор облака, организации или платежного аккаунта.
       * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

      Пример:

      ```bash
      yc quota-manager quota-limit list --service=iam --resource-type=resource-manager.cloud --resource-id=b1gflhy********
      ``` 

      Будут выведены идентификаторы квот, которые есть в сервисе {{ iam-short-name }} в облаке `b1gflhy********`. А также значение и потребление этих квот.

  1. Посмотрите значение и потребление определенной квоты.
  
      ```bash
      yc quota-manager quota-limit get \
         --quota-id=<идентификатор_квоты> \
         --resource-id <идентификатор_ресурса> \
         --resource-type <тип_ресурса>
      ```

      Где:
       * `--quota-id` — идентификатор квоты, полученный на предыдущем шаге.
       * `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
       * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

      Пример:

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

  **Настройте работу с API**

  1. Чтобы проверить работу с квотами через API, установите утилиты:
     * [cURL](https://curl.haxx.se) при использовании [REST API](../../../workload/api-ref/).
     * [gRPCurl](https://github.com/fullstorydev/grpcurl) при использовании [gRPC API](../../../workload/api-ref/grpc/).
  
  1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) с [ролью](../iam/operations/roles/grant.md) `quota-manager.viewer`.
  
  1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.
  
  **Посмотрите квоты**

  1. Посмотрите список сервисов, для которых есть квоты.
  
      Для этого воспользуйтесь методом REST API [listServices](api-ref/QuotaLimit/listServices.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/ListServices](api-ref/grpc/QuotaLimit/listServices.md).

      Чтобы проверить работу метода REST API, выполните запрос:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM-токен>" \
      "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/services?resourceType=<resourceType>"
      ```

      Где:

      * `<resourceType>` — [тип ресурса](concepts/index.md#resources-types): `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.

      Пример запроса:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer $IAM_TOKEN" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/services?resourceType=resource-manager.cloud'

  1. Посмотрите список квот для определенного сервиса, а также значение и потребление всех квот.
  
      Для этого воспользуйтесь методом REST API [list](api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/List](api-ref/grpc/QuotaLimit/list.md).

      Чтобы проверить работу метода REST API, выполните запрос:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM-токен>" \
      "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits?service=<serviceName>&resource.id=<resourceId>&resource.type=<resourceType>"
      ```

      Где:

      * `<resourceId>` — идентификатор ресурса: облака, организации или платежного аккаунта.
      * `<resourceType>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<serviceName>` — имя сервиса.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
        
      Пример запроса:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer $IAM_TOKEN" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits?service=iam&resource.id=b1gflhy********&resource.type=resource-manager.cloud'
      ```

  1. Посмотрите значение и потребление определенной квоты.
  
      Для этого воспользуйтесь методом REST API [get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md).

      Чтобы проверить работу метода REST API, выполните запрос:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer <IAM-токен>" \
      "https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/<quotaId>?resource.id=<resourceId>&resource.type=<resourceType>"
      ```

      Где:

      * `<quotaId>` — идентификатор квоты, полученный на предыдущем шаге.
      * `<resourceId>` — идентификатор ресурса (облака, организации или платежного аккаунта).
      * `<resourceType>` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
      * `<IAM-токен>` — IAM-токен для сервисного аккаунта или переменная окружения, в которой находится IAM-токен.
      
      Пример запроса:

      ```bash
      curl -X GET \
      --header "Authorization: Bearer $IAM_TOKEN" \
      'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/iam.accessKeys.count?resource.id=b1gflhy********&resource.type=resource-manager.cloud'
      ```

{% endlist %}

## Запросить увеличение квот

{% include [request-quota](../_includes/quota-manager/request-quota.md) %}