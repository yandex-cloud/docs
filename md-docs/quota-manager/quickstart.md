[Документация Yandex Cloud](../index.md) > [Yandex Cloud Quota Manager](index.md) > Начало работы

# Как начать работать с Yandex Cloud Quota Manager

Cloud Quota Manager позволяет управлять квотами сервисов Yandex Cloud с помощью различных интерфейсов.

_Квоты_ — ограничения на использование ресурсов. Их можно увеличить по запросу в пределах _лимитов_ — технических ограничений Yandex Cloud.

Интерфейсы управления квотами:

* [Cloud Center](https://center.yandex.cloud/quotas) — уровень организации.
* [Консоль управления](https://console.yandex.cloud/cloud?section=quotas) — уровень облака.
* [CLI](cli-ref/index.md) и [API](api-ref/authentication.md) — уровень организации и облака. Для работы с запросами на изменение квот через CLI и API обратитесь в [службу поддержки](https://center.yandex.cloud/support).

В большинстве сервисов квоты действуют на уровне облака. В Resource Manager, Cloud Video и некоторых других сервисах квоты действуют на уровне организации. В IAM есть квоты обоих уровней.

## Перед началом работы {#before-you-begin}

Убедитесь, что у пользователя или сервисного аккаунта есть нужная [роль](../iam/concepts/access-control/roles.md) на облако или организацию:

* [quota-manager.viewer](security/index.md#quota-manager-viewer) — для просмотра квот.
* [quota-manager.requestOperator](security/index.md#quota-manager-requestoperator) — для просмотра квот и создания запросов на их изменение.

{% list tabs group=instructions %}

- Консоль управления или Cloud Center {#console}

  Дополнительная подготовка не требуется.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

- REST API {#api}

    1. Установите утилиту [cURL](https://curl.haxx.se).
    1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте ему](../iam/operations/sa/assign-role-for-sa.md) одну из ролей, указанных выше.
    1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.
    1. Сохраните полученный IAM-токен в переменной окружения:

       ```bash
       export IAM_TOKEN=<iam_токен>
       ```

- gRPC API {#grpc-api}

    1. Установите утилиту [gRPCurl](https://github.com/fullstorydev/grpcurl).
    1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) и [назначьте ему](../iam/operations/sa/assign-role-for-sa.md) одну из ролей, указанных выше.
    1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.
    1. Сохраните полученный IAM-токен в переменной окружения:

       ```bash
       export IAM_TOKEN=<iam_токен>
       ```

{% endlist %}

## Получить информацию о квотах {#get-quota-info}

Квоты действуют на уровне облака или организации. Если уровень неизвестен, посмотрите оба уровня и найдите нужный сервис.

{% list tabs group=instructions %}

- Консоль управления или Cloud Center {#console}

  1. Выберите облако в [консоли управления](https://console.yandex.cloud) или организацию в [Cloud Center](https://center.yandex.cloud).
  
  1. На панели слева откройте ![image](../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. На вкладке **Список квот** введите в строку поиска название сервиса, название или идентификатор квоты.
  
  1. Раскройте нужный сервис в одной из групп:
  
     * **Сервисы с потреблением** — потребление хотя бы одной квоты больше нуля.
     * **Сервисы без потребления** — потребление всех квот равно нулю.
  
  1. В строке квоты посмотрите столбец **Использование**:
  
     * Числа — [потребление квоты](*quota-usage) / [значение квоты](*quota-limit).
     * **Квота не выделена** — значение квоты не установлено.
  
  1. Чтобы показать только сервисы, в которых квоты близки к исчерпанию, вверху нажмите **Почти закончились**.
  
  Если квоты близки к исчерпанию или не выделены, на этой же странице можно [запросить их изменение](operations/set-quotas.md#request-quota-change).

- CLI {#cli}

  1. Посмотрите список сервисов с квотами на уровне облака:

     ```bash
     yc quota-manager quota-limit list-services --resource-type resource-manager.cloud
     ```
     
     Параметр `--resource-type` ([тип ресурса](concepts/index.md#resources-types)) определяет уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

  1. Посмотрите значение и потребление квоты `iam.accessKeys.count`:

     ```bash
     yc quota-manager quota-limit get \
       --quota-id iam.accessKeys.count \
       --resource-id <идентификатор_облака> \
       --resource-type resource-manager.cloud
     ```

     Где:

     * `--resource-id` — идентификатор [облака](../resource-manager/operations/cloud/get-id.md) или [организации](../organization/operations/organization-get-id.md).
     * `--quota-id` — идентификатор квоты из [справочника](all-quotas.md). В примере `iam.accessKeys.count` — количество статических ключей доступа в облаке.
     * `--resource-type` — [тип ресурса](concepts/index.md#resources-types), определяющий уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

     В ответе `limit` — [значение квоты](*quota-limit), `usage` — [потребление квоты](*quota-usage). Сравните эти значения, чтобы оценить запас квоты.
     
     Чтобы найти другие квоты, [посмотрите список квот](operations/list-quotas.md#list-service-quotas) нужного сервиса.

- REST API {#api}

    1. Получите список сервисов с квотами на уровне облака методом [listServices](api-ref/QuotaLimit/listServices.md):

       ```bash
       curl \
         --request GET \
         --header "Authorization: Bearer ${IAM_TOKEN?}" \
         'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/services?resourceType=resource-manager.cloud'
       ```

       Параметр `resourceType` ([тип ресурса](concepts/index.md#resources-types)) определяет уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

       Если в ответе есть непустое поле `nextPageToken`, передайте его значение в параметре `pageToken` следующего запроса. Повторяйте запросы, пока не получите все сервисы.

    1. Получите значение и потребление квоты `iam.accessKeys.count` методом [get](api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](api-ref/QuotaLimit/index.md):

       ```bash
       curl \
         --request GET \
         --header "Authorization: Bearer ${IAM_TOKEN?}" \
         'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/iam.accessKeys.count?resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud'
       ```

       Где:

       * `resource.id` — идентификатор [облака](../resource-manager/operations/cloud/get-id.md) или [организации](../organization/operations/organization-get-id.md).
       * `iam.accessKeys.count` — идентификатор квоты на количество статических ключей доступа в облаке. Для другой квоты возьмите идентификатор из [справочника](all-quotas.md).
       * `resource.type` — [тип ресурса](concepts/index.md#resources-types), определяющий уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

       В ответе `limit` — [значение квоты](*quota-limit), `usage` — [потребление квоты](*quota-usage). Сравните эти значения, чтобы оценить запас квоты.
       
       Чтобы найти другие квоты, [посмотрите список квот](operations/list-quotas.md#list-service-quotas) нужного сервиса.

- gRPC API {#grpc-api}

    1. Получите список сервисов с квотами на уровне облака с помощью вызова [QuotaLimitService/ListServices](api-ref/grpc/QuotaLimit/listServices.md):

       ```bash
       grpcurl \
         -H "Authorization: Bearer ${IAM_TOKEN?}" \
         -d '{"resource_type": "resource-manager.cloud"}' \
         quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaLimitService/ListServices
       ```

       Поле `resource_type` ([тип ресурса](concepts/index.md#resources-types)) определяет уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

       Если в ответе есть непустое поле `nextPageToken`, передайте его значение в поле `page_token` следующего запроса. Повторяйте запросы, пока не получите все сервисы.

    1. Получите значение и потребление квоты `iam.accessKeys.count` с помощью вызова [QuotaLimitService/Get](api-ref/grpc/QuotaLimit/get.md):

       ```bash
       grpcurl \
         -H "Authorization: Bearer ${IAM_TOKEN?}" \
         -d '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "quota_id": "iam.accessKeys.count"}' \
         quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaLimitService/Get
       ```

       Где:

       * `resource.id` — идентификатор [облака](../resource-manager/operations/cloud/get-id.md) или [организации](../organization/operations/organization-get-id.md).
       * `quota_id` — идентификатор квоты из [справочника](all-quotas.md). В примере `iam.accessKeys.count` — количество статических ключей доступа в облаке.
       * `resource.type` — [тип ресурса](concepts/index.md#resources-types), определяющий уровень просмотра квот. Для уровня организации укажите `organization-manager.organization`.

       В ответе `limit` — [значение квоты](*quota-limit), `usage` — [потребление квоты](*quota-usage). Сравните эти значения, чтобы оценить запас квоты.
       
       Чтобы найти другие квоты, [посмотрите список квот](operations/list-quotas.md#list-service-quotas) нужного сервиса.

{% endlist %}

## Запросить изменение квот {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления или Cloud Center {#console}

  1. Выберите облако в [консоли управления](https://console.yandex.cloud) или организацию в [Cloud Center](https://center.yandex.cloud).
  
  1. На панели слева откройте ![image](../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. На вкладке **Список квот**:
  
     * Введите в строку поиска название сервиса, название или идентификатор квоты.
  
     * В группе **Сервисы с потреблением** или **Сервисы без потребления** раскройте раздел нужного сервиса.
  
  1. Отметьте квоты, которые хотите увеличить, и нажмите **Изменить**.
  
  1. Укажите новые значения квот и нажмите **Отправить**.
  
  1. Дождитесь рассмотрения запроса.

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

  Дождитесь рассмотрения запроса и проверьте [его статус и результат изменения каждой квоты](concepts/index.md#quota-request-statuses). После одобрения повторно [посмотрите значение квоты](quickstart.md#get-quota-info).
  
  Если нужно найти ранее созданный запрос, [посмотрите список запросов](operations/set-quotas.md#list-quota-requests). Подробные примеры приведены в разделе [Примеры запросов для работы с квотами](requests-examples.md).

- REST API {#api}

    1. Создайте запрос методом [create](api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](api-ref/QuotaRequest/index.md):

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer ${IAM_TOKEN?}" \
         --header "Content-Type: application/json" \
         --data '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "desiredQuotaLimits": [{"quotaId": "iam.accessKeys.count", "desiredLimit": "1001"}]}' \
         'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests'
       ```

       В примере запрашивается итоговое значение квоты `1001`. Замените его на нужное значение.

       Сохраните значение `metadata.quotaRequestId` из ответа — идентификатор запроса. Поля `id` и `done` относятся к операции создания запроса, а не к его рассмотрению.

    1. Проверьте статус запроса методом [get](api-ref/QuotaRequest/get.md):

       ```bash
       curl \
         --request GET \
         --header "Authorization: Bearer ${IAM_TOKEN?}" \
         'https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaRequests/<идентификатор_запроса>'
       ```

       В ответе поле `status` показывает состояние запроса, а результат изменения каждой квоты указан в списке `quotaLimits`.

    Дождитесь рассмотрения запроса и проверьте [его статус и результат изменения каждой квоты](concepts/index.md#quota-request-statuses). После одобрения повторно [посмотрите значение квоты](quickstart.md#get-quota-info).
    
    Если нужно найти ранее созданный запрос, [посмотрите список запросов](operations/set-quotas.md#list-quota-requests). Подробные примеры приведены в разделе [Примеры запросов для работы с квотами](requests-examples.md).

- gRPC API {#grpc-api}

    1. Создайте запрос с помощью вызова [QuotaRequestService/Create](api-ref/grpc/QuotaRequest/create.md):

       ```bash
       grpcurl \
         -H "Authorization: Bearer ${IAM_TOKEN?}" \
         -d '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "desired_quota_limits": [{"quota_id": "iam.accessKeys.count", "desired_limit": "1001"}]}' \
         quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Create
       ```

       В примере запрашивается итоговое значение квоты `1001`. Замените его на нужное значение.

       Сохраните значение `metadata.quotaRequestId` из ответа — идентификатор запроса. Поля `id` и `done` относятся к операции создания запроса, а не к его рассмотрению.

    1. Проверьте статус запроса с помощью вызова [QuotaRequestService/Get](api-ref/grpc/QuotaRequest/get.md):

       ```bash
       grpcurl \
         -H "Authorization: Bearer ${IAM_TOKEN?}" \
         -d '{"quota_request_id": "<идентификатор_запроса>"}' \
         quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
       ```

       В ответе поле `status` показывает состояние запроса, а результат изменения каждой квоты указан в списке `quotaLimits`.

    Дождитесь рассмотрения запроса и проверьте [его статус и результат изменения каждой квоты](concepts/index.md#quota-request-statuses). После одобрения повторно [посмотрите значение квоты](quickstart.md#get-quota-info).
    
    Если нужно найти ранее созданный запрос, [посмотрите список запросов](operations/set-quotas.md#list-quota-requests). Подробные примеры приведены в разделе [Примеры запросов для работы с квотами](requests-examples.md).

{% endlist %}

Запросить увеличение квот можно и через [техническую поддержку](https://center.yandex.cloud/support), указав облако или организацию, квоты и желаемые значения.

[*quota-usage]: #### {#quota-usage}
                
                Потребление квоты — объем фактически используемого ресурса. Подробнее в разделе [Концепции Cloud Quota Manager](concepts/index.md).
                
                #### {#quota-limit}
                
                Значение квоты — установленная верхняя граница потребления ресурса. Подробнее в разделе [Концепции Cloud Quota Manager](concepts/index.md).

[*quota-limit]: #### {#quota-usage}
                
                Потребление квоты — объем фактически используемого ресурса. Подробнее в разделе [Концепции Cloud Quota Manager](concepts/index.md).
                
                #### {#quota-limit}
                
                Значение квоты — установленная верхняя граница потребления ресурса. Подробнее в разделе [Концепции Cloud Quota Manager](concepts/index.md).