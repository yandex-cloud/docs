# История изменений в {{ mpg-full-name }}

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.06.2022 {#01.06.2022}

* Установлены [обновления](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) из версий 14.3, 13.7, 12.11, 11.16 и 10.21.

## 01.05.2022 {#01.05.2022}

* Добавлены настройки `max_logical_replication_workers` и `max_replication_slots`.

## 01.04.2022 {#01.04.2022}

* Добавлены [расширения {{ PG }}](operations/cluster-extensions#postgresql) `pgcompacttable`, `clickhouse_fdw` и `orafce`. 
* Добавлена возможность создания новой базы данных из шаблона. {{ tag-con }}
