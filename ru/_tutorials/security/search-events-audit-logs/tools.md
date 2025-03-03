# Инструменты для работы с аудитными логами

Аудитные логи могут загружаться в бакет [{{ objstorage-full-name }}](../../../storage/), лог-группу [{{ cloud-logging-full-name }}](../../../logging/), поток данных [{{ yds-full-name }}](../../../data-streams/).

В зависимости от того, где находятся логи, для их просмотра и поиска событий применяются различные инструменты:

* [сервис {{ yq-full-name }}](#tool-query),
* [сервис {{ cloud-logging-name }}](#tool-logging),
* [утилита jq](#tool-jq).

## {{ yq-full-name }} {#tool-query}

Сервис [{{ yq-name }}](../../../query/) применяется для работы с логами, которые загружаются в бакет или поток данных:

* Если логи находятся в бакете, то можно анализировать события ресурсов {{ yandex-cloud }}, выполняя [аналитические](../../../query/concepts/batch-processing.md) запросы на языке {{ yql-short-name }}.
* Если логи находятся в потоке данных, то можно анализировать события ресурсов {{ yandex-cloud }}, выполняя [потоковые](../../../query/concepts/stream-processing.md) запросы на языке {{ yql-short-name }}.

Чтобы использовать {{ yq-full-name }}, настройте привязку к данным в зависимости от объекта назначения:

{% list tabs group=instructions %}

* Бакет {{ objstorage-name }} {#obj-storage}

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с именем `bucket-yq-sa`.
    1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту `bucket-yq-sa` роль `storage.viewer` на каталог, в котором находится бакет с логами.
    1. Создайте соединение:

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится трейл, поставляющий логи в бакет.
        1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
        1. Выберите трейл, поставляющий логи в бакет.
        1. Нажмите **{{ ui-key.yacloud.audit-trails.button_process-in-yq }}**.
        1. Выберите **{{ ui-key.yacloud.common.resource-acl.label_service-account }}** `bucket-yq-sa`.
        1. Для остальных параметров оставьте значения по умолчанию.
        1. Нажмите **{{ ui-key.yacloud.common.create }}**.

    1. В окне с параметрами привязки к данным нажмите **{{ ui-key.yacloud.common.create }}**.

    1. Выполните нужный [запрос](../../../audit-trails/tutorials/search-events-audit-logs/examples.md).

* Поток данных {{ yds-name }} {#data-streams}

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с именем `bucket-yq-sa`.
    1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту `bucket-yq-sa` роль `yds.editor`.
    1. [Создайте соединение](../../../query/operations/connection.md#create). При создании укажите настройки для типа соединения **{{ yds-name }}**.
    1. [Создайте привязку](../../../query/operations/binding.md).
    1. Выполните нужный [запрос](../../../audit-trails/tutorials/search-events-audit-logs/examples.md).

{% endlist %}

## {{ cloud-logging-name }} {#tool-logging}

Сервис [{{ cloud-logging-name }}](../../../logging/) применяется для работы с логами, которые загружаются в лог-группу.

Можно анализировать события ресурсов {{ yandex-cloud }}, фильтруя логи с помощью [языка фильтрующих выражений](../../../logging/concepts/filter.md).

Чтобы использовать {{ cloud-logging-name }}:

1. [Прочитайте логи в лог-группе](../../../logging/operations/read-logs.md).
1. [Отфильтруйте](../../../audit-trails/tutorials/search-events-audit-logs/examples.md) логи нужным образом.

## Утилита jq {#tool-jq}

Утилита [jq](https://jqlang.github.io/jq/) применяется для работы с логами, которые загружаются в бакет.

Логи хранятся в бакете в виде JSON-файлов. Поэтому можно анализировать события ресурсов {{ yandex-cloud }}, извлекая нужные события из файлов с помощью [фильтров](https://jqlang.github.io/jq/manual/) `jq`.

Чтобы использовать `jq`:

1. Установите и настройте программу [s3fs](../../../storage/tools/s3fs.md) или [goofys](../../../storage/tools/goofys.md), позволяющую монтировать бакеты {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

1. Смонтируйте бакет с аудитными логами к вашей файловой системе через [s3fs](../../../storage/tools/s3fs.md#mounting-bucket) или [goofys](../../../storage/tools/goofys.md#bucket-mounting).

1. Установите утилиту [jq](https://stedolan.github.io/jq).

1. Выполните [команду](../../../audit-trails/tutorials/search-events-audit-logs/examples.md) с нужным фильтром `jq`.

{% note info %}

В примерах команд для работы с логами утилита `jq` используется в связке с утилитой `find`. Утилита `find` нужна, чтобы передать на обработку все файлы с логами, которые содержатся в бакете.

{% endnote %}
