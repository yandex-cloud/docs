
{% include [scan_query.md](_includes/scan_query.md) %}

{% if audience != "external" %}
### Web UI
Запуск запроса через интерфейс *Scan Query* возможен как через [web-интерфейс YQL](https://yql.yandex-team.ru), так и через *YQL Kit* в [web-интерфейсе YDB](https://ydb.yandex-team.ru).

В запросе требуется указать прагму `PRAGMA Kikimr.ScanQuery = "true";`.

{% note info %}

Для запросов, выполняемых через Web UI неявным образом устанавливается ограничение на 1000 строк.

Если в результате выполнения запроса было превышение, то клиенту отдаётся только первые 1000 строк и в интерфейсе отображается комментарий 
```
Table data is truncated.
```

{% endnote %}

{% endif %}