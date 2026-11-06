---
noIndex: true
canonical: '{{ link-docs }}/tutorials/security/search-events-audit-logs/tools'
---

# Инструменты для работы с аудитными логами

Аудитные логи могут загружаться в бакет [{{ objstorage-full-name }}](../../../storage/), лог-группу [{{ cloud-logging-full-name }}](../../../logging/), поток данных [{{ yds-full-name }}](../../../data-streams/).

Для просмотра логов в лог-группе используйте [{{ cloud-logging-name }}](#tool-logging), а для поиска событий в логах из бакета — [утилиту jq](#tool-jq).

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
