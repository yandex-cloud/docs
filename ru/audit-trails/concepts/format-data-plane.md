# Аудитный лог событий уровня сервисов

Отслеживайте [события уровня сервисов](events-data-plane.md), чтобы убедиться, что только авторизованные пользователи получают доступ к вашим данным и изменяют их. Это поможет обеспечить соответствие вашей облачной инфраструктуры нормативным правовым актам и отраслевым стандартам. Например, вы можете отслеживать получение сотрудниками доступа к конфиденциальным данным, хранящимся в бакетах.

Анализируйте логи событий уровня сервисов, чтобы оптимизировать использование ресурсов в вашей инфраструктуре. Так вы сможете определить наиболее часто используемые ресурсы и повысить их производительность. Или, наоборот, выявить редко используемые ресурсы, которые можно объединить или удалить для сокращения затрат.

{% note warning %}

При настройке сбора событий уровня сервисов для бакета {{ objstorage-name }} не рекомендуем выбирать этот же бакет в качестве [объекта назначения](./trail.md#target) загрузки логов. В этом случае может возникнуть автоматическая рекурсивная генерация логов аудита, что приведет к увеличению объема генерируемых логов (приблизительно на 16 МБ в месяц для всех событий одного трейла, сохраняемых в бакете).

{% endnote %}

Аудитный лог событий уровня сервисов — это запись о событиях, которые произошли с ресурсами {{ yandex-cloud }}, в форме JSON-объекта.

{% include [format-and-object](../../_includes/audit-trails/format-and-object.md) %}

{% cut "Пример аудитного лога уровня сервисов при запросе содержимого секрета" %}

Если федеративный пользователь запросит содержимое секрета в сервисе {{ lockbox-full-name }}, в аудитный лог попадет такая запись:

```json
{
    "event_id": "<идентификатор_события>",
    "event_source": "lockbox",
    "event_type": "yandex.cloud.audit.lockbox.GetPayload",
    "event_time": "<дата_события>",
    "authentication": {
        "authenticated": true,
        "subject_type": "FEDERATED_USER_ACCOUNT",
        "subject_id": "<идентификатор_пользователя>",
        "subject_name": "<логин_пользователя>",
        "federation_id": "<идентификатор_федерации>",
        "federation_name": "<имя_федерации>",
        "federation_type": "<тип_федерации>"
    },
    "authorization": {
        "authorized": true
    },
    "resource_metadata": {
        "path": [
            {
                "resource_type": "organization-manager.organization",
                "resource_id": "<идентификатор_организации>",
                "resource_name": "<имя_организации>"
            },
            {
                "resource_type": "resource-manager.cloud",
                "resource_id": "<идентификатор_облака>",
                "resource_name": "<имя_облака>"
            },
            {
                "resource_type": "resource-manager.folder",
                "resource_id": "<идентификатор_каталога>",
                "resource_name": "<имя_каталога>"
            }
        ]
    },
    "request_metadata": {
        "remote_address": "cloud.yandex",
        "user_agent": "Yandex Cloud",
        "request_id": "<идентификатор_запроса>"
    },
    "event_status": "DONE",
    "details": {
        "secret_id": "<идентификатор_секрета>",
        "secret_name": "<имя_секрета>",
        "secret_version_id": "<идентификатор_версии_секрета>",
        "secret_kms_key_id": "<идентификатор_ключа_шифрования_секрета_в_KMS>",
        "secret_status": "<статус_секрета>",
        "secret_version_status": "<статус_версии_секрета>",
        "secret_version_payload_entry_keys": [
            "<ключи_записей_в_версии_секрета>"
        ]
    },
    "request_parameters": {
        "secret_id": "<идентификатор_секрета>",
        "version_id": "<идентификатор_версии_секрета>"
    },
    "response": {
        "version_id": "<идентификатор_версии>",
        "entry_keys": [
            "<ключи_записей>"
        ]
    }
}
```
{% endcut %}

{% include [data-scheme](../../_includes/audit-trails/data-scheme.md) %}

{% include [audit-log-format](../../_includes/audit-trails/audit-log-format.md) %}