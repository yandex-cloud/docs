# Посмотреть журнал выполнения в {{ api-gw-name }}

Время в журнале выполнения указано по [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится API-шлюз.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз, журнал выполнения которого вы хотите посмотреть.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}** и укажите период. По умолчанию задан период за 1 час.

{% endlist %}

Каждое событие в журнале содержит параметр `release` со значением `canary`, если запрос был обработан канареечным релизом, и `stable` — текущим.

Подробнее о работе с логами в [документации {{ cloud-logging-full-name }}](../../logging/index.md).