{% note alert "Важно" %}

При восстановлении резервной копии в кластер без хостов {{ ZK }}, все таблицы на движке семейства ReplicatedMergeTree будут преобразованы в простые MergeTree-таблицы. Данные в преобразованных таблицах сохраняются. Подробнее см. в [документации {{ CH }}](https://clickhouse.tech/docs/ru/engines/table-engines/mergetree-family/replication/).

{% endnote %}