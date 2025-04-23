---
title: Трейл
description: Из статьи вы узнаете, что такое трейл, какие у него есть настройки и доступные области сбора аудитных логов, объекты назначения.
---

# Трейл


Трейл — это ресурс {{ at-name }}, который собирает аудитные логи ресурсов {{ yandex-cloud }} и записывает их в [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}, [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }} или [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}.

## Область сбора аудитных логов {#collecting-area}

В настройках трейла можно выбрать область сбора аудитных логов:
* организация — аудитные логи ресурсов сервисов в выбранных облаках организации;
* облако — аудитные логи ресурсов сервисов, которые находятся в выбранных каталогах облака;
* каталог — аудитные логи каталога.

Трейл будет собирать логи всех [ресурсов](./events.md), которые находятся в заданной области сбора, в том числе ресурсов, которые будут добавлены в область после создания трейла.

Для тех ресурсов, которые были добавлены в область сбора аудитных логов уже после создания трейла, сбор аудитных логов начнется автоматически.

Для [событий уровня конфигурации](./control-plane-vs-data-plane.md#control-plane-events) область сбора содержит все поддерживаемые [сервисы {{ yandex-cloud }}](../../overview/concepts/services.md#list).

Для [событий уровня сервисов](./control-plane-vs-data-plane.md#data-plane-events) область сбора задается отдельно для каждого сервиса.

В любой момент вы можете отключить сбор всех событий уровня конфигурации или сбор событий уровня сервисов для какого-либо одного или нескольких сервисов.

## Объект назначения {#target}

Каждый трейл загружает аудитные логи только в один объект назначения: бакет, лог-группу или поток данных.

{% include [note-lose-target-when-switch-trail](../../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

При загрузке аудитных логов в бакет {{ at-name }} формирует файлы аудитных логов приблизительно раз в 5 минут. Трейл запишет все [события](./events.md), которые произошли за это время с ресурсами облака, в один или несколько файлов. Если никакие события за этот период не произойдут, файлы не сформируются.

В лог-группу {{ at-name }} загружает аудитные логи в режиме, близком к реальному времени.

От типа объекта назначения зависит структура и содержимое сообщения, в котором {{ at-name }} передает аудитные логи:
* для бакета — в файле находится массив [JSON-объектов](./format.md#scheme) аудитного лога;
* для лог-группы — в сообщении находится только один JSON-объект аудитного лога.
* для потока данных — в поток передаются сообщения, содержащие JSON-объекты аудитного лога.

Каждый трейл действует независимо от других трейлов. Используя несколько трейлов, можно разграничивать доступ к разным группам логов для пользователей и сервисов в соответствии с требованиями политики ИБ.

## Настройки трейла {#trail-settings}

Трейл содержит в себе все настройки аудитного лога:
* **{{ ui-key.yacloud.common.name }}** — обязательный параметр.
* **{{ ui-key.yacloud.common.description }}** — опциональный параметр.
* Блок **{{ ui-key.yacloud.audit-trails.label_destination }}**:
    * **{{ ui-key.yacloud.audit-trails.label_destination }}** — значения `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`, `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}` или `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`:
        * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — имя бакета.
        * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](./format.md#log-file-name) файла аудитного лога.
        * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — симметричный [ключ шифрования](../../kms/concepts/key.md) {{ kms-full-name }}, которым будет зашифрован бакет.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`:
        * **{{ ui-key.yacloud.logging.label_loggroup }}** — имя лог-группы.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_dataStream }}`:
        * **{{ ui-key.yacloud.audit-trails.label_stream-name }}** — имя потока данных.
* Блок **{{ ui-key.yacloud.audit-trails.label_service-account }}** — сервисный аккаунт, от имени которого будет выполняться загрузка аудитных логов в бакет, лог-группу или поток данных. Если аккаунту нужны дополнительные роли, появится предупреждение с перечнем ролей.
* Блок **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}**:
    * **Статус** — включение и выключение сбора аудитных логов уровня конфигурации.
    * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — значения `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` или `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`:
        * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}** – имя текущей организации. Значение подставляется автоматически.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`:
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** — имя облака, в котором находится текущий трейл. Значение подставляется автоматически.
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — каталоги, для ресурсов в которых трейл будет собирать аудитные логи уровня конфигурации. Если не указать ни один каталог, то трейл будет собирать аудитные логи всех ресурсов в облаке.
    * Для параметра `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`:
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — имя каталога, в котором находится трейл. Значение подставляется автоматически.
* Блок **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**:
    * **Статус** — включение и выключение сбора аудитных логов уровня сервисов.
    * Список [сервисов](events-data-plane.md#services), для каждого из которых отдельно настраивается:
        * [Область](trail.md#collecting-area) сбора аудитных логов уровня сервисов.
        * Тип фильтра событий:
            * `Получать все` — для получения всех событий сервиса.
            * `Выбранные` — для получения только выбранных событий.
            * `Исключить` — для получения всех событий, кроме выбранных.
        * Список [событий](events-data-plane.md#dns), если выбран тип фильтра `Выбранные` или `Исключить`.


## Примеры использования {#examples}

* [{#T}](../tutorials/search-events-audit-logs/index.md)
* [{#T}](../tutorials/alerts-monitoring.md)
* [{#T}](../tutorials/logging-functions.md)
* [{#T}](../tutorials/audit-trails.md)
* [{#T}](../tutorials/maxpatrol.md)
* [{#T}](../tutorials/export-logs-to-splunk.md)
* [{#T}](../tutorials/export-logs-to-arcsight.md)
* [{#T}](../tutorials/audit-trails-events-to-kuma/console.md)


## Что дальше {#whats-next}

* Узнайте о [формате аудитных логов](./format.md).
* Ознакомьтесь с [логами диагностики трейла](./diagnostics.md).
* Узнайте о [событиях](./events.md).
