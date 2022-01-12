---
sourcePath: overlay/best_practices/batch_upload.md
---
{% include [batch_upload.md](_includes/batch_upload.md) %}

{% if audience == "internal" or audience == "tech" %}

## Cсылки на Arcadia

Настройка шардирования (Partitioning Policy) таблицы при ее создании для различных SDK:

* [С++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/client/ydb_table.h)
* [Java](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/table/src/settings/PartitioningPolicy.java)
* [Python](https://a.yandex-team.ru/arc//trunk/arcadia/kikimr/public/sdk/python/client/table.py)

{% endif %}
