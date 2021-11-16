# Загрузка больших объёмов данных

О загрузке больших объемов данных читайте в [документации](https://cloud.yandex.ru/docs/ydb/oss/public/develop/best_practices/batch_upload).

Пример реализации загрузки данных на [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/examples/batch_upload).

{% note warning %}

Настройка шардирования (Partitioning Policy) таблицы при ее создании в текущей версии возможна только через [С++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/client/ydb_table.h), [Java](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/table/src/settings/PartitioningPolicy.java) и [Python](https://a.yandex-team.ru/arc//trunk/arcadia/kikimr/public/sdk/python/client/table.py) SDK.

{% endnote %}
