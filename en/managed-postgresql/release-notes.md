# {{ mpg-full-name }} revision history

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.06.2022 {#01.06.2022}

* [Updates](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) from versions 14.3, 13.7, 12.11, 11.16, and 10.21 were installed.

## 01.05.2022 {#01.05.2022}

* Added the `max_logical_replication_workers` and `max_replication_slots` settings.

## 01.04.2022 {#01.04.2022}

* Added [extensions{{ PG }}](operations/cluster-extensions#postgresql) such as `pgcompacttable`, `clickhouse_fdw`, and `orafce`.
* Added the ability to create a new database from a template. {{ tag-con }}
