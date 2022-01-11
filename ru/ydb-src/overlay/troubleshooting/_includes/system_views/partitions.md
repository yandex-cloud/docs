
{% include [header.md](partitions_header.md) %}

Примеры:

{% if audience != "external" %}

{% list tabs %}

- YQL

{% include [example_yql](partitions_example_yql.md) %}

- Clickhouse over YDB

{% include [example_ch](partitions_example_ch.md) %}

{% endlist %}

{% endif %}