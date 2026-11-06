[Документация Yandex Cloud](../../../index.md) > [Yandex Audit Trails](../../index.md) > [Практические руководства](../index.md) > [Поиск событий в аудитных логах](index.md) > Инструменты для работы с аудитными логами

# Инструменты для работы с аудитными логами

Аудитные логи могут загружаться в бакет [Yandex Object Storage](../../../storage/index.md), лог-группу [Yandex Cloud Logging](../../../logging/index.md), поток данных [Yandex Data Streams](../../../data-streams/index.md).

Для просмотра логов в лог-группе используйте [Cloud Logging](#tool-logging), а для поиска событий в логах из бакета — [утилиту jq](#tool-jq).

## Cloud Logging {#tool-logging}

Сервис [Cloud Logging](../../../logging/index.md) применяется для работы с логами, которые загружаются в лог-группу.

Можно анализировать события ресурсов Yandex Cloud, фильтруя логи с помощью [языка фильтрующих выражений](../../../logging/concepts/filter.md).

Чтобы использовать Cloud Logging:

1. [Прочитайте логи в лог-группе](../../../logging/operations/read-logs.md).
1. [Отфильтруйте](examples.md) логи нужным образом.

## Утилита jq {#tool-jq}

Утилита [jq](https://jqlang.github.io/jq/) применяется для работы с логами, которые загружаются в бакет.

Логи хранятся в бакете в виде JSON-файлов. Поэтому можно анализировать события ресурсов Yandex Cloud, извлекая нужные события из файлов с помощью [фильтров](https://jqlang.github.io/jq/manual/) `jq`.

Чтобы использовать `jq`:

1. Установите и настройте программу [s3fs](../../../storage/tools/s3fs.md) или [goofys](../../../storage/tools/goofys.md), позволяющую монтировать бакеты Object Storage через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

1. Смонтируйте бакет с аудитными логами к вашей файловой системе через [s3fs](../../../storage/tools/s3fs.md#mounting-bucket) или [goofys](../../../storage/tools/goofys.md#bucket-mounting).

1. Установите утилиту [jq](https://stedolan.github.io/jq).

1. Выполните [команду](examples.md) с нужным фильтром `jq`.

{% note info %}

В примерах команд для работы с логами утилита `jq` используется в связке с утилитой `find`. Утилита `find` нужна, чтобы передать на обработку все файлы с логами, которые содержатся в бакете.

{% endnote %}