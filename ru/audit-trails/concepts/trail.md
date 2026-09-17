---
title: Трейл
description: Из статьи вы узнаете, что такое трейл, какие у него есть настройки и доступные области сбора аудитных логов, объекты назначения.
---

# Трейл


Трейл — это ресурс {{ at-name }}, который собирает аудитные логи ресурсов {{ yandex-cloud }} и записывает их в [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}, [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }} или [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}.

## Сбор и фильтрация событий {#event-filters}

При [создании](../operations/create-trail.md) или [изменении](../operations/manage-trail.md) трейла можно выбрать, какие события он будет записывать в [объект назначения](#target).

### Область сбора {#collecting-area}

Область сбора определяет, откуда трейл получает события:

* организация — из всех или выбранных облаков текущей организации;
* облако — из всех или выбранных каталогов текущего облака;
* каталог — из текущего каталога.

Новые ресурсы в выбранной области включаются в сбор автоматически. К их событиям применяются те же условия отбора.

### Сбор событий уровня конфигурации {#control-plane-collection}

[События уровня конфигурации](./control-plane-vs-data-plane.md#control-plane-events) — действия по настройке облачных ресурсов, например создание ВМ или удаление кластера баз данных.

Для этого уровня задается только область сбора. В ней автоматически собираются события всех [поддерживаемых сервисов](events.md) без выбора сервисов и имен событий. Сбор можно включить или отключить целиком.

### Сбор событий уровня сервисов {#data-plane-collection}

Для [событий уровня сервисов](./control-plane-vs-data-plane.md#data-plane-events) выбираются сервисы, а для каждого из них — область сбора и условия отбора событий. Сбор можно отключить для всех или отдельных сервисов.

Доступны три варианта отбора событий:

* **{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_all }}** — все события, включая те, которые будут добавлены в будущем.
* **{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_include }}** (`included_events`) — только события с указанными именами. Список имен не пополняется автоматически.
* **{{ ui-key.yacloud.audit-trails.label_resource-manager_events-filter_exclude }}** (`excluded_events`) — все события, кроме указанных. Новые события будут собираться автоматически.

В одном фильтре имена событий можно указать только в одном из блоков: `included_events` или `excluded_events`. Если ни один из блоков не задан, собираются все события сервиса с учетом остальных условий фильтра.

Имена событий приведены в [справочнике событий уровня сервисов](events-data-plane.md). В CLI, {{ TF }} и API используйте полное имя из поля `event_type` аудитного лога, например `yandex.cloud.audit.iam.CreateIamToken`.

#### Условия по значениям полей {#field-filters}

Через CLI, {{ TF }} и API фильтр событий уровня сервисов можно дополнить условиями по значениям полей, например исключить события определенного пользователя. Эти условия действуют вместе с выбором области сбора и имен событий.

{% include [field-filter-rules](../../_includes/audit-trails/field-filter-rules.md) %}

Примеры фильтров приведены в разделе [{#T}](../operations/create-trail.md#filter-examples).

## Предустановленные события {#default}

При создании трейла в [консоли управления]({{ link-console-main }}) по умолчанию включен сбор некоторых событий [уровня сервисов](./events-data-plane.md). Это сделано для обеспечения безопасности и соответствует [стандарту](../../security/standard/audit-logs.md#audit-trails) по защите облачной инфраструктуры. Если сервис не используется, события можно отключить. Доставленные события тарифицируются в соответствии с [правилами тарификации](../pricing.md).

Сервисы, для которых включена отправка событий по умолчанию:

#|
|| **Сервис** | **События** ||
|| [{{ certificate-manager-full-name }}](../../certificate-manager/at-ref.md#data-plane-events) | Все события ||
|| [{{ iam-full-name }}](../../iam/at-ref.md#data-plane-events) | Все события ||
|| [{{ kms-full-name }}](../../kms/at-ref.md#data-plane-events) | Все события ||
|| [{{ lockbox-full-name }}](../../lockbox/at-ref.md#data-plane-events) | Все события ||
|| [{{ mmy-full-name }}](../../managed-mysql/at-ref.md#data-plane-events) |
* `yandex.cloud.audit.mdb.mysql.CreateDatabase`
* `yandex.cloud.audit.mdb.mysql.CreateUser`
* `yandex.cloud.audit.mdb.mysql.DeleteDatabase`
* `yandex.cloud.audit.mdb.mysql.DeleteUser`
* `yandex.cloud.audit.mdb.mysql.GrantUserPermission`
* `yandex.cloud.audit.mdb.mysql.RevokeUserPermission`
* `yandex.cloud.audit.mdb.mysql.UpdateUser`
||
|| [{{ mpg-full-name }}](../../managed-postgresql/at-ref.md#data-plane-events) |
* `yandex.cloud.audit.mdb.postgresql.CreateDatabase`
* `yandex.cloud.audit.mdb.postgresql.CreateUser`
* `yandex.cloud.audit.mdb.postgresql.DeleteDatabase`
* `yandex.cloud.audit.mdb.postgresql.DeleteUser`
* `yandex.cloud.audit.mdb.postgresql.GrantUserPermission`
* `yandex.cloud.audit.mdb.postgresql.RevokeUserPermission`
* `yandex.cloud.audit.mdb.postgresql.UpdateDatabase`
* `yandex.cloud.audit.mdb.postgresql.UpdateUser`
||
|#

## Объект назначения {#target}

Каждый трейл загружает аудитные логи только в один объект назначения: бакет, лог-группу или поток данных.

#|
|| **Назначение** | **Когда использовать** | **Задержка** | **Формат** ||
|| Бакет {{ ui-key.yacloud.audit-trails.label_objectStorage }} | Долгосрочное хранение, соответствие требованиям | 5 мин | Массив JSON ||
|| Лог-группа {{ ui-key.yacloud.audit-trails.label_cloudLogging }} | Мониторинг в реальном времени | секунды | Поток записей {{ cloud-logging-name }}: одно событие {{ at-name }} соответствует одной записи {{ cloud-logging-name }} ||
|| Поток данных {{ ui-key.yacloud.audit-trails.label_dataStream }} | Интеграция с SIEM, аналитика | секунды | Поток JSON-объектов ||
|#

Каждый объект назначения имеет свои преимущества:

* **{{ ui-key.yacloud.audit-trails.label_objectStorage }}** — позволяет долговременно хранить большие объемы данных для дальнейшей обработки.
* **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}** — помогает реагировать на события и анализировать логи в реальном времени.
* **{{ ui-key.yacloud.audit-trails.label_dataStream }}** — позволяет передавать данные в другие сервисы и системы с помощью потоковой передачи.

При загрузке аудитных логов в бакет {{ at-name }} формирует файлы приблизительно раз в 5 минут. В один или несколько файлов попадут события из выбранной области сбора, которые прошли фильтрацию. Если за этот период подходящих событий не будет, файлы не сформируются.

В лог-группу и поток данных {{ at-name }} загружает аудитные логи в режиме, близком к реальному времени.

От типа объекта назначения зависит структура и содержимое сообщения, в котором {{ at-name }} передает аудитные логи:

* для бакета — в файле находится массив [JSON-объектов](./format.md#scheme) аудитного лога;
* для лог-группы — в сообщении находится только один JSON-объект аудитного лога;
* для потока данных — в поток передаются сообщения, содержащие JSON-объекты аудитного лога.

{% include [note-lose-target-when-switch-trail](../../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

Каждый трейл действует независимо от других трейлов. Используя несколько трейлов, можно разграничивать доступ к разным группам логов для пользователей и сервисов в соответствии с требованиями политики ИБ.

## Настройки трейла {#trail-settings}

В консоли управления доступны следующие настройки трейла:

* **{{ ui-key.yacloud.common.name }}** — обязательный параметр.
* **{{ ui-key.yacloud.common.description }}** — опциональный параметр.
* Блок **{{ ui-key.yacloud.audit-trails.label_destination }}**:
    * **{{ ui-key.yacloud.audit-trails.label_destination }}** — значения `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`, `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}` или `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`:
        * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — бакет.
        * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](./format.md#log-file-name) файла аудитного лога.
        * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — симметричный [ключ шифрования](../../kms/concepts/key.md) {{ kms-full-name }}, которым будет зашифрован бакет.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`:
        * **{{ ui-key.yacloud.logging.label_loggroup }}** — лог-группа.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_dataStream }}`:
        * **{{ ui-key.yacloud.audit-trails.label_stream-name }}** — поток данных.
        * **Кодек** — метод сжатия событий при записи в поток данных {{ yds-name }}.

            {% include [yds-compressing-events](../../_includes/audit-trails/yds-compressing-events.md) %}
* Блок **{{ ui-key.yacloud.audit-trails.label_service-account }}** — сервисный аккаунт, от имени которого будет выполняться загрузка аудитных логов в бакет, лог-группу или поток данных. Если аккаунту нужны дополнительные роли, появится предупреждение с перечнем ролей.
* Блок **{{ ui-key.yacloud.audit-trails.label_control-plane-collection-new }}**:
    * **Статус** — включение и выключение сбора аудитных логов уровня конфигурации.
    * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — значения `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` или `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`:
        * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}** – имя текущей организации. Значение подставляется автоматически.
    * Для значения `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`:
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** — имя облака, в котором находится текущий трейл. Значение подставляется автоматически.
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — каталоги, для ресурсов в которых трейл будет собирать аудитные логи уровня конфигурации. Если не указать ни один каталог, то трейл будет собирать аудитные логи всех ресурсов в облаке.
    * Для параметра `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`:
        * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — имя каталога, в котором находится трейл. Значение подставляется автоматически.
* Блок **{{ ui-key.yacloud.audit-trails.label_data-plane-collection-new }}**:
    * **Статус** — включение и выключение сбора аудитных логов уровня сервисов.
    * Список [сервисов](events-data-plane.md), для каждого из которых отдельно настраивается:
        * [Область](trail.md#collecting-area) сбора аудитных логов уровня сервисов.
        * Тип фильтра событий:
            * `Получать все` — для получения всех событий сервиса.
            * `Выбранные` — для получения только выбранных событий.
            * `Исключить` — для получения всех событий, кроме выбранных.
        * Список [событий](events-data-plane.md), если выбран тип фильтра `Выбранные` или `Исключить`.


## Примеры использования {#examples}

* [{#T}](../tutorials/search-events-audit-logs/index.md)
* [{#T}](../tutorials/alerts-monitoring.md)
* [{#T}](../tutorials/logging-functions.md)
* [{#T}](../tutorials/audit-trails.md)
* [{#T}](../tutorials/maxpatrol/index.md)
* [{#T}](../tutorials/export-logs-to-splunk.md)
* [{#T}](../tutorials/export-logs-to-arcsight.md)
* [{#T}](../tutorials/audit-trails-events-to-kuma/console.md)


## Что дальше {#whats-next}

* Узнайте о [формате аудитных логов](./format.md).
* Ознакомьтесь с [логами диагностики трейла](./diagnostics.md).
* Узнайте о [событиях](./events.md).
