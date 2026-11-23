[Документация Yandex Cloud](../../../index.md) > [Yandex Data Streams](../../index.md) > [Практические руководства](../index.md) > [Поиск событий в аудитных логах](index.md) > Инструменты для работы с аудитными логами

# Инструменты для работы с аудитными логами

Аудитные логи можно загружать в Monium Logs, бакет [Yandex Object Storage](../../../storage/index.md) или поток данных [Yandex Data Streams](../../index.md).

Для просмотра логов в Monium Logs используйте [интерфейс Monium](#tool-monium), а для поиска событий в логах из бакета — [утилиту jq](#tool-jq).

## Monium {#tool-monium}

{% list tabs group=audit-trails-destination %}

- Monium {#monium}

  [Откройте аудитные логи в Monium](../../../audit-trails/tutorials/search-monium.md) и просмотрите поля записи.

{% endlist %}

## Утилита jq {#tool-jq}

Логи в бакете хранятся в JSON-файлах. Для поиска используйте `find`, чтобы выбрать файлы, и [jq](https://jqlang.org/), чтобы отфильтровать записи.

[Смонтируйте бакет и установите jq](../../../audit-trails/tutorials/search-bucket.md#before-you-begin), затем [выполните команду для нужного сценария](../../../audit-trails/tutorials/search-bucket.md#search).