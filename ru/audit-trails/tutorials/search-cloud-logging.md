---
title: Поиск аудитных событий {{ yandex-cloud }} в {{ monium-full-name }}
description: Примеры запросов для поиска событий {{ at-name }} в {{ monium-name }} по каталогу, виртуальной машине, пользователю и коду ошибки.
---

# Поиск аудитных событий {{ yandex-cloud }} в {{ monium-name }}

Выполните нужный запрос из примеров в текстовом режиме.

{% list tabs group=audit-trails-destination %}

- {{ monium-name }} {#monium}

  1. [Откройте аудитные логи в {{ monium-name }}](search-monium.md) и выберите период поиска вверху страницы.
  1. Чтобы перейти в текстовый режим, нажмите ![code](../../_assets/console-icons/code.svg) справа над строкой запроса.
  1. Вставьте запрос и подставьте свои значения. В метке `project` укажите идентификатор каталога с трейлом после префикса `folder__`. Чтобы отобрать события, которые доставил конкретный трейл, добавьте в запрос условие `trail_id == "<идентификатор_трейла>"`.
  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

{% endlist %}

## Как проверить доставку событий {#check-delivery}

Убедитесь, что тестовый трейл в статусе `Active` и его область сбора событий уровня конфигурации включает каталог с трейлом. [Измените описание трейла](../operations/manage-trail.md#update-trail). Выберите период, в который попадает время изменения, и выполните запрос:

```text
{project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", trail_id=="<идентификатор_трейла>", meta.event_type=="{{ at-event-prefix }}.audit.audittrails.UpdateTrail", meta.event_status=="DONE"}
```

Разверните запись и проверьте новое описание в поле `meta.details.description`.

Чтобы найти событие создания трейла среди доставленных логов, выберите период, в который попадает время создания, и выполните запрос:

```text
{project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", trail_id=="<идентификатор_трейла>", meta.event_type=="{{ at-event-prefix }}.audit.audittrails.CreateTrail"}
```

В записи со статусом `DONE` сверьте идентификатор созданного трейла в поле `meta.details.trail_id`.

## Кто удалил каталог {#delete-folder}

Найдите событие удаления каталога [по идентификатору или имени](search-events-audit-logs/examples.md#delete-folder).

## Кто создал, изменил, запустил, остановил, перезапустил или удалил виртуальную машину {#vm-manage}

Используйте [запрос для поиска операций по идентификатору виртуальной машины](search-events-audit-logs/examples.md#any-actions-vm).

## Какие действия совершил пользователь за период {#user-actions}

Вверху страницы задайте начало и конец периода. {{ at-name }} передает в {{ monium-name }} время самого события. Чтобы найти действия пользователя, укажите его идентификатор:

```text
{project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.authentication.subject_id=="<идентификатор_пользователя>"}
```

Если известно имя пользователя, используйте [запрос для поиска действий по имени](search-events-audit-logs/examples.md#any-actions-user).

## Какие события произошли с ресурсами каталога {#folder-actions}

Каталог ресурса может отличаться от каталога с трейлом. Путь к ресурсу хранится в `meta.resource_metadata.path` как JSON-строка. Чтобы найти события по идентификатору каталога, укажите его в поле `resource_id` этого пути:

```text
{project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.resource_metadata.path=~'.*"resource_id"[[:space:]]*:[[:space:]]*"<идентификатор_каталога>".*'}
```

Если известно только имя каталога, найдите его в поле `resource_name`:

```text
{project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.resource_metadata.path=~'.*"resource_name"[[:space:]]*:[[:space:]]*"<имя_каталога>".*'}
```

Имя может совпасть с именем облака или организации. Разверните запись и проверьте, что у элемента с этим именем указан `resource_type` со значением `resource-manager.folder`. Скопируйте его `resource_id` и используйте первый запрос, чтобы отобрать события именно этого каталога.

## Какие операции завершились ошибкой доступа {#error}

Используйте [запрос для поиска ошибок доступа](search-events-audit-logs/examples.md#permission-denied).

## Что дальше {#whats-next}

* [Поля аудитного события](../concepts/format.md#scheme)
* [Язык запросов {{ monium-name }}](../../monium/logs/query.md)
