{% note info %}

{{ data-transfer-full-name }} не может переносить базы данных {{ CH }}, в названии которых есть дефис.

Если таблицы источника {{ CH }} будут содержать колонки следующих типов, трансфер завершится с ошибкой.

{% cut "Список неподдерживаемых типов" %}

| Тип                 | Пример ошибки                                                     |
|---------------------|-------------------------------------------------------------------|
| `Int128`            | `unhandled type Int128`                                           |
| `Int256`            | `unhandled type Int256`                                           |
| `UInt128`           | `unhandled type UInt128`                                          |
| `UInt256`           | `unhandled type UInt256`                                          |
| `Bool`              | `unhandled type Bool`                                             |
| `Date32`            | `unhandled type Date32`                                           |
| `JSON`              | `unhandled type '<имя_поля> <название_типа>'`                     |
| `Array(Date)`       | `Can't transfer type 'Array(Date)', column '<имя_колонки>'`       |
| `Array(DateTime)`   | `Can't transfer type 'Array(DateTime)', column '<имя_колонки>'`   |
| `Array(DateTime64)` | `Can't transfer type 'Array(DateTime64)', column '<имя_колонки>'` |
| `Map(,)`            | `unhandled type Map(<название_типа>, <название_типа>)`            |

{% endcut %}

При переносе таблиц с движками, отличными от движков на базе `ReplicatedMergeTree` и `Distributed`, в многохостовом кластере {{ CH }} трансфер завершится с ошибкой: `the following tables have not Distributed or Replicated engines and are not yet supported`.

{% endnote %}

{% list tabs %}

* {{ mch-name }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView).

       В случае многохостового кластера будут перенесены таблицы и материализованные представления только с движками на базе `ReplicatedMergeTree` либо `Distributed`. Проверьте, что данные таблицы и представления присутствуют на всех хостах кластера.

    1. [Создайте пользователя](../../../../managed-clickhouse/operations/cluster-users.md) с доступом к базе источника. В настройках пользователя укажите для [параметра](../../../mdb/mch-dbms-user-settings.md#setting-max-execution-time) **Max execution time**  значение не менее `1000000`.

* {{ CH }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView).

       В случае многохостового кластера будут перенесены таблицы и материализованные представления только с движками на базе `ReplicatedMergeTree` либо `Distributed`. Проверьте, что данные таблицы и представления присутствуют на всех хостах кластера.

    1. {% include notitle [White IP list](../../configure-white-ip.md) %}

    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external).

    1. Создайте пользователя с доступом к базе источника. В настройках пользователя укажите для параметра **Max execution time**  значение не менее `1000000`.

{% endlist %}
