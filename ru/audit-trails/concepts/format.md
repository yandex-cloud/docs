# Аудитный лог событий уровня конфигурации

Аудитный лог [событий уровня конфигурации](events.md) — это запись о событиях, которые произошли с ресурсами {{ yandex-cloud }}, в форме JSON-объекта.

{% include [format-and-object](../../_includes/audit-trails/format-and-object.md) %}

{% cut "Пример аудитного лога уровня конфигурации при создании ВМ" %}

Если федеративный пользователь создаст в сервисе {{ compute-full-name }} ВМ, в аудитный лог попадет такая запись:

```json
{
    "event_id": "<идентификатор_события>",
    "event_source": "compute",
    "event_type": "yandex.cloud.audit.compute.CreateInstance",
    "event_time": "<дата_события>",
    "authentication": {
        "authenticated":true,
        "subject_type": "FEDERATED_USER_ACCOUNT",
        "subject_id": "<идентификатор_пользователя>",
        "subject_name": "<логин_пользователя>",
        "federation_id": "<идентификатор_федерации>",
        "federation_name": "<имя_федерации>",
        "federation_type": "<тип_федерации>"
    },
    "authorization": {
        "authorized":true
    },
    "resource_metadata": {
        "path":[
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
        "instance_id": "<идентификатор_ВМ>",
        "instance_name": "<имя_ВМ>",
        "zone_id": "<зона_доступности_ВМ>",
        "platform_id": "standard-v3",
        "metadata_keys":[
            "ssh-keys",
            "user-data",
            "install-unified-agent"
        ],
        "network_settings": {
            "type": "STANDARD"
        },
        "placement_policy": {
        },
        "os": {
            "type": "LINUX"
        },
        "product_ids":[
            "<идентификатор_образа>"
        ],
        "resources": {
            "memory": "2147483648",
            "cores": "2",
            "core_fraction": "100"
        },
        "boot_disk": {
            "mode": "READ_WRITE",
            "device_name": "<имя_диска>",
            "auto_delete":true,
            "disk_id": "<идентификатор_диска>"
        },
        "network_interfaces":[
            {
                "index": "0",
                "mac_address": "<mac_адрес_ВМ>",
                "subnet_id": "<идентификатор_подсети>",
                "primary_v4_address": {
                    "address": "<внутренний_адрес_ВМ>",
                    "one_to_one_nat": {
                        "address": "<внешний_адрес_ВМ>",
                        "ip_version": "IPV4"
                    }
                }
            }
        ],
        "fqdn": "внутренний_fqdn_ВМ"
    }
}
```
{% endcut %}

{% include [data-scheme](../../_includes/audit-trails/data-scheme.md) %}

{% include [audit-log-format](../../_includes/audit-trails/audit-log-format.md) %}