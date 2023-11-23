---
title: "Как найти события {{ yandex-cloud }} в {{ cloud-logging-full-name }}"
description: "Из статьи вы узнаете, как найти события {{ yandex-cloud }} в {{ cloud-logging-full-name }}."
---

# Поиск событий {{ yandex-cloud }} в {{ cloud-logging-name }}

## Кто удалил каталог

Поиск по идентификатору:
```json
json_payload.event_type="{{ at-event-prefix }}.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_id="<идентификатор_каталога>"
```
Поиск по названию:
```json
json_payload.event_type="{{ at-event-prefix }}.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_name="<название_каталога>"
```

## Кто создал/остановил/перезапустил/удалил виртуальную машину

Поиск по идентификатору [виртуальной машины](../../glossary/vm.md):
```json
json_payload.details.instance_id="<идентификатор_виртуальной_машины>" and (json_payload.event_type="{{ at-event-prefix }}.audit.compute.CreateInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.UpdateInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.DeleteInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.StartInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.StopInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.RestartInstance")
```

## Какие действия совершал конкретный пользователь за период времени

Поиск по идентификатору пользователя:
```json
json_payload.authentication.subject_id="<идентификатор_пользователя>" and json_payload.event_time>"2021-03-01" and json_payload.event_time<"2021-04-01"
```
Поиск по имени пользователя:
```json
json_payload.authentication.subject_name="<имя_пользователя>" and json_payload.event_time>"2021-03-01" and json_payload.event_time<"2021-04-01"
```

## Поиск событий по объектам определенного каталога

Поиск по идентификатору каталога:
```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_id="<идентификатор_каталога>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_id="<идентификатор_каталога>"
```

Поиск по имени каталога:
```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_name="<имя_каталога>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_name="<имя_каталога>"
```


## Что дальше {#whats-next}

Ознакомьтесь с примерами событий в [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/_use_cases_and_searches/Use-casesANDsearches_RU.pdf).

{% include [Yc-solution-library-for-security](../../_includes/security-solution-library.md) %}

