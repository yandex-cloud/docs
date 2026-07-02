[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Сбор, мониторинг и анализ аудитных логов > Поиск событий Yandex Cloud в Cloud Logging

# Поиск событий Yandex Cloud в Yandex Cloud Logging

# Поиск событий Yandex Cloud в Cloud Logging

## Кто удалил каталог {#delete-folder}

Поиск по идентификатору:

```json
json_payload.event_type="yandex.cloud.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_id="<идентификатор_каталога>"
```
Поиск по названию:
```json
json_payload.event_type="yandex.cloud.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_name="<имя_каталога>"
```

## Кто создал/остановил/перезапустил/удалил виртуальную машину {#vm-manage}

Поиск по идентификатору [виртуальной машины](../../../glossary/vm.md):

```json
json_payload.details.instance_id="<идентификатор_виртуальной_машины>" and (json_payload.event_type="yandex.cloud.audit.compute.CreateInstance" or json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or json_payload.event_type="yandex.cloud.audit.compute.DeleteInstance" or json_payload.event_type="yandex.cloud.audit.compute.StartInstance" or json_payload.event_type="yandex.cloud.audit.compute.StopInstance" or json_payload.event_type="yandex.cloud.audit.compute.RestartInstance")
```

## Какие действия совершал конкретный пользователь за период времени {#user-actions}

Поиск по идентификатору пользователя:

```json
json_payload.authentication.subject_id="<идентификатор_пользователя>" and json_payload.event_time>"2021-03-01" and json_payload.event_time<"2021-04-01"
```

Поиск по имени пользователя:

```json
json_payload.authentication.subject_name="<имя_пользователя>" and json_payload.event_time>"2021-03-01" and json_payload.event_time<"2021-04-01"
```

## Поиск событий по объектам определенного каталога {#folder-actions}

Поиск по идентификатору каталога:

```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_id="<идентификатор_каталога>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_id="<идентификатор_каталога>"
```

Поиск по имени каталога:

```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_name="<имя_каталога>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_name="<имя_каталога>"
```

## Поиск событий с ошибками {#error}

Поиск ошибок, связанных с недостаточными правами на выполнение операции (Permission denied):

```json
json_payload.event_status = ERROR and json_payload.error.code = 7
```


## Что дальше {#whats-next}

Ознакомьтесь с примерами событий в [Yandex Cloud Security Solution Library](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/_use_cases_and_searches/Use-casesANDsearches_RU.pdf).

{% note info %}

[Yandex Cloud Security Solution Library](https://github.com/yandex-cloud-examples/yc-security-solutions-library) — это набор примеров и рекомендаций по построению безопасной инфраструктуры в Yandex Cloud, собранных в публичном репозитории на GitHub.

{% endnote %}