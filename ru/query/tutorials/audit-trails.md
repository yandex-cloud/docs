# Обработка аудитных логов {{ at-full-name }}

{{ at-full-name }} — сервис для сбора и выгрузки аудитных логов ресурсов {{ yandex-cloud }} в различные принимающие системы, в том числе в {{ objstorage-full-name }} и в {{ yds-full-name }}. {{ at-name }} и {{ yq-full-name }} интегрированы между собой, что позволяет решать задачи поиска в аудитных логах.

![](../../_assets/query/audit-trails-query.png)

Обработав аудитные логи с помощью {{ yq-name }}, можно получить, например, такую информацию:

* кто удалил каталог облака;
* кто добавил доступ к серийной консоли ВМ {{ compute-full-name }};
* кто изменил права на доступ к бакету {{ objstorage-name }};
* кто получил права администратора.

Заранее подготовленные запросы для таких сценариев доступны [в репозитории на GitHub](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches). Так же вы можете создавать свои собственные [запросы на языке YQL](../yql-tutorials/index.md).

В этом сценарии вы создадите [трейлы](../../audit-trails/concepts/trail.md), которые будут загружать аудитные логи всех ресурсов [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}, а также отправлять их в [поток](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}. Далее вы выполните аналитический и потоковый запросы к данным логов с помощью {{ yq-name }}.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Настройте {{ at-name }} {#at-setup}

Создайте трейлы:

* [для загрузки аудитных логов каталога в бакет {{ objstorage-name }}](../../audit-trails/operations/export-folder-bucket.md);
* [для отправки аудитных логов каталога в поток {{ yds-name }}](../../audit-trails/operations/export-folder-data-streams.md).

## Настройте интеграцию {{ at-name }} и {{ yq-name }} {#integration}

Чтобы настроить интеграцию:

1. Перейдите к списку трейлов в консоли {{ yandex-cloud }}.
1. Выберите созданный ранее трейл для загрузки аудитных логов облака в бакет и нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_process-in-yq }}**.
1. При первом переходе из {{ at-name }} в {{ yq-name }} необходимо выполнить настройку интеграции:
   1. В интерфейсе {{ yq-name }} в диалоге создания соединения выберите сервисный аккаунт, от имени которого будет выполнять чтение данных из {{ objstorage-name }} и нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
   1. В интерфейсе {{ yq-name }} в диалоге создания привязки к данным проверьте предустановленные параметры, нажав кнопку **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**, после чего завершите интеграцию, нажав кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

Вы будете автоматически перемещены на панель **{{ ui-key.yql.yq-audit-trails.audit-trails.title }}** интерфейса {{ yq-name }}.

Выполните аналогичные действия для созданного ранее трейла, который отправляет данные в поток {{ yds-name }}.

## Аналитические запросы к данным в {{ objstorage-name }}

Чтобы выполнить запрос к аналитическим данным {{ at-name }}, которые хранятся в {{ objstorage-name }}:

1. На панели **{{ ui-key.yql.yq-audit-trails.audit-trails.title }}** интерфейса {{ yq-name }} выберите тип анализа данных **{{ ui-key.yql.yq-audit-trails.audit-trails-type-toggle.option-analytical }}**, а в списке [привязок к данным](../../query/concepts/glossary.md#binding) выберите `audit-trails-test-object_storage`.
1. Выберите нужный запрос к данным из {{ objstorage-name }} из списка и нажмите кнопку **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

Результаты аналитического запроса можно:

* скачать через интерфейс пользователя {{ yq-name }} с помощью кнопки **Экспорт**;
* [сохранить в бакет](../../query/sources-and-sinks/object-storage-write.md) {{ objstorage-name }};
* получить и обработать через [{{ yq-name }} HTTP API](../api/index.md).
<!-- * [визуализировать](../../query/tutorials/datalens.md) в {{ datalens-full-name }}; -->

## Потоковые запросы к данным из {{ yds-name }}

Чтобы выполнить запрос к потоковым данным {{ at-name }}, которые передаются через {{ yds-name }}:

1. В разделе **{{ ui-key.yql.yq-audit-trails.audit-trails.title }}** в интерфейсе **{{ yq-full-name }}** выберите нужный тип анализа данных: **{{ ui-key.yql.yq-audit-trails.audit-trails-type-toggle.option-streaming }}**, а в списке [привязок к данным](../../query/concepts/glossary.md#binding) выберите нужную.
1. Выберите нужный запрос к данным из {{ objstorage-name }} из списка и нажмите кнопку **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.

Результаты потокового запроса можно:

* [отправить в {{ monitoring-full-name }}](../../query/sources-and-sinks/monitoring.md) в виде метрик;
* [отправить в выходной поток {{ yds-name }}](../../query/sources-and-sinks/data-streams-write.md) в виде данных, а далее обработать с помощью [триггеров {{ sf-full-name }}](../../functions/operations/trigger/data-streams-trigger-create.md).

## См. также

* [{{ objstorage-full-name }}](../../storage/).
* [{{ yds-full-name }}](../../data-streams/).
* [{{ datalens-full-name }}](../../datalens/).
