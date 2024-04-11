{% list tabs %}

* {{ mch-name }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView).
    1. [Создайте пользователя](../../../../managed-clickhouse/operations/cluster-users.md) с доступом к базе источника. В настройках пользователя укажите для [параметра](../../../mdb/mch-dbms-user-settings.md#setting-max-execution-time) **Max execution time**  значение не менее `1000000`.

* {{ CH }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView).
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}

    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external).

    1. Создайте пользователя с доступом к базе источника. В настройках пользователя укажите для параметра **Max execution time**  значение не менее `1000000`.

{% endlist %}