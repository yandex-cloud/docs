---
title: Поиск аудитных событий в {{ monium-full-name }}
description: Как открыть аудитные логи {{ at-name }} в {{ monium-name }} и найти события по каталогу, виртуальной машине, пользователю или коду ошибки.
alternate:
  - href: ru/audit-trails/tutorials/search-cloud-logging.md
    type: text/markdown
    title: Markdown version
---

# Поиск аудитных событий в {{ monium-name }}

Для поиска аудитных событий в {{ monium-logs-name }} нужна роль [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с трейлом.

Если доставка в {{ monium-name }} еще не настроена, [создайте трейл](../operations/create-trail.md#monium). Чтобы перенаправить логи существующего трейла, [измените его объект назначения](../operations/manage-trail.md#update-trail).

## Как открыть аудитные логи {#monium}

{% include [view-logs-monium](../../_includes/audit-trails/view-logs-monium.md) %}

## Как выполнить поисковый запрос {#run-query}

Чтобы найти события за выбранный период:

1. Чтобы перейти в текстовый режим, нажмите ![code](../../_assets/console-icons/code.svg) справа над строкой запроса.
1. Вставьте запрос из примера. В значении метки `project` после префикса `folder__` укажите идентификатор каталога с трейлом. Если нужны только записи, которые доставил конкретный трейл, укажите его идентификатор в условии `trail_id=="<идентификатор_трейла>"`.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

## Как проверить доставку событий {#check-delivery}

Убедитесь, что тестовый трейл находится в статусе `Active` и собирает события уровня конфигурации в своем каталоге. [Измените описание трейла](../operations/manage-trail.md#update-trail). Выберите период, который включает время изменения, и найдите событие `UpdateTrail`:

```text
{project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", trail_id=="<идентификатор_трейла>", meta.event_type=="{{ at-event-prefix }}.audit.audittrails.UpdateTrail", meta.details.trail_id=="<идентификатор_трейла>", meta.event_status=="DONE"}
```

Разверните запись и проверьте новое описание в поле `meta.details.description`.

## Кто создал трейл {#create-trail}

Выберите период создания и проект, в который в это время поступали аудитные логи нужного каталога. Укажите идентификатор созданного трейла в поле `meta.details.trail_id`:

```text
{project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.event_type=="{{ at-event-prefix }}.audit.audittrails.CreateTrail", meta.event_status=="DONE", meta.details.trail_id=="<идентификатор_созданного_трейла>"}
```

В найденной записи поле `meta.authentication.subject_id` содержит идентификатор аккаунта, от имени которого создали трейл.

## Какие действия совершил пользователь за период {#user-actions}

Поиск в {{ monium-name }} учитывает время самого события. Чтобы найти действия пользователя за выбранный период, укажите его идентификатор:

```text
{project="folder__<идентификатор_каталога_трейла>", service="__audit-trails__", meta.authentication.subject_id=="<идентификатор_пользователя>"}
```

Для поиска по имени замените условие по идентификатору на `meta.authentication.subject_name=="<имя_пользователя>"`.

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

## Другие сценарии поиска {#other-queries}

Выберите, какие события нужно найти:

* <a id="delete-folder"></a>**Удаление каталога.** Найдите событие `DeleteFolder` со статусом `DONE`. Идентификатор инициатора указан в `meta.authentication.subject_id`. [Поиск по идентификатору или имени каталога](search-events-audit-logs/examples.md#delete-folder).
* <a id="vm-manage"></a>**Операции с виртуальной машиной.** Укажите идентификатор ВМ в поле `meta.details.instance_id` и отберите нужные типы событий. [Поиск операций с ВМ](search-events-audit-logs/examples.md#any-actions-vm).
* <a id="error"></a>**Отказ в доступе.** Найдите события со статусом `ERROR` и кодом ошибки `7` (`PERMISSION_DENIED`). [Поиск ошибок доступа](search-events-audit-logs/examples.md#permission-denied).

<a id="see-also"></a>

## Что дальше {#whats-next}

* [{#T}](../concepts/format.md)
* [{#T}](../concepts/format-data-plane.md)
* [Язык запросов {{ monium-name }}](../../monium/logs/query.md)
