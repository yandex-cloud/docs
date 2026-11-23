Аудитные логи можно загружать в {{ monium-logs-name }}, бакет [{{ objstorage-full-name }}](../../../storage/) или поток данных [{{ yds-full-name }}](../../../data-streams/).

Для просмотра логов в {{ monium-logs-name }} используйте [интерфейс {{ monium-name }}](#tool-monium), а для поиска событий в логах из бакета — [утилиту jq](#tool-jq).

## {{ monium-name }} {#tool-monium}

{% list tabs group=audit-trails-destination %}

- {{ monium-name }} {#monium}

  [Откройте аудитные логи в {{ monium-name }}](../../../audit-trails/tutorials/search-monium.md) и просмотрите поля записи.

{% endlist %}

## Утилита jq {#tool-jq}

Логи в бакете хранятся в JSON-файлах. Для поиска используйте `find`, чтобы выбрать файлы, и [jq](https://jqlang.org/), чтобы отфильтровать записи.

[Смонтируйте бакет и установите jq](../../../audit-trails/tutorials/search-bucket.md#before-you-begin), затем [выполните команду для нужного сценария](../../../audit-trails/tutorials/search-bucket.md#search).
