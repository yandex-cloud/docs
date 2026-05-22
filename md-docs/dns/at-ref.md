# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Cloud DNS поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.dns.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateDnsZone` | Создание зоны [DNS](../glossary/dns.md)
`DeleteDnsZone` | Удаление зоны DNS
`SetDnsZoneAccessBindings` | Назначение прав доступа к зоне DNS
`UpdateDnsZone` | Изменение зоны DNS
`UpdateDnsZoneAccessBindings` | Изменение прав доступа к зоне DNS
`UpdatePrivateNetworks` | Изменение приватных сетей
`UpdateRecordSets` | Изменение набора записей

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`ProcessDnsQuery` | Результат выполнения DNS запроса от клиента Cloud DNS

{% note info %}

Если действие выполнил один из инфраструктурных сервисов Yandex Cloud или сотрудник поддержки, то в полях `client_ip` и `server_ip` в секции `details` будет указано специальное значение: `cloud.yandex`.

{% endnote %}