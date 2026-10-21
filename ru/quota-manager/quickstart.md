---
title: Как начать работать с {{ quota-manager-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть квоты для ваших сервисов.
---

# Как начать работать с {{ quota-manager-full-name }}

{{ quota-manager-name }} позволяет управлять квотами сервисов {{ yandex-cloud }} с помощью различных интерфейсов.

_Квоты_ — ограничения на использование ресурсов. Их можно увеличить по запросу в пределах _лимитов_ — технических ограничений {{ yandex-cloud }}.

{% include [quota-level-access](../_includes/quota-manager/quota-level-access.md) %}

## Перед началом работы {#before-you-begin}

Убедитесь, что у пользователя или сервисного аккаунта есть нужная [роль](../iam/concepts/access-control/roles.md) на облако или организацию:

{% include [before-begin-api-assign-roles](../_includes/quota-manager/before-begin-api-assign-roles.md) %}

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  Дополнительная подготовка не требуется.

- CLI {#cli}

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

- REST API {#api}

    1. Установите утилиту [cURL](https://curl.haxx.se).
    1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте ему](../iam/operations/sa/assign-role-for-sa.md) одну из ролей, указанных выше.
    1. {% include [before-begin-api-get-iam-token](../_includes/quota-manager/before-begin-api-get-iam-token.md) %}
    1. Сохраните полученный IAM-токен в переменной окружения:

       ```bash
       export IAM_TOKEN=<iam_токен>
       ```

- gRPC API {#grpc-api}

    1. Установите утилиту [gRPCurl](https://github.com/fullstorydev/grpcurl).
    1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте ему](../iam/operations/sa/assign-role-for-sa.md) одну из ролей, указанных выше.
    1. {% include [before-begin-api-get-iam-token](../_includes/quota-manager/before-begin-api-get-iam-token.md) %}
    1. Сохраните полученный IAM-токен в переменной окружения:

       ```bash
       export IAM_TOKEN=<iam_токен>
       ```

{% endlist %}

## Получить информацию о квотах {#get-quota-info}

Квоты действуют на уровне облака или организации. Если уровень неизвестен, посмотрите оба уровня и найдите нужный сервис.

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  {% include [get-quota-info-console](../_includes/quota-manager/get-quota-info-console.md) %}

- CLI {#cli}

  1. Посмотрите список сервисов с квотами на уровне облака:

     {% include [list-quota-services-cli](../_includes/quota-manager/list-quota-services-cli.md) %}

  1. Посмотрите значение и потребление квоты `iam.accessKeys.count`:

     {% include [get-quota-info-cli](../_includes/quota-manager/get-quota-info-cli.md) %}

     Где:

     * `--resource-id` — идентификатор [облака](../resource-manager/operations/cloud/get-id.md) или [организации](../organization/operations/organization-get-id.md).
     * `--quota-id` — идентификатор квоты из [справочника](all-quotas.md). В примере `iam.accessKeys.count` — количество статических ключей доступа в облаке.
     * `--resource-type` — [тип ресурса](concepts/index.md#resources-types), определяющий уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

     {% include [get-quota-info-response-legend](../_includes/quota-manager/get-quota-info-response-legend.md) %}

- REST API {#api}

    1. Получите список сервисов с квотами на уровне облака методом [listServices](api-ref/QuotaLimit/listServices.md):

       ```bash
       curl \
         --request GET \
         --header "Authorization: Bearer ${IAM_TOKEN?}" \
         'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/services?resourceType=resource-manager.cloud'
       ```

       Параметр `resourceType` ([тип ресурса](concepts/index.md#resources-types)) определяет уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

       Если в ответе есть непустое поле `nextPageToken`, передайте его значение в параметре `pageToken` следующего запроса. Повторяйте запросы, пока не получите все сервисы.

    1. Получите значение и потребление квоты `iam.accessKeys.count` методом [get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md):

       ```bash
       curl \
         --request GET \
         --header "Authorization: Bearer ${IAM_TOKEN?}" \
         'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/iam.accessKeys.count?resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud'
       ```

       Где:

       * `resource.id` — идентификатор [облака](../resource-manager/operations/cloud/get-id.md) или [организации](../organization/operations/organization-get-id.md).
       * `iam.accessKeys.count` — идентификатор квоты на количество статических ключей доступа в облаке. Для другой квоты возьмите идентификатор из [справочника](all-quotas.md).
       * `resource.type` — [тип ресурса](concepts/index.md#resources-types), определяющий уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

       {% include [get-quota-info-response-legend](../_includes/quota-manager/get-quota-info-response-legend.md) %}

- gRPC API {#grpc-api}

    1. Получите список сервисов с квотами на уровне облака с помощью вызова [QuotaLimitService/ListServices](api-ref/grpc/QuotaLimit/listServices.md):

       ```bash
       grpcurl \
         -H "Authorization: Bearer ${IAM_TOKEN?}" \
         -d '{"resource_type": "resource-manager.cloud"}' \
         {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/ListServices
       ```

       Поле `resource_type` ([тип ресурса](concepts/index.md#resources-types)) определяет уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

       Если в ответе есть непустое поле `nextPageToken`, передайте его значение в поле `page_token` следующего запроса. Повторяйте запросы, пока не получите все сервисы.

    1. Получите значение и потребление квоты `iam.accessKeys.count` с помощью вызова [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md):

       ```bash
       grpcurl \
         -H "Authorization: Bearer ${IAM_TOKEN?}" \
         -d '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "quota_id": "iam.accessKeys.count"}' \
         {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/Get
       ```

       Где:

       * `resource.id` — идентификатор [облака](../resource-manager/operations/cloud/get-id.md) или [организации](../organization/operations/organization-get-id.md).
       * `quota_id` — идентификатор квоты из [справочника](all-quotas.md). В примере `iam.accessKeys.count` — количество статических ключей доступа в облаке.
       * `resource.type` — [тип ресурса](concepts/index.md#resources-types), определяющий уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

       {% include [get-quota-info-response-legend](../_includes/quota-manager/get-quota-info-response-legend.md) %}

{% endlist %}

## Запросить изменение квот {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  {% include [request-quota](../_includes/quota-manager/request-quota.md) %}

- CLI {#cli}

  1. Создайте запрос на изменение квоты:

     ```bash
     yc quota-manager quota-request create \
       --resource-id <идентификатор_облака> \
       --resource-type resource-manager.cloud \
       --desired-limit quota-id=iam.accessKeys.count,value=1001
     ```

     В примере запрашивается новое значение квоты `1001`, вы можете заменить его на другое.

     Сохраните значение поля `id` из ответа — идентификатор запроса.

  1. Проверьте статус запроса:

     ```bash
     yc quota-manager quota-request get \
       --id <идентификатор_запроса>
     ```

     В ответе поле `status` показывает состояние запроса, а результат изменения каждой квоты указан в списке `quota_limits`.

  {% include [quota-request-review](../_includes/quota-manager/quota-request-review.md) %}

- REST API {#api}

    1. Создайте запрос методом [create](api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md):

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer ${IAM_TOKEN?}" \
         --header "Content-Type: application/json" \
         --data '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "desiredQuotaLimits": [{"quotaId": "iam.accessKeys.count", "desiredLimit": "1001"}]}' \
         'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests'
       ```

       В примере запрашивается итоговое значение квоты `1001`. Замените его на нужное значение.

       Сохраните значение `metadata.quotaRequestId` из ответа — идентификатор запроса. Поля `id` и `done` относятся к операции создания запроса, а не к его рассмотрению.

    1. Проверьте статус запроса методом [get](api-ref/QuotaRequest/get.md):

       ```bash
       curl \
         --request GET \
         --header "Authorization: Bearer ${IAM_TOKEN?}" \
         'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests/<идентификатор_запроса>'
       ```

       В ответе поле `status` показывает состояние запроса, а результат изменения каждой квоты указан в списке `quotaLimits`.

    {% include [quota-request-review](../_includes/quota-manager/quota-request-review.md) %}

- gRPC API {#grpc-api}

    1. Создайте запрос с помощью вызова [QuotaRequestService/Create](api-ref/grpc/QuotaRequest/create.md):

       ```bash
       grpcurl \
         -H "Authorization: Bearer ${IAM_TOKEN?}" \
         -d '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "desired_quota_limits": [{"quota_id": "iam.accessKeys.count", "desired_limit": "1001"}]}' \
         {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Create
       ```

       В примере запрашивается итоговое значение квоты `1001`. Замените его на нужное значение.

       Сохраните значение `metadata.quotaRequestId` из ответа — идентификатор запроса. Поля `id` и `done` относятся к операции создания запроса, а не к его рассмотрению.

    1. Проверьте статус запроса с помощью вызова [QuotaRequestService/Get](api-ref/grpc/QuotaRequest/get.md):

       ```bash
       grpcurl \
         -H "Authorization: Bearer ${IAM_TOKEN?}" \
         -d '{"quota_request_id": "<идентификатор_запроса>"}' \
         {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
       ```

       В ответе поле `status` показывает состояние запроса, а результат изменения каждой квоты указан в списке `quotaLimits`.

    {% include [quota-request-review](../_includes/quota-manager/quota-request-review.md) %}

{% endlist %}

Запросить увеличение квот можно и через [техническую поддержку]({{ link-console-support }}), указав облако или организацию, квоты и желаемые значения.

[*quota-usage]: {% include notitle [quota-usage](../_popups/quota-manager/quotas.md#quota-usage) %}

[*quota-limit]: {% include notitle [quota-limit](../_popups/quota-manager/quotas.md#quota-limit) %}
