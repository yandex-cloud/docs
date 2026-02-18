# Рекомендуемые клиенты для СУБД {{ mch-name }}

Для подключения к {{ mch-short-name }} рекомендуется использовать следующие клиенты:

* [clickhouse-client](https://clickhouse.com/docs/ru/interfaces/cli) — штатный клиент командной строки;
* клиенты, которые используют {{ CH }} HTTP API и поддерживают SSL.

{{ mch-short-name }} не накладывает ограничений на использование остальных клиентов. Однако при их использовании ознакомьтесь с известными ограничениями и проблемами во избежание проблем с подключением и работой с кластером.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}


## См. также {#see-also}

* [{#T}](../operations/connect/clients.md)
* [{#T}](../operations/connect/code-examples.md)