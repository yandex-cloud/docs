
{% include [header.md](tops_header.md) %}

Примеры:

{% if audience != "external" %}

{% list tabs %}

- YQL

{% include [example_yql.md](tops_example_yql.md) %}

- Clickhouse over YDB

{% include [example_ch](tops_example_ch.md) %}

{% endlist %}

{% endif %}